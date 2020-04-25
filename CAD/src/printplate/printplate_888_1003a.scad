//@set_slicing_config(../../slicing/sides.ini)

//dil pro pripevneni tazneho motoru
include <../../parameters.scad>
use <../888_1003.scad>

$fn = 50;

888_1003_part(0);
translate([110, -20, 0]) rotate([0, 0, 180]) 888_1003_part(0);
