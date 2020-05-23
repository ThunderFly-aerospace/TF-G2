//@set_slicing_config(../../slicing/sides.ini)

//dil pro pripevneni tazneho motoru
include <../../parameters.scad>
use <../888_1007.scad>

translate([25, -55, 0])
    888_1007();
translate([-28, 50, 0])
  mirror([0, 1, 0])
    888_1007();
