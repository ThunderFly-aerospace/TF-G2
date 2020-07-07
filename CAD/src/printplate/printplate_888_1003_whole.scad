//@set_slicing_config(../../slicing/sides.ini)

//dil pro pripevneni tazneho motoru
include <../../parameters.scad>
use <../888_1003.scad>

$fn = 50;

translate([0, -52, 0]) 888_1003();
translate([0, 52, 0]) mirror([0, 1, 0]) 888_1003();
