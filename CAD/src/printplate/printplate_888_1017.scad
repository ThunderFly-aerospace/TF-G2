//@set_slicing_config(../../slicing/sides.ini)

include <../../parameters.scad>
use <../888_1017.scad>

translate([0, -5, 0])
    888_1017();
translate([0, 5, 0])
  mirror([0, 1, 0])
    888_1017();
