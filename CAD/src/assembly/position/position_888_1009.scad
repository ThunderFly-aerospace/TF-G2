//@set_slicing_config(../../slicing/default.ini)

//Vyztuzovaci ramecek pylonu
include <../../../parameters.scad>
use <../../888_1009.scad>

    translate([145+30, 0, pylon_holder_side_mount_height + pilot_height_separation])
    //    rotate([0, 0, 180])
    //        translate([0, 0, -pylon_thickness])
            888_1009();
