//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni tazneho motoru
include <../../parameters.scad>
use <../888_1001_rearpart.scad>
use <../888_1001_frontpart.scad>

888_1001_frontpart();

translate([-140,80,0])
    888_1001_rearpart();
