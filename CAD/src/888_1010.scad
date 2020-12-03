//// ThunderFly Auto-G2 Rotor Head - Part 1

/// Main parameters

include <../parameters.scad>
include <MCAD/servos.scad>
use <888_5001.scad>


rotate([0, 0, 180]){
    for(a=[-1, 1]) translate([8, a*(6+32/2+2), -5]) rotate([90, 0, 90]) alignds420(screws=1);
    translate([-20, 0, 0]) rotate([180, 0, 0]) 888_5001();
}

module 888_1010()hull(){
    translate([-25, 30/2, -20]) cube([30, 4, 40]);
    translate([0, 30/2, 35]) rotate([-90, 0, 0]) cylinder(d = 10, h = 4);
}

mirror([0,1,0]) 888_1010();
888_1010();