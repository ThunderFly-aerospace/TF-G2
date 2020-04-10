//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni tazneho motoru
include <../../parameters.scad>
use <../888_1001.scad>

translate([0, -base_width/2-2, 0]) 888_1001_part(0);
translate([0, base_width/2+2, 0]) 888_1001_part(1);
