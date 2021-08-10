include <../../../parameters.scad>
include <../../lib/NopSCAD/core.scad>
use <../../888_1002.scad>


for(x = [10, 20, 90, 180, 280])
    translate([x, -70/2-50, 0])
        rotate([90, 0, 0])
            screw(M3_dome_screw, 10);

