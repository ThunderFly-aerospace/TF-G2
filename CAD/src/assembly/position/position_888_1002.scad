//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni tazneho motoru
include <../../../parameters.scad>
use <../../888_1002.scad>

translate([base_patern*2, 0, -rantl_height/2])
rotate([0, 0, -180])
    888_1002();
