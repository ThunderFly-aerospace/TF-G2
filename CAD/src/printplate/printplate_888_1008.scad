//@set_slicing_config(../../slicing/sides.ini)

//dil pro pripevneni tazneho motoru
include <../../parameters.scad>
use <../888_1008.scad>

translate([17, -47, 0])
    888_1008();
translate([-17, 47, 0])
        rotate([0, 0, 180])
    888_1008();
