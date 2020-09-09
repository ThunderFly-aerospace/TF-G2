//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni tazneho motoru
include <../../../parameters.scad>
use <../../888_1018.scad>

//translate([10+base_patern*(3)+5, 0, motor_holder_side_mount_height])
//for(i = [1, -1])
//translate([0, battery_case_start_x + 70, -bellow])

color("red")
translate([90, 0, -6.5])
    888_1018();
