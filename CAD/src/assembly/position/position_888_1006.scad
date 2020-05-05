//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni tazneho motoru
include <../../../parameters.scad>
use <../../888_1006.scad>

translate([10+base_patern*(3)+5, 0, motor_holder_side_mount_height])
//rotate([180, 0, 0])
    888_1006();
