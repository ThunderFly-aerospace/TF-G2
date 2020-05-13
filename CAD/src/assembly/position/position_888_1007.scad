//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni tazneho motoru
include <../../../parameters.scad>
use <../../888_1007.scad>

    translate([145, base_width/2 - pylon_thickness/2, pylon_holder_side_mount_height])
        //rotate([pylon_angle, 0, 180])
        rotate([pylon_bottom_angle, 0, 180])
            translate([0, 0, -pylon_thickness])
            888_1007();


    translate([145, -base_width/2 + pylon_thickness/2, pylon_holder_side_mount_height])
        rotate([pylon_bottom_angle, 0, 0])
            translate([0, 0, -pylon_thickness])
            888_1007();
