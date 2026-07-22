"""Headless PNG preview renderer for TF-G2 OpenSCAD parts/assemblies.

Usage:
    python3 -m tools.render_preview 888_1003
    python3 -m tools.render_preview 888_1003 --views iso,top,front,right
    python3 -m tools.render_preview ../assembly/full_assembly.stl
    python3 -m tools.render_preview 888_1001 888_1002  # overlaid

A target is either a bare part name, resolved against CAD/stl/<name>.stl
(where the normal build already drops one STL per part - see CAD/src/tools/
../../stl), or an explicit path to any .stl file - e.g. one freshly built
by hand with `openscad -o /tmp/x.stl CAD/src/assembly/full_assembly.scad`
for a whole-assembly check. This tool does not invoke openscad itself: it
only renders whatever .stl mesh already exists on disk. Building the
assembly STL is a separate (and for the full assembly, slow - CSG union of
the whole autogyro takes several minutes) step; keeping that out of this
tool means a render never silently triggers a multi-minute rebuild.

Renders to CAD/src/previews/ by default: one PNG per view, plus a small
JSON sidecar with bounding box / volume. Uses VTK off-screen rendering (no
blender, no xvfb, no display required) so it works from a plain shell -
including one launched by an AI coding agent.

This is a thin TF-G2-specific wrapper: the actual VTK/PIL rendering core,
and the STLPart adapter that lets a raw .stl mesh quack like the
build123d Part cad_preview_tools.render expects (this repo has no CAD
kernel in the loop - OpenSCAD compiles straight to .stl, no Python object
ever wraps it), both live in a separate internal `cad_preview_tools`
package (ThunderFly-internal, not published here since its source lives
in a private repo - ask a maintainer for access/install instructions).
What's specific to this repo is just resolving a target string to a path
in CAD/stl/.

Not vendored, not yet pinned in any requirements file (this repo has none
- CI installs everything ad-hoc via pip in the workflow ymls). Install
the internal `cad_preview_tools` package into whatever Python environment
runs this (pulls in numpy-stl automatically, it's a declared dependency),
then, from CAD/src:

    python3 -m tools.render_preview 888_1003

Note this renders whatever geometry the target STL already contains - it
does not know about parts commented out of assembly.scad/full_assembly.scad
upstream. A part missing from the assembly render means it's missing from
the .scad include list, not a bug in this tool.

Separate from CI's blender pipeline (.github/workflows/render_previews.yml,
build_manual/): that one produces the presentation/documentation-quality
renders (build manual figures, positioned by blend files). This tool is
for fast iteration while fixing the assembly, not a replacement for it.
"""

import argparse
import json
import os

from cad_preview_tools import STLPart
from cad_preview_tools.render import DEFAULT_VIEWS, VIEW_DIRECTIONS, render_parts_to_png

STL_DIR = os.path.normpath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../stl"))


def _resolve_part(target: str):
    """Resolve a bare part name (against CAD/stl/) or an explicit .stl path."""
    path = target if target.endswith(".stl") else os.path.join(STL_DIR, f"{target}.stl")
    if not os.path.isfile(path):
        raise FileNotFoundError(
            f"no STL at {path!r} - build it first (e.g. via `make` in the "
            "relevant CAD/src directory, or a direct openscad -o ... call)"
        )
    return STLPart(path)


def render_target(target, out_dir: str = "previews", views=None, size=(800, 600), tolerance=0.1, name=None):
    """Render one or more targets (part names or .stl paths) together.

    A single target renders to previews/<name>. Several targets (list)
    render overlaid in one image, named after all of them joined by '+' by
    default - useful to compare two revisions of a part, or a part against
    a neighbour it mounts to. Pass `name` to use a clean name instead (e.g.
    "assembly") when overlaying many parts at once, where the joined name
    would otherwise be unwieldy.

    Writes one PNG per view plus a JSON sidecar with bbox/volume (per
    target). Returns the list of written paths (PNGs then the JSON).
    """
    targets = [target] if isinstance(target, str) else list(target)
    parts = [_resolve_part(t) for t in targets]

    def base_name(t):
        return os.path.splitext(os.path.basename(t))[0]

    out_path_prefix = os.path.join(out_dir, name or "+".join(base_name(t) for t in targets))

    written = render_parts_to_png(parts, out_path_prefix, views=views, size=size, tolerance=tolerance)

    info = []
    for t, part in zip(targets, parts):
        bbox = part.bounding_box()
        info.append({
            "target": t,
            "bbox_min": [bbox.min.X, bbox.min.Y, bbox.min.Z],
            "bbox_max": [bbox.max.X, bbox.max.Y, bbox.max.Z],
            "volume": part.volume,
        })
    info_path = f"{out_path_prefix}.json"
    with open(info_path, "w") as f:
        json.dump(info if len(info) > 1 else info[0], f, indent=2)

    return written + [info_path]


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("target", nargs="+",
                         help="part name (resolved against CAD/stl/<name>.stl) or an "
                              "explicit path to any .stl file. Pass several to render "
                              "them overlaid in one image.")
    parser.add_argument("--views", default=",".join(DEFAULT_VIEWS),
                         help=f"comma-separated views from {sorted(VIEW_DIRECTIONS)} (default: %(default)s)")
    parser.add_argument("--out-dir", default="previews")
    parser.add_argument("--size", default="800x600", help="WIDTHxHEIGHT (default: %(default)s)")
    parser.add_argument("--tolerance", type=float, default=0.1)
    parser.add_argument("--name", default=None,
                         help="output name when overlaying several targets, instead of "
                              "the default '+'-joined name (e.g. --name assembly)")
    args = parser.parse_args()

    views = [v.strip() for v in args.views.split(",")]
    width, height = (int(x) for x in args.size.split("x"))

    written = render_target(args.target, out_dir=args.out_dir, views=views,
                             size=(width, height), tolerance=args.tolerance, name=args.name)
    for path in written:
        print(path)


if __name__ == "__main__":
    main()
