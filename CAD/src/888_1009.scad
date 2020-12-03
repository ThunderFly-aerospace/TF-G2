//@set_slicing_config(slicing/default.ini)
// Trhaci predel rotorove hlavy

include <../parameters.scad>
use <888_1008.scad>

module 888_1009() {

    difference(){
            minkowski(){
                linear_extrude(2)
                    union(){
                        square([45, 1], center=true);
                        square([1, 45], center=true);
                    }
                cylinder(d=9, h = 0.1, $fn=20);
            }
    

    for(r = [1, 2, 3, 4])
        rotate([0, 0, r*90])
            translate([45/2, -0.1])
                cylinder(d=M3_screw_diameter, h = 10, $fn=30);
    }
}

888_1009();
%translate([0, 0, -4]) 888_1008();
