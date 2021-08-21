//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni tazneho motoru
include <../../parameters.scad>
use <../888_3006.scad>

rotate([0, -90, 0])
    888_3006();
translate([-25, 20, 0])
    rotate([0, 90, 0])
        888_3006();
