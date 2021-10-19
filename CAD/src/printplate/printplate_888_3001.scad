//@set_slicing_config(../../slicing/tail_center.ini)

//dil pro pripevneni tazneho motoru
include <../../parameters.scad>
use <../888_3001.scad>

rotate([0,0,90])
  888_3001();
