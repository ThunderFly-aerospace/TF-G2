//@set_slicing_config(../../slicing/default.ini)

include <../../parameters.scad>
use <../888_2002.scad>

$fn = 120;

translate([0,0,11]) // odhadnute posunuti na podlozku
  rotate([1.8, 1.8, 0]) // naklon vytisku aby sedel na podlozku dle orezu v 888_2002.scad
    888_2002();

/*translate([-25,-20,0])
  rotate([1.8, 1.8, 0])
    888_2002();
*/