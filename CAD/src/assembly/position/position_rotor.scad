include <../../../parameters.scad>

use <../../888_4001.scad>

translate([183, 0, 280.5])
rotate([0, 7, 0])
for(i=[0, 180])
  rotate(i +0)
    rotate([90, rotor_blade_AOA, 0]) translate([-rotor_blade_depth/4, 0, -rotor_blade_length-11.5]) 888_4001();
