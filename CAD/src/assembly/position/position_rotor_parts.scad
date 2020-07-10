
//@set_slicing_config(../slicing/default.ini)
include <../../../parameters.scad>

use <../../888_4001.scad>
use <../../888_4002.scad>
use <../../888_4003.scad>
use <../../888_4004.scad>
use <../../888_4005.scad>
use <../../888_4006.scad>
use <../../888_4007.scad>

/* translate([183, 0, 250+30])
rotate([0, 7, 0])
for(i=[0, 180])
  rotate(i)
    rotate([90, rotor_blade_AOA, 0]) translate([-rotor_blade_depth/4, 0, -rotor_blade_length-11.5]) 888_4001(); */

    translate([183, 0, 250+30-4])
    rotate([0, 0, 0])
    //for(i=[0, 180])
      //rotate(i)
        //rotate([90, rotor_blade_AOA, 0]) translate([-rotor_blade_depth/4, 0, -rotor_blade_length-20])


        888_4002();

    translate([183, 0, 250+30-5+3])
      rotate([0, 0, 90])
        888_4005();

    /* translate([183, 0, 250+30-5+3])
    rotate([0, 0, 90])
        888_4006(); */


    translate([183, 0, 250+30-4.5+15])
    rotate([180, 0, 0])
        888_4007();
