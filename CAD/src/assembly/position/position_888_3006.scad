//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni tazneho motoru
include <../../../parameters.scad>
use <../../888_3006.scad>

translate([base_patern*28, 0, -base_thickness-4]) rotate([180, 0, 0]) 888_3006();
translate([base_patern*(28-2*4), 0, -base_thickness-4]) rotate([180, 0, 0]) 888_3006();
