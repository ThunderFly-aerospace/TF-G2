//@set_slicing_config(../../slicing/head.ini)

//dil pro pripevneni tazneho motoru
include <../../parameters.scad>
use <../888_1010.scad>
use <../888_1011.scad>
use <../888_1012.scad>
use <../888_1013.scad>

translate([-35,0, 25]) 888_1010();

translate([-20, 0, M3_screw_diameter/2+1]) rotate([0, 0, -90]) 888_1011();

translate([0, 0, M3_screw_diameter/2+2.5]) rotate([0, -90, 0])  888_1012();
