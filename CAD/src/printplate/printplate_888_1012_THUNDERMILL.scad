//@set_slicing_config(../../slicing/head.ini)

//dil pro pripevneni tazneho motoru
include <../../parameters.scad>
use <../888_1012_THUNDERMILL.scad>

    rotate([0, -90, 0])
    888_1012(draft=false);
