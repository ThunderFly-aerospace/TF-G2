//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni tazneho motoru
include <../../../parameters.scad>
use <../../888_3001.scad>

translate([500+100, 0, -12.5]){
    888_3001();
}
