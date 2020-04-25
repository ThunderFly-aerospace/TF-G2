//@set_slicing_config(../../slicing/sides.ini)

//dil pro pripevneni tazneho motoru
include <../../parameters.scad>
use <../888_1003.scad>

$fn=50;

888_1003_part(2);
translate([88, 70, 0]) rotate([0, 0, 180]) 888_1003_part(2);
