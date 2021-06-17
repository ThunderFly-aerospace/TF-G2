//@set_slicing_config(../../slicing/blade_center_parts_angled.ini)

//drzak zadniho kolecka
include <../../parameters.scad>
use <../888_4006.scad>

AoA = -1.5;

888_4006(AoA);
translate([0, -22, 0]) 888_4006(AoA);
