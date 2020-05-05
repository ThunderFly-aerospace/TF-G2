//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni tazneho motoru
include <../../../parameters.scad>
use <../../888_3001.scad>
use <../../888_3002.scad>
use <../../888_3003.scad>
use <../../888_3004.scad>
use <../../888_3005.scad>
use <../../888_3006.scad>

translate([500+150, 0, -10]){
    888_3001();
    888_3002();
    888_3003();
    888_3004();
    888_3005();
    mirror([0, 1, 0])
    888_3005();
//888_3006();
}
