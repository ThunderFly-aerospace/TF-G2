//@set_slicing_config(../../slicing/sides.ini)

//dil pro pripevneni tazneho motoru
include <../../parameters.scad>
use <../888_1003.scad>

$fn = 50;

translate([22, 50, 0]) 888_1003_part(0);
translate([-0, 0, 0]) mirror([0, 1, 0]) 888_1003_part(0);
