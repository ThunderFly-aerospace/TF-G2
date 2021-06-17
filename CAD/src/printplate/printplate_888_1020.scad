//@set_slicing_config(slicing/default.ini)
//battery screw cap

use <../888_1020.scad>

for (i = [0, 24], j = [0, 24])
    translate([i, j, 0])
        888_1020();
