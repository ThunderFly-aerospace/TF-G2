//@set_slicing_config(../../slicing/sides.ini)

//dil pro pripevneni tazneho motoru
include <../../parameters.scad>
use <../888_1009.scad>

rotate([0, 0, 50])
translate([0, 0, 10])
888_1009();
