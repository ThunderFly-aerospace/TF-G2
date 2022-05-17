//@set_slicing_config(../../slicing/head.ini)

//dil pro pripevneni tazneho motoru
include <../../parameters.scad>
use <../888_1011.scad>
rotate([0,180,0])
    888_1011();
