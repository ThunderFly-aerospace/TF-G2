//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni tazneho motoru
include <../../../parameters.scad>
use <../../888_1008.scad>

    translate([145, pylon_ring_width/2 - pylon_ring_thickness - pylon_thickness, pylon_holder_side_mount_height+pilot_height_separation])
        //rotate([pylon_angle, 0, 180])
        rotate([180-pylon_top_angle, 0, 0])
            translate([0, 0, -pylon_thickness])
            888_1008();


    translate([145, -pylon_ring_width/2 + pylon_ring_thickness, pylon_holder_side_mount_height+pilot_height_separation])
        //rotate([pylon_angle, 0, 0])
        //rotate([90, 0, 0])
        rotate([pylon_top_angle, 0, 0])
            translate([0, 0, -pylon_thickness])
            888_1008();
