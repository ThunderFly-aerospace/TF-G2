include <../../parameters.scad>

DOC_SCALING_FACTOR = 100;
DOC_HEIGHT = 50;

include <../lib/stdlib/dimlines.scad>

DIM_LINE_WIDTH = .025 * DOC_SCALING_FACTOR;
DIM_SPACE = .1 * DOC_SCALING_FACTOR;

use <../888_4001.scad>

projection(cut = false)
    translate([0, 20, 0])
        rotate([-90,0,-90])
            888_4001_doc();
