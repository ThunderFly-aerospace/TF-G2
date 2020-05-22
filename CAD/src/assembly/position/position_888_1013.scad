//@set_slicing_config(../../slicing/default.ini)

//Vyztuzovaci ramecek pylonu
include <../../../parameters.scad>
use <../../888_1013.scad>

    //translate([145, 0, pylon_holder_side_mount_height + pilot_height_separation])
    //    rotate([0, 0, 180])
    //        translate([0, 0, -pylon_thickness])
    translate([base_patern*4, 0, -base_thickness -rantl_height/2])
    rotate([180, 0, 180])
            888_1013();
