//// ThunderFly TF-G2 Rotor Head - Part 1
/// Main parameters

include <../parameters.scad>
include <MCAD/servos.scad>
use <lib/TFSLOT01/CAD/src/tfslot_888_1001.scad>
use <lib/stdlib/servos.scad>
use <lib/stdlib/naca4.scad>
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


naca_pipe_length = 20;

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
                        translate([8/2 -25 , (airspeed_width/2) + (5-1.2/2)/2 -1 , servo_z_offset])
                            cube([8, 5-1.2+2, 35], center = true);

                        translate([-10, airspeed_width/2-side_wall, -airspeed_dist/2+0.5])
                            rotate([45, 0, 0])
                                cube([30, side_wall, 2], center=true);

                        // Kostky tvorici material pro prisroubovani

                        // Bocni svisle placky - horni cast
                        hull(){
                            translate([pitch_axis_y, airspeed_width/2, 30])
                                rotate([90, 0, 0])
                                    scale([1.3,1,1])
                                        cylinder(d = 8, h = side_wall+1);

                            translate([pitch_axis_y, airspeed_width/2, airspeed_dist/2])
                                rotate([90, 0, 0])
                                    scale([1.3,1,1])
                                        cylinder(d = 8, h = side_wall+1);
                        }

                        hull(){
                            translate([pitch_axis_y, airspeed_width/2, 30])
                                rotate([90, 0, 0])
                                    scale([1.3,1,1])
                                        cylinder(d = 8, h = side_wall);

                            translate([pitch_axis_y, airspeed_width/2, airspeed_dist/2])
                                rotate([90, 0, 0])
                                    scale([1.3,1,1])
                                        cylinder(d = 8, h = side_wall);

                            translate([-25, airspeed_width/2-side_wall, airspeed_dist/2])
                                cube([10, side_wall, 10]);
                        }
                    }

                    // Pro rotorovou hlavu (osa ROLL)
                    translate([pitch_axis_y, airspeed_width/2-2-0.5, pitch_axis_z])
                        rotate([-90, 0, 0])
                            cylinder(d = M3_screw_diameter, h = 10, $fn = 15, center=true);

                    translate([pitch_axis_y, 35/2-1, pitch_axis_z]) rotate([-90, 0, 0])
                        cylinder(d = M3_nut_diameter, h = 10, $fn = 6);

                    // Odecteni serva
                    rotate([0, 0, 180]) for(a=[-1, 1]) translate([8, a*(5+airspeed_width/2+0.5),  servo_z_offset]) rotate([90, 0, 90])
                        union(){
                            translate([0, 0, 10])
                                cube([11, 24, 20], center = true);

                            translate([0, 14, 13])
                                rotate([0, 90, 0])
                                    cylinder(d = 1.9, h = 55, $fn=10);

                            translate([0, -14, 13])
                                rotate([0, 90, 0])
                                    cylinder(d = 1.9, h = 55, $fn=10);
                        }
                }


                // NACA pro stredni tycku
                translate([15, 0, -naca_pipe_length - airspeed_dist/2])
                    rotate([0, 0, 180])
                        airfoil(naca = 0035, L = 40, N = 50, h= naca_pipe_length, open = false);

            }


            // NACA pro stredni tycku
            translate([15 - 40*0.3, 0, -naca_pipe_length - airspeed_dist/2-0.1])
                cylinder(d=pylon_pipe_d, h=naca_pipe_length);
            translate([5, 0, -naca_pipe_length - airspeed_dist/2-0.1])
                translate([-20, -0.5, 0])
                    cube([20, 1, naca_pipe_length]);
            translate([15, 0, -naca_pipe_length - airspeed_dist/2])
                rotate([0, 0, 180])
                    difference(){
                        hollow_airfoil(naca = 0035, L = 40, N = 50, h=2, open = true, wall_thickness=0.8);
                        translate([40, 0, 0]) cube([4.5, 1, 2], center=true);
                    }

            translate([5, 0, -naca_pipe_length - airspeed_dist/2-0.1])
                translate([-12, 0, 5])
                    rotate([90, 0, 0]){
                        cylinder(d=M3_screw_diameter, h=naca_pipe_length, center=true, $fn=30);

                        translate([0, 0, naca_pipe_length/2+4])
                            cylinder(d=M3_nut_diameter, h=naca_pipe_length, center=true, $fn=6);

                        translate([0, 0, -naca_pipe_length/2-4])
                            cylinder(d=M3_nut_diameter, h=naca_pipe_length, center=true, $fn=6);
                    }


            // Odecteni serva
            rotate([0, 0, 180])
                for(a=[-1, 1])
                    translate([8, a*(5+airspeed_width/2+0.5),  servo_z_offset])
                        rotate([90, 0, 90])
                            union(){
                                translate([0, 0, 10])
                                    cube([11, 24, 20], center = true);
                                translate([0, 14, 13])
                                    rotate([0, 90, 0])
                                        cylinder(d = 1.8, h = 15, $fn=10);
                                translate([0, -14, 13])
                                    rotate([0, 90, 0])
                                        cylinder(d = 1.8, h = 15, $fn=10);
                            }
    }

    // objekty pro sestavu
    translate([0, 0, pitch_axis_z])
        rotate([90, 0, 90])
            rotate([-rotor_head_pitch, 0, 0])
                children();

    if($preview && 0){
        for(m = [0, 1])
            mirror([0,m,0])
                translate([-22, -5 - airspeed_width/2, 0])
                    rotate([90, 0, -90])
                        color("gray")
                            servo_bms_115() {paka_jednostranna(); }
    }
}

//difference(){
    888_1010();
//translate([-100, 0, -100]) cube(200); }
