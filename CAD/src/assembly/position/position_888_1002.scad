//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni tazneho motoru
include <../../../parameters.scad>
use <../../888_1002.scad>

translate([base_patern*4, 0, 0])
rotate([0, 0, -90])
    888_1002();
