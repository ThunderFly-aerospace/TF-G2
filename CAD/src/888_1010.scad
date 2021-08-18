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


servo_z_offset = 2.5;
tfslot_dist = 19;
rotor_head_pylon_adapter_z = - tfslot_dist/2 - 7;
pitch_axis_z = 30;
pitch_axis_y = -40*0.3 - 5;

side_wall = 2;


pylon_mount_adapter_center_distance = airspeed_dist/2+4;

module 888_1010() translate([40*0.3, 0, 0]) {

     translate([-7, airspeed_width/2, 0])
        rotate([90, 0, 180])
            linear_extrude(1.6, center=true)
                text(str("<", week), halign="center", valign="center", size=6);
    #translate([-40, -2.5, -26]) cube([0.3, 5, 5]);

    difference(){
            union(){
                translate([0, 0, 0]) rotate([180, 0, 180]) tfslot_888_1001(airspeed_width);

                for(m = [0, 1]) mirror([0,m,0]) difference(){
                    union(){

                        // Kostky pro pripevneni serva
                        translate([8/2 - 40 , (airspeed_width/2) + (5-1.2/2)/2 -1 , servo_z_offset])
                            cube([8, 5-1.2+2, 35], center = true);

                        translate([-15-10, airspeed_width/2-side_wall+0.3, -airspeed_dist/2+0.5])
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

                            translate([-40, airspeed_width/2-side_wall, airspeed_dist/2])
                                cube([10, side_wall, 10]);
                        }
                    }

                    // Pro rotorovou hlavu (osa ROLL)
                    translate([pitch_axis_y, airspeed_width/2-2-0.5, pitch_axis_z])
                        rotate([-90, 0, 0])
                            cylinder(d = M3_screw_diameter, h = 10, $fn = 15, center=true);

                    translate([pitch_axis_y, 35/2-1, pitch_axis_z]) rotate([-90, 0, 0])
                        cylinder(d = M3_nut_diameter, h = 10, $fn = 6);

                }


                // NACA pro stredni tycku
                translate([0, 0, -pylon_pipe_counterbore - airspeed_dist/2+0.5+pylon_pipe_top_offset])
                    rotate([0, 0, 180])
                        airfoil(naca = 0035, L = 40, N = 50, h= pylon_pipe_counterbore - pylon_pipe_top_offset, open = false);

            }


            // NACA pro stredni tycku
            translate([-40*0.3, 0, -pylon_pipe_counterbore - airspeed_dist/2-0.1 + pylon_pipe_top_offset])
                cylinder(d=pylon_pipe_d, h=pylon_pipe_counterbore);

            translate([-40*0.3, 0, -pylon_pipe_counterbore - airspeed_dist/2-0.1])
                translate([-20, -0.5, 0])
                    cube([20, 1, pylon_pipe_counterbore]);

            translate([0, 0, -pylon_pipe_counterbore - airspeed_dist/2 + pylon_pipe_top_offset])
                rotate([0, 0, 180])
                    difference(){
                        hollow_airfoil(naca = 0035, L = 40, N = 50, h=pylon_airfoil_shell_overlap, open = true, wall_thickness=0.9);
                        translate([40, 0, 0]) cube([4.5, 1, 2], center=true);
                    }

            translate([-40*0.3 - pylon_pipe_d/2, 0,  - airspeed_dist/2-0.1 + pylon_pipe_top_offset])
                translate([0, 0, -pylon_pipe_screw_distance_from_top_end])
                    rotate([90, 30, 0]){
                        cylinder(d=M3_screw_diameter, h=pylon_pipe_counterbore, center=true, $fn=30);

                        translate([0, 0, pylon_pipe_counterbore/2+5])
                            cylinder(d=M3_nut_diameter, h=pylon_pipe_counterbore, center=true, $fn=6);

                        translate([0, 0, -pylon_pipe_counterbore/2-5])
                            cylinder(d=M3_nut_diameter, h=pylon_pipe_counterbore, center=true, $fn=30);
                    }


            // Odecteni serva
            rotate([0, 0, 180])
                for(a=[-1, 1])
                    translate([23, a*(5+airspeed_width/2+0.5),  servo_z_offset])
                        rotate([90, 0, 90])
                            union(){
                                translate([0, 0, 10])
                                    cube([11, 24, 20], center = true);
                                translate([0, 14, 13])
                                    rotate([0, 90, 0])
                                        cylinder(d = 1.9, h = 20, $fn=20, center=true);
                                translate([0, -14, 13])
                                    rotate([0, 90, 0])
                                        cylinder(d = 1.9, h = 20, $fn=20, center=true);
                            }
                
        // airspeed senzor diry pro srouby
        union() {
            translate([-10, (15+6)/2, 8.01])
            cylinder(d = 1.9, h = 10, $fn=20);
                                
            translate([-10, -(15+6)/2, 8.01])
            cylinder(d = 1.9, h = 10, $fn=20);
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
