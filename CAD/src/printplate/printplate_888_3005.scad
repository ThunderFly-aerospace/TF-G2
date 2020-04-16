//@set_slicing_config(../../slicing/tail.ini)

//dil pro pripevneni tazneho motoru
include <../../parameters.scad>
use <../888_3005.scad>

rotate(0)
rotate([-90, 0, 0])
    888_3005();
translate([0, 10, 0])
rotate([-90, 0, 0])
    888_3005();
