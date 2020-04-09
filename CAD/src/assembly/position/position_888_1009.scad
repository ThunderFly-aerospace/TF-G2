//@set_slicing_config(../../slicing/default.ini)

//Vyztuzovaci ramecek pylonu
use <../../888_1009.scad>

    translate([145, 0, pilon_holder_side_mount_height + pilot_height_separation])
    //    rotate([0, 0, 180])
    //        translate([0, 0, -pilon_thickness])
            888_1009();
