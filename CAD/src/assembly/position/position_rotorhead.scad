
//@set_slicing_config(../slicing/default.ini)
include <../../../parameters.scad>

use <../../888_1010.scad>
use <../../888_1011.scad>
use <../../888_1012.scad>
use <../../888_4008.scad>



module rotor_head(){
translate([-25, 0, -35])
    rotate([0, 0, 180])
        888_1010();

translate([-9, 0, -4])
    rotate([90, 0, -90])
        888_1011();

rotate([0, -90, 180])
    888_1012();
}

translate([183, 0, 250])
difference(){
  translate([0, 0, 30])
    rotate([180, 0, 0])
      888_4008();
  //  cube(50);
}

translate([183, 0, 250])
  rotor_head();
