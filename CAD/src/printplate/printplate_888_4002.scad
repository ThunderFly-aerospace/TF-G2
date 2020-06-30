//@set_slicing_config(../../slicing/blade_center_parts.ini)

//drzak zadniho kolecka
include <../../parameters.scad>

use <../888_4002.scad>


translate([-11, 7, 0]) 888_4002();
translate([11, -7, 0]) 888_4002();
translate([33, 7, 0]) 888_4002();
translate([-33, -7, 0]) 888_4002();
