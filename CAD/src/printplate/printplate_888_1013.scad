//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni tazneho motoru
include <../../parameters.scad>
use <../888_1013.scad>


rotate([0, -90, 0]){
    888_1013();
    888_1013_support();
}