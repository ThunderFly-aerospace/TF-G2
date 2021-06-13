include <../../parameters.scad>
use <../888_4009.scad>
use <../888_4010.scad>

translate([0,0,free_flap_blade_w/2])
    rotate([90-free_flap_colective,0,0,])
        888_4010();