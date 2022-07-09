//@set_slicing_config(../../slicing/head.ini)

//dil pro pripevneni tazneho motoru
include <../../parameters.scad>
use <../888_1012.scad>

    rotate([0, -90, 0])
    888_1012_bearing_house(draft=false);
