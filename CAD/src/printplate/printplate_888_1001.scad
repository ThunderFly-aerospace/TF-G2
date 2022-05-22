//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni tazneho motoru
include <../../parameters.scad>
use <../888_1001.scad>

$fn=20;

translate([0, -base_width/2-2, 0]) 888_1001_part_0();
translate([-base_split_position[1], base_width/2+2, 0]) 888_1001_part_1();
