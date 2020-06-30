//@set_slicing_config(../../slicing/blade_center_parts.ini)

//drzak zadniho kolecka
include <../../parameters.scad>

use <../888_4003.scad>
use <../888_4004.scad>
use <../888_4005.scad>
use <../888_4006.scad>


translate([0, 0, 0]) 888_4003();
translate([15, 15, 0]) 888_4004();
translate([15, 0, 0]) 888_4004();
translate([0, 28, 0]) 888_4005();
