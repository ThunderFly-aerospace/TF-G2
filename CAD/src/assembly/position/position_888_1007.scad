//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni tazneho motoru
include <../../../parameters.scad>
use <../../888_1007.scad>

translate([140+20, 0, pylon_holder_side_mount_height+ rantl_height/2])
    //rotate([pylon_angle, 0, 180])
    translate([0, 0, -pylon_thickness])
        888_1007();
