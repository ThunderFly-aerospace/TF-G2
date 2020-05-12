//// ThunderFly Auto-G2 Rotor Head - Part 1

/// Main parameters

include <../parameters.scad>

L1 = rotor_head_width;  // Length of the middle part
T1 = rotorhead_wall_thickness;  // Thickness of the middle wall
T2 = rotorhead_wall_thickness;  // Thickness of the side walls
H = 11;  // Hight of the part
L2 = pylon_top_length;  // Length of the side walls

/// Parameters for holes
RC = M3_screw_diameter/2;  // Radius of the center screw holes
RP = M2_screw_diameter/2;  // Radius of the periphery screw holes
DY = horizontal_screw_distance;  // Y-axis distance of the periphery screw holes
DZ = vertical_screw_distance;  // Z-axis distance of the periphery screw holes

shift =  - 0;
CHT = [0, shift, -20];  // Center hole translation

fn = 100;  // default face number for cylinders
/// Main object

module body() {
    translate([0,0, 0]) difference() {
        union(){
            translate([0, 0, 0])
                cube([L1, pylon_top_length, .1], center= true);
            hull(){
                translate([0, 0, 0])
                cube([L1, pylon_top_length, 10], center= true);
                translate([0, 0, -15])
                    rotate([0,90,0])
                        cylinder(d=10, h=L1, center = true, $fn=fn);

            }



        }

        translate([25 + rotor_head_width/2, 0, 0]) rotate([0, 90-pylon_top_angle, 0]) cube(50, center = true);
        translate([-25 - rotor_head_width/2, 0, 0]) rotate([0, pylon_top_angle, 0]) cube(50, center = true);


        difference(){
            cube([L1-2*T2, L2-2*T1, H*10], center = true);
            cube([L1-2*T2, T1, H*10], center = true);
        }

        translate([0,0,-50])
            cube([L1-2*T2, 50, 100], center = true);
    }

}



/// Part 1 with holes and incisions
module Part1(){
        difference(){
        translate(-CHT)
            body();

        translate([0, 0, 5]) rotate([0,90,0]) cylinder(r=RC, h=L1+10, center = true, $fn=fn);

            for(x = [-pylon_top_length/2+5:10:pylon_top_length/2-5])
                translate([0, x, 20])
                    rotate([0, 90, 0])
                        {
                        cylinder(d = M3_screw_diameter, h = 50, center = true, $fn = $preview?10:30);
                        cylinder(d = M3_nut_diameter, h = DY*2-1, center = true, $fn = 6);
                        }
           // Screw holes

        }

}

Part1();

module 888_1010(){
    rotate([180, 0, 90])
    Part1();
}
