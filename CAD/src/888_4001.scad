//// ThunderFly TF-G2 3D printable Rotor blade


DOC_SCALING_FACTOR = 100;
DOC_HEIGHT = 50;

include <lib/stdlib/dimlines.scad>

DIM_LINE_WIDTH = .025 * DOC_SCALING_FACTOR;
DIM_SPACE = .1 * DOC_SCALING_FACTOR;



include <../parameters.scad>
use <lib/stdlib/naca4.scad>

include <lib/PrintedRotor/RotorBlade.scad>
