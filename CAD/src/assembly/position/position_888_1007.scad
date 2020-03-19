//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni tazneho motoru
use <../../888_1007.scad>

    translate([145, base_width/2, pilon_holder_side_mount_height])
        rotate([pilon_angle, 0, 180])
            translate([0, 0, -pilon_thickness])
            888_1007();


    translate([145, -base_width/2, pilon_holder_side_mount_height])
        rotate([pilon_angle, 0, 0])
            translate([0, 0, -pilon_thickness])
            888_1007();
