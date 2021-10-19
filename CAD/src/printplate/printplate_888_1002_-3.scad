//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni tazneho motoru
include <../../parameters.scad>
use <../888_1002.scad>

rotate([0,0,90])
  888_1002(motor_angle = -3);
