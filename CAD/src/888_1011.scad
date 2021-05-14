//// ThunderFly - Rotor Head - Part 2

include <../parameters.scad>

length = rotor_head_width-2*0.5-0.15-0.55*2; // Length of the part
axis_diameter = M3_screw_diameter;
space = 2; // Axis hole distance
wall = 1;

add = 8; // prodlouzeni osy ve smeru roll osy

$fn = 100;

module 888_1011(){
  translate([0, 0, -wall-axis_diameter/2])
    difference(){
        hull(){
            translate([-length/2, -(axis_diameter + 2*wall)/2, 0])
                cube([length, axis_diameter + 2*wall, axis_diameter + 2*wall]);
            translate([0, axis_diameter + space, 0])
                cylinder(d = axis_diameter + 5*wall, h = axis_diameter + 2*wall + add, $fn=25);
        }

    translate([0, axis_diameter + space, axis_diameter + 2*wall + add - M3_nut_height*1.5])
        cylinder(d = M3_nut_diameter, h = 10, $fn=6);
    translate([0, axis_diameter + space, -0.1])
        cylinder(d = axis_diameter, h = 100, $fn=25);
    rotate([0, 90, 0])
        translate([-(axis_diameter + 2*wall)/2, 0, -50])
            cylinder(h = 100, d = axis_diameter, $fn=25);
    }

    //rotate([0, 90, 0]) if($preview) $cylinder(d = M3_screw_diameter, h = 35, center = true);

 translate([0, 5.2, -9.5]) rotate([0, 0, rotor_head_roll]) rotate([0, 180, 0]) rotate([0, 0, 90]) children(0);
}

888_1011();
