//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni tazneho motoru
include <../../parameters.scad>
use <../888_1007.scad>
use <../888_1008.scad>


888_1008();
translate([0, 0, -3]) 888_1007();

