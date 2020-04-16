//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni tazneho motoru
use <../../888_3001.scad>
use <../../888_3002.scad>
use <../../888_3003.scad>
use <../../888_3004.scad>
use <../../888_3005.scad>
use <../../888_3006.scad>

translate([500+100, 0, 0]){
    888_3001();
    888_3002();
    888_3003();
    888_3004();
    888_3005();
    mirror([0, 1, 0])
    888_3005();
//888_3006();
}
