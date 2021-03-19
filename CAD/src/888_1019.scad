//@set_slicing_config(slicing/default.ini)
//nastavovac uhlu pro pylon

include <../parameters.scad>

module 888_1019(){
  difference(){
    union(){
        cylinder(d = 9.5, h=35, $fn = 30);
    }

        cylinder(d = M3_screw_diameter, h = 100, $fn = 15);
        translate([0, 0, 10]) cylinder(d = M3_nut_diameter, h = 100, $fn = 6);
  }
}

888_1019();
