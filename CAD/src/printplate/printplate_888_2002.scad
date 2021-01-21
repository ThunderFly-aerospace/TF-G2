//@set_slicing_config(../../slicing/default.ini)

include <../../parameters.scad>
use <../888_2002.scad>

translate([0,0,0]) // odhadnute posunuti na podlozku
  888_2002();

translate([-20,-20,0])
  888_2002();
