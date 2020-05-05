//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni tazneho motoru
include <../../../parameters.scad>
use <../../888_1001.scad>

translate([base_patern, 0, 0]) 888_1001();
