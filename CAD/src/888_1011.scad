//// ThunderFly - Rotor Head - Part 2

include <../parameters.scad>

length = rotor_head_width-2*rotorhead_wall_thickness-0.15; // Length of the part
axis_diameter = M3_screw_diameter;
space = 1; // Axis hole distance
wall = 1;

add = 5; // prodlouzeni osy ve smeru roll osy

$fn = 100;

module Part2(){
  translate([0, 0, -wall-axis_diameter/2])
    difference(){
        hull(){
            translate([-length/2, -(axis_diameter + 2*wall)/2, 0])
                cube([length, axis_diameter + 2*wall, axis_diameter + 2*wall + add]);
            translate([0, axis_diameter + space, 0])
                cylinder(d = axis_diameter + 2*wall, h = axis_diameter + 2*wall + add);
        }
    translate([0, axis_diameter + space, -0.1])
        cylinder(d = axis_diameter, h = 100);
    rotate([0, 90, 0])
        translate([-(axis_diameter + 2*wall)/2, 0, -50])
            cylinder(h = 100, d = axis_diameter);
    }
}

Part2();


module 888_1011(){
    Part2();
}
