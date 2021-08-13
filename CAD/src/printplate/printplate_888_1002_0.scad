//@set_slicing_config(../../slicing/default.ini)
//@set_slicing_parameter(brim_width, 2)

//dil pro pripevneni tazneho motoru
include <../../parameters.scad>
use <../888_1002.scad>

888_1002(motor_angle = 0);
