
//@set_slicing_config(../slicing/default.ini)
include <../../parameters.scad>

use <../888_1010.scad>
use <../888_1011.scad>
use <../888_1012.scad>
use <../888_1014.scad>



module rotor_head(){
translate([-8, 0, 0])
    rotate([180, 0, -90])
        Part1();

translate([-9, 0, -4])
    rotate([90, 0, -90])
        Part2();

rotate([0, -90, 180])
    Part3();
}

difference(){
  translate([0, 0, 30])
    rotate([180, 0, 0])
      888_1014();
  cube(50);
}
rotor_head();
