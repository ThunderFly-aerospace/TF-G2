//// ThunderFly TF-G2 Rotor Head - Part 1
/// Main parameters

include <../parameters.scad>
include <MCAD/servos.scad>
use <lib/TFSLOT01/CAD/src/tfslot_888_1001.scad>
use <lib/stdlib/servos.scad>
use <888_1011.scad>
use <888_1012.scad>
use <888_1009.scad> // data o pylonu

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

servo_z_offset = 3.5;
tfslot_dist = 19;
rotor_head_pylon_adapter_z = - tfslot_dist/2 - 7;
pitch_axis_z = 30;



        }

        translate([25 + rotor_head_width/2, 0, 0]) rotate([0, 90-pylon_top_angle, 0]) cube(50, center = true);
        translate([-25 - rotor_head_width/2, 0, 0]) rotate([0, pylon_top_angle, 0]) cube(50, center = true);

pylon_mount_adapter_center_distance = airspeed_dist/2+4;

module 888_1010(){

 translate([0, airspeed_width/2, 0]) rotate([90, 0, 180]) linear_extrude(1, center=true) text(str("< ", week), halign="center", valign="center", size=4);

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
                            // Pro pripevneni adapteru na pylon
                            translate([0, airspeed_width/2, 30]) rotate([90, 0, 0]) scale([1.3,1,1]) cylinder(d = 8, h = side_wall+1);
                            translate([0, airspeed_width/2, airspeed_dist/2]) rotate([90, 0, 0]) scale([1.3,1,1]) cylinder(d = 8, h = side_wall+1);
                        }

                        hull(){
                            // Pro pripevneni adapteru na pylon
                            translate([0, airspeed_width/2, 30]) rotate([90, 0, 0]) scale([1.3,1,1]) cylinder(d = 8, h = side_wall);
                            translate([0, airspeed_width/2, airspeed_dist/2]) rotate([90, 0, 0]) scale([1.3,1,1]) cylinder(d = 8, h = side_wall);

                            translate([-25, airspeed_width/2-side_wall, airspeed_dist/2]) cube([30, side_wall, 10]);
                        }
                    }

                    // Pro rotorovou hlavu (osa ROLL)
                    translate([-0, airspeed_width/2-2-0.5, pitch_axis_z]) rotate([-90, 0, 0]) cylinder(d = M3_screw_diameter, h = 10, $fn = 15, center=true);
                    translate([-0, 35/2-1, pitch_axis_z]) rotate([-90, 0, 0]) cylinder(d = M3_nut_diameter, h = 10, $fn = 6);

                    // Odecteni serva
                    rotate([0, 0, 180]) for(a=[-1, 1]) translate([8, a*(5+airspeed_width/2+0.5),  servo_z_offset]) rotate([90, 0, 90])
                        union(){
                            translate([0, 0, 10]) cube([11, 24, 20], center = true);
                            translate([0, 14, 13]) rotate([0, 90, 0]) cylinder(d = 1.8, h = 55, $fn=10);
                            translate([0, -14, 13]) rotate([0, 90, 0]) cylinder(d = 1.8, h = 55, $fn=10);
                        }
                }
            }


            // tramky tvorici vyrez pro adaptery pylonu
            translate([0, -pylon_screw_top_y_dist/2, -airspeed_dist/2-4]+[0, 0, -5]) cube([100, 10, 10], center=true);
            translate([0, pylon_screw_top_y_dist/2, -airspeed_dist/2-4]+[0, 0, -5]) cube([100, 10, 10], center=true);


            // Otvory pro srouby k pylonu
            translate([0,                       -pylon_screw_top_y_dist/2, -airspeed_dist/2-4]){
                translate([0, 0, -5]) cylinder(d=M3_screw_diameter, h = 5+7, $fn=30);
                hull(){
                    translate([0, 0, 2]) rotate(30) cylinder(d=M3_nut_diameter, h = M3_nut_height, $fn=6);
                    translate([0, -10, 2]) rotate(30) cylinder(d=M3_nut_diameter, h = M3_nut_height, $fn=6);
                }

            }
            translate([-pylon_screw_top_x_dist, -pylon_screw_top_y_dist/2, -airspeed_dist/2-4]){
                translate([0, 0, -5]) cylinder(d=M3_screw_diameter, h = 5+7, $fn=30);
                hull(){
                    translate([0, 0, 2]) rotate(30) cylinder(d=M3_nut_diameter, h = M3_nut_height, $fn=6);
                    translate([0, -10, 2]) rotate(30) cylinder(d=M3_nut_diameter, h = M3_nut_height, $fn=6);
                }
            }


            translate([0,                       pylon_screw_top_y_dist/2, -airspeed_dist/2-4]){
                translate([0, 0, -5]) cylinder(d=M3_screw_diameter, h = 5+7, $fn=30);
                hull(){
                    translate([0, 0, 2]) rotate(30) cylinder(d=M3_nut_diameter, h = M3_nut_height, $fn=6);
                    translate([0, 10, 2]) rotate(30) cylinder(d=M3_nut_diameter, h = M3_nut_height, $fn=6);
                }

            }
            translate([-pylon_screw_top_x_dist, pylon_screw_top_y_dist/2, -airspeed_dist/2-4]){
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
