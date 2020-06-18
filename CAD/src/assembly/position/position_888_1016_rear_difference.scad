//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni tazneho motoru
include <../../../parameters.scad>
use <../../888_1016.scad>

//translate([10+base_patern*(3)+5, 0, motor_holder_side_mount_height])
//for(i = [1, -1])
//translate([0, i*(base_width/2+5), 0])
//rotate([90, 0, 0])
888_1016_rear_crop();
