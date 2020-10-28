//@set_slicing_config(../../slicing/default.ini)

include <../../parameters.scad>
use <../888_2002.scad>

translate([0,0,-5]) // odhadnute posunuti na podlozku
  rotate([0,2,0])   // odhadnute otoceni na podlozku
    888_2002();

translate([-20,-20,0])
  888_2002();

#translate([-20,-20,-10])
  cube([300,300,2], center = true);
