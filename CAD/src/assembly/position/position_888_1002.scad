//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni tazneho motoru
use <../../888_1002.scad>

translate([10+base_patern*3, 0, 0])
rotate([0, 0, -90])
    888_1002();
