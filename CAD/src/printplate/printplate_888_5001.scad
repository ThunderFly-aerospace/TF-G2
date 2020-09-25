//@set_slicing_config(../../slicing/default.ini)

//drzak zadniho kolecka
include <../../parameters.scad>

use <../888_5001.scad>

type = "cylinder";

rotate([0, 90, 0])
888_5001();
