
//@set_slicing_config(../slicing/default.ini)
include <../../../parameters.scad>

use <../../888_4001.scad>
use <../../888_4002.scad>
use <../../888_4003.scad>
use <../../888_4004.scad>
use <../../888_4005.scad>
use <../../888_4006.scad>
use <../../888_4007.scad>
use <../../888_4008.scad>

/* translate([183, 0, 250+30])
rotate([0, 7, 0])
for(i=[0, 180])
  rotate(i)
    rotate([90, rotor_blade_AOA, 0]) translate([-rotor_blade_depth/4, 0, -rotor_blade_length-11.5]) 888_4001(); */

    for(r = [180, 0])
        translate([183, 0, 250+30-4])
            rotate([0, 0, r])
                translate([-8.5, -36, 0])
                    rotate([180, 0, 90])
                        888_4004();

    translate([183, 0, 250+30-4])
        rotate([0, 0, 0])
            888_4002();

    translate([183, 0, 250+30-5+3])
      rotate([0, 0, 90-25])
        888_4005();
    
    for(r = [180, 0])
        translate([183, 0, 250+30-5+3])
            rotate([0, 0, r])
                translate([8.5, -36, 0])
                    rotate([0, 0, 90])
                        888_4006();


    translate([183, 0, 250+30-4.5+15])
    rotate([180, 0, 0])
        888_4007();
    
    
    translate([183, 0, 250+30-4.5+15-17.5])
    rotate([180, 0, 90])
        888_4008();
