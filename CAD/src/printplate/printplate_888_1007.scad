//@set_slicing_config(../../slicing/sides.ini)

//dil pro pripevneni tazneho motoru
include <../../parameters.scad>
use <../888_1007.scad>

translate([25, -55, 0])
    888_1007();
translate([-30, 55, 0])
        rotate([0, 0, 180])
    888_1007();
