//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni tazneho motoru
use <../../888_1008.scad>

    translate([145, pilon_ring_width/2, pilon_holder_side_mount_height+pilot_height_separation])
        //rotate([pilon_angle, 0, 180])
        rotate([90+5, 0, 0])
            translate([0, 0, -pilon_thickness])
            888_1008();


    translate([145, -pilon_ring_width/2 -3, pilon_holder_side_mount_height+pilot_height_separation])
        //rotate([pilon_angle, 0, 0])
        rotate([90-5, 0, 0])
            translate([0, 0, -pilon_thickness])
            888_1008();
