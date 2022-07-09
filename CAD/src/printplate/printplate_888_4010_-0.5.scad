//@set_slicing_config(../../slicing/freeflap.ini)
include <../../parameters.scad>
use <../888_4009.scad>
use <../888_4010.scad>

dst2=10;
collective=-0.5;

translate([0,-dst2,free_flap_blade_w/2])
    rotate([90-collective,0,0,])
        888_4010(collective);

translate([0,dst2,free_flap_blade_w/2])
    rotate([90-collective,0,0,])
        888_4010(collective);