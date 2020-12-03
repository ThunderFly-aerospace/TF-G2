//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni tazneho motoru
include <../../../parameters.scad>
use <../../888_1008.scad>

translate([140+20, 0, pylon_holder_side_mount_height+pilot_height_separation + rantl_height])
    translate([0, 0, -pylon_thickness])
        888_1008();
