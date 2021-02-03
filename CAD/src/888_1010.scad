//// ThunderFly TF-G2 Rotor Head - Part 1

/// Main parameters

include <../parameters.scad>
include <MCAD/servos.scad>
use <lib/TFSLOT01/CAD/src/tfslot_888_1001.scad>
use <888_1011.scad>
use <888_1012.scad>


servo_z_offset = 0;
tfslot_dist = 19;
rotor_head_pylon_adapter_z = - tfslot_dist/2 - 7;
pitch_axis_z = 35;


if(0){
% rotate([0, 0, 180])for(a=[-1, 1]) translate([8, a*(6+airspeed_width/2+0.5), -5 + servo_z_offset]) rotate([90, 0, 90]) alignds420();
% translate([0, 0, pitch_axis_z]) rotate([90, 0, 90]) 888_1011();
% translate([-10, 0, pitch_axis_z+4]) rotate([0, -90, 0]) 888_1012();
}

module 888_1010(){    
    translate([15, 0, 0]) rotate([180, 0, 180]) tfslot_888_1001();

    for(m = [0, 1]) mirror([0,m,0]) difference(){
        union(){
            translate([-10, 0, 25]) cube([10, airspeed_width/2, 2]);

            // Kostky pro pripevneni serva
            translate([5/2 -25 , (airspeed_width/2) + 9/2 , servo_z_offset]) cube([5, 10.5, 35], center = true);
            translate([-25 + 5, (airspeed_width/2) , servo_z_offset]) rotate(45) cube([3, 3, 35], center = true);

            // Bocni svisle placky
            hull(){
                // Pro pripevneni adapteru na pylon
                translate([-25, airspeed_width/2-2, rotor_head_pylon_adapter_z - M3_screw_diameter*1.5]) cube([30, 2, 1]);
                // Prostredni cast 
                translate([-25, airspeed_width/2-2, -20]) cube([30, 2, 40]);
                translate([0, airspeed_width/2-2, 35]) rotate([-90, 0, 0]) cylinder(d = 10, h = 2);
            }
        }

        // Pro rotorovou hlavu (osa ROLL)
        translate([0, airspeed_width/2-2-0.5, pitch_axis_z]) rotate([-90, 0, 0]) cylinder(d = M3_screw_diameter, h = 5, $fn = 15);

        // Odecteni serva
        rotate([0, 0, 180]) for(a=[-1, 1]) translate([8, a*(5+airspeed_width/2+0.5),  servo_z_offset]) rotate([90, 0, 90])     
            union(){
                translate([0, 0, 10]) cube([11, 24, 20], center = true);
                translate([0, 14, 5]) cylinder(d = 2.5, h = 15);
                translate([0, -14, 5]) cylinder(d = 2.5, h = 15);
            }

        // Otvory pro pripevneni adapteru pylonu
        translate([0, 0, rotor_head_pylon_adapter_z]) rotate([-90, 0, 0]) cylinder(d = M3_screw_diameter, h = 100, $fn=20);
        translate([-15, 0, rotor_head_pylon_adapter_z]) rotate([-90, 0, 0]) cylinder(d = M3_screw_diameter, h = 100, $fn=20);
        translate([0, airspeed_width/2, rotor_head_pylon_adapter_z]) rotate([-90, 0, 0]) cylinder(d = M3_nut_diameter, h = 100, $fn=20);
        translate([-15, airspeed_width/2, rotor_head_pylon_adapter_z]) rotate([-90, 0, 0]) cylinder(d = M3_nut_diameter, h = 100, $fn=20);

    }
}

//difference(){

        888_1010();
//translate([-100, 0, -100]) cube(200); }

