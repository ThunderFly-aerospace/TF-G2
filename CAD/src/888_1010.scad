//// ThunderFly TF-G2 Rotor Head - Part 1
/// Main parameters

include <../parameters.scad>
include <MCAD/servos.scad>
use <lib/TFSLOT01/CAD/src/tfslot_888_1001.scad>
use <lib/stdlib/servos.scad>
use <888_1011.scad>
use <888_1012.scad>
use <888_1009.scad> // data o pylonu


servo_z_offset = 3.5;
tfslot_dist = 19;
rotor_head_pylon_adapter_z = - tfslot_dist/2 - 7;
pitch_axis_z = 30;
pitch_axis_y = -2;

side_wall = 2;

pylon_adapter_mount_holes_distance = 15;


// if(0){
//     % rotate([0, 0, 180])for(a=[-1, 1]) translate([8, a*(6+airspeed_width/2+0.5), -5 + servo_z_offset]) rotate([90, 0, 90]) alignds420();
//     % translate([0, 0, pitch_axis_z]) rotate([90, 0, 90]) 888_1011();
//     % translate([-10, 0, pitch_axis_z+4]) rotate([0, -90, 0]) 888_1012();
// }

pylon_mount_adapter_center_distance = airspeed_dist/2+4;

module 888_1010(){

 translate([5, airspeed_width/2, 0]) rotate([90, 0, 180]) linear_extrude(1.4, center=true) text(str("< ", week), halign="center", valign="center", size=5);

    difference(){
            union(){
                translate([15, 0, 0]) rotate([180, 0, 180]) tfslot_888_1001(airspeed_width);

                for(m = [0, 1]) mirror([0,m,0]) difference(){
                    union(){

                        // Kostky pro pripevneni serva
                        translate([8/2 -25 , (airspeed_width/2) + (5-1.2/2)/2 -1 , servo_z_offset]) cube([8, 5-1.2+2, 35], center = true);

                        translate([-10, airspeed_width/2-side_wall, -airspeed_dist/2+0.5]) rotate([45, 0, 0]) cube([30, side_wall, 2], center=true);

                        // Kostky tvorici material pro prisroubovani
                        translate([-25, -25/2-5+0.05, -pylon_mount_adapter_center_distance-5+0.05]) cube([30, 10-0.1, 10-0.1]);


                        // Bocni svisle placky - horni cast
                        hull(){
                            translate([pitch_axis_y, airspeed_width/2, 30]) rotate([90, 0, 0]) scale([1.3,1,1]) cylinder(d = 8, h = side_wall+1);
                            translate([pitch_axis_y, airspeed_width/2, airspeed_dist/2]) rotate([90, 0, 0]) scale([1.3,1,1]) cylinder(d = 8, h = side_wall+1);
                        }

                        hull(){
                            translate([pitch_axis_y, airspeed_width/2, 30]) rotate([90, 0, 0]) scale([1.3,1,1]) cylinder(d = 8, h = side_wall);
                            translate([pitch_axis_y, airspeed_width/2, airspeed_dist/2]) rotate([90, 0, 0]) scale([1.3,1,1]) cylinder(d = 8, h = side_wall);

                            #translate([-25, airspeed_width/2-side_wall, airspeed_dist/2]) cube([10, side_wall, 10]);
                        }
                    }

                    // Pro rotorovou hlavu (osa ROLL)
                    translate([pitch_axis_y, airspeed_width/2-2-0.5, pitch_axis_z]) rotate([-90, 0, 0]) cylinder(d = M3_screw_diameter, h = 10, $fn = 15, center=true);
                    translate([pitch_axis_y, 35/2-1, pitch_axis_z]) rotate([-90, 0, 0]) cylinder(d = M3_nut_diameter, h = 10, $fn = 6);

                    // Odecteni serva
                    rotate([0, 0, 180]) for(a=[-1, 1]) translate([8, a*(5+airspeed_width/2+0.5),  servo_z_offset]) rotate([90, 0, 90])
                        union(){
                            translate([0, 0, 10]) cube([11, 24, 20], center = true);
                            translate([0, 14, 13]) rotate([0, 90, 0]) cylinder(d = 1.9, h = 55, $fn=10);
                            translate([0, -14, 13]) rotate([0, 90, 0]) cylinder(d = 1.9, h = 55, $fn=10);
                        }
                }
            }


            // tramky tvorici vyrez pro adaptery pylonu
            translate([0, -pylon_screw_top_y_dist/2, -airspeed_dist/2-4]+[0, 0, -5]) cube([100, 10, 10], center=true);
            translate([0, pylon_screw_top_y_dist/2, -airspeed_dist/2-4]+[0, 0, -5]) cube([100, 10, 10], center=true);


            // Otvory pro srouby k pylonu
            translate([0,                       -pylon_screw_top_y_dist/2, -airspeed_dist/2-3.5]){
                translate([0, 0, -5]) cylinder(d=M3_screw_diameter, h = 5+7, $fn=30);
                hull(){
                    translate([0, 0, 2]) rotate(30) cylinder(d=M3_nut_diameter, h = M3_nut_height, $fn=6);
                    translate([0, -10, 2]) rotate(30) cylinder(d=M3_nut_diameter, h = M3_nut_height, $fn=6);
                }

            }
            translate([-pylon_screw_top_x_dist, -pylon_screw_top_y_dist/2, -airspeed_dist/2-3.5]){
                translate([0, 0, -5]) cylinder(d=M3_screw_diameter, h = 5+7, $fn=30);
                hull(){
                    translate([0, 0, 2]) rotate(30) cylinder(d=M3_nut_diameter, h = M3_nut_height, $fn=6);
                    translate([0, -10, 2]) rotate(30) cylinder(d=M3_nut_diameter, h = M3_nut_height, $fn=6);
                }
            }


            translate([0,                       pylon_screw_top_y_dist/2, -airspeed_dist/2-3.5]){
                translate([0, 0, -5]) cylinder(d=M3_screw_diameter, h = 5+7, $fn=30);
                hull(){
                    translate([0, 0, 2]) rotate(30) cylinder(d=M3_nut_diameter, h = M3_nut_height, $fn=6);
                    translate([0, 10, 2]) rotate(30) cylinder(d=M3_nut_diameter, h = M3_nut_height, $fn=6);
                }

            }
            translate([-pylon_screw_top_x_dist, pylon_screw_top_y_dist/2, -airspeed_dist/2-3.5]){
                translate([0, 0, -5]) cylinder(d=M3_screw_diameter, h = 5+7, $fn=30);
                hull(){
                    translate([0, 0, 2]) rotate(30) cylinder(d=M3_nut_diameter, h = M3_nut_height, $fn=6);
                    translate([0, 10, 2]) rotate(30) cylinder(d=M3_nut_diameter, h = M3_nut_height, $fn=6);
                }
            }



            // Odecteni serva
            rotate([0, 0, 180]) for(a=[-1, 1]) translate([8, a*(5+airspeed_width/2+0.5),  servo_z_offset]) rotate([90, 0, 90])
                union(){
                    translate([0, 0, 10]) cube([11, 24, 20], center = true);
                    translate([0, 14, 13]) rotate([0, 90, 0]) cylinder(d = 1.8, h = 15, $fn=10);
                    translate([0, -14, 13]) rotate([0, 90, 0]) cylinder(d = 1.8, h = 15, $fn=10);
                }
    }

    // objekty pro sestavu
    translate([0, 0, pitch_axis_z]) rotate([90, 0, 90]) rotate([-rotor_head_pitch, 0, 0]) children();

    if($preview && 0){
        for(m = [0, 1]) mirror([0,m,0]) translate([-22, -5 - airspeed_width/2, 0]) rotate([90, 0, -90]) color("gray") servo_bms_115() {paka_jednostranna(); }
    }
}

//difference(){
    888_1010();
//translate([-100, 0, -100]) cube(200); }
