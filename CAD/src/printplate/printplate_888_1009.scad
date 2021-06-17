//@set_slicing_config(../../slicing/sides.ini)

//dil pro pripevneni tazneho motoru
include <../../parameters.scad>
use <../888_1009.scad>

rotate([180, 0, 0])
translate([0, 0, -5])
888_1009_top();

888_1009_bottom();
