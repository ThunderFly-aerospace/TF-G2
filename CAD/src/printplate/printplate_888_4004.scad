//@set_slicing_config(../../slicing/blade_center_parts.ini)

//Spodni podlozky rotoru
include <../../parameters.scad>

use <../888_4004.scad>

translate([0, 15, 0]) 888_4004();
translate([0, -10, 0]) 888_4004();
