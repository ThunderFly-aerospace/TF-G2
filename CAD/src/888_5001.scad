include <../parameters.scad>

use <lib/stdlib/curvedPipe/curvedPipe.scad>
use <lib/stdlib/bolts.scad>

$fn = 200;


type = "naca"; // "naca" or "cylinder"
//type = "cylinder";
width = rotor_head_width;
echo("Sirka");
echo(rotor_head_width);

pipe_d = 2;


// for NACA type
naca = 0045;
distance = 22;
length = 40;
profile_thickness = surface_distance(x = 0.25, naca = naca)*length;

sensor_rantl = 3;
sensor_pos = [9, distance/2 + sensor_rantl, width/2];
sensor_nose_distance = 4.3;
sensor_nose_hole_depth = 2.5;
sensor_nose_hole_diameter = 3.5;
sensor_sealing_nose_diameter = 1.5;
sensor_sealing_nose_length = 2;



// Krabicka na PCB

pcb_width = 15;
pcb_offset = 0.65;
pcb_length = 36;
pcb_sensor_from_top = 5;
pcb_thickness = 3;
pcb_thickness_sensor = 3.4;
pcb_thickness_conn = 6;

// for cylinder type

stage1_len = 5;
stage1_dia = 19;
stage2_pos = 25;
stage2_dia = 8;
stage2_len = 5;
stage3_len = 1;
stage3_dia = 19;


pipe1_pos = [type=="naca"? 3: stage1_len/2, 0, width/2];
pipe2_pos = [type=="naca"?length*0.3 : stage2_pos+stage2_len/2, 0, width/2];

// PCB cap
cap_head_overlay = 3;
rail_x = 4.5;
rail_h = sqrt(2*(rail_x*rail_x))/2;
bolt_z = 15 - M3_head_height; // top of cap - head_height


module pipes()
{
    // Cabling
    //mid_body_horizontal = (R03_wide_D/2 + R03_narrow_D/2) / 2;
    //mid_body_vertical = wide_body_length + exhaust_length + R03_narrow_D/2;
    //PCB_y = -R03_wide_D/2 - R03_wall_thickness - R03_PCB_elevation;
    //PCB_z = R03_venturi_tube_height - R03_PCB_height*1.1 - 5;
    //pipe_elevation = PCB_z - slip_ring_z;
    //d = (R03_wide_D + 2*R03_wall_thickness)/2 - R03_narrow_D/2 - R03_wall_thickness;
    //cbl_x = 0;

width = 30;
distance = 50;

h = width/2;
d = 3;

echo("NACA");
 th = surface_distance(x = 0.25, naca = 0040)*60;
 echo(th);
 cube(50/2-th);

curvedPipe([ [10, distance/2, h],
			[100,0, h],
			[100,100, h],
            [100, 100, h],
            [100, 00, h]
		   ],
            4,
			[10, 10, 20, 20],
		    d, 0);

}
//pipes();




module 888_5001(){

translate([0, -width/2, 0]) rotate([-90, 0, 0]) difference(){


    // Horni profil
    union(){
    if(type == "naca"){
        intersection(){
            translate([0, -distance/2, 0]) airfoil(naca = naca, L = length, N = 50, h= width, open = false);
            translate([0, -distance/2, 0]) cube([length, distance, width]);
        }
        intersection(){
            translate([0, -distance/2, 0]) airfoil(naca = 0015, L = length, N = 50, h= width, open = false);
            translate([0,-distance*1.5, 0]) cube([length, distance, width]);
        }
            translate([0, -distance/2, 0]) cube([length, distance, 2]);
            translate([0, -distance/2, width-2]) cube([length, distance, 2]);
    }

    // Usi pro TF-G2
    // translate([length-15, -distance/2, 0]) difference() {
    //     hull(){
    //         translate([0, -15, 0]) cylinder(d = 10, h = width);
    //         translate([5, 0, 0]) cylinder(d = 5, h = width);
    //         translate([-5, 0, 0]) cylinder(d = 5, h = width);
    //     }

    //     translate([0, -15, width/2]) cube( rotor_head_width-2*rotorhead_wall_thickness, center = true);

    //     }

    // Spodni profil
    difference(){
        union(){
            if(type == "naca"){
            intersection(){
                translate([0, distance/2, 0])
                    airfoil(naca = naca, L = length, N = 50, h= width, open = false);
                translate([0, -distance/2, 0])
                    cube([length, distance, width]);
            }}
            else{
                difference(){
                    translate([0, -distance/2, -2])
                        cube([length, distance, width+4]);
                    linear_extrude(width) polygon([
                        //[0, -1],
                        [0, stage1_dia/2],
                        [stage1_len, stage1_dia/2],
                        [stage2_pos, stage2_dia/2],
                        [stage2_pos+stage2_len, stage2_dia/2],
                        [length-stage3_len, stage3_dia/2],
                        [length, stage3_dia/2],

                        [length, -stage3_dia/2],
                        [length-stage3_len, -stage3_dia/2],
                        [stage2_pos+stage2_len, -stage2_dia/2],
                        [stage2_pos, -stage2_dia/2],
                        [stage1_len, -stage1_dia/2],
                        [0, -stage1_dia/2],
                        ]);
                }
            }

            // schod pro PCB
            hull(){
                translate([-15/2 + sensor_pos[0], distance/2, 0]) cube([15, sensor_rantl, width]);
                translate([-15/2 + sensor_pos[0], distance/2, 0]) cube([20, 0.1, width]);
            }



            // Krabicka na PCB

            union(){
                translate([sensor_pos[0] - pcb_sensor_from_top, distance/2, 0])
                    cube([pcb_length, sensor_rantl + pcb_thickness,
                          //width/2 - pcb_width/2 - pcb_offset - 1.1]);
                          width/2 - pcb_width/2 - pcb_offset]);
                translate([sensor_pos[0] - pcb_sensor_from_top, distance/2,
                           //width/2 + pcb_width/2 - pcb_offset - 1.1])
                           width/2 + pcb_width/2 - pcb_offset])
                    difference(){
                        cube([pcb_length, sensor_rantl + pcb_thickness,
                              //width/2 - pcb_width/2 + pcb_offset + 1.1]);
                              width/2 - pcb_width/2 + pcb_offset + 2]);
                        translate([-0.01, 0, 0])
                        rotate([-60, 0, 0])
                            cube([pcb_length + 0.02, sensor_rantl + pcb_thickness,
                                  width/2 - pcb_width/2 + pcb_offset]);
                    }
                translate([sensor_pos[0] - pcb_sensor_from_top - 2, distance/2, 0])
                    cube([2, sensor_rantl + pcb_thickness, width]);

            // PCB
            //if(!$preview)
            
            }
        }


        // jan.kott: What was this good for?
        //translate([0, 0, width/2 + 25 + rotor_head_width/2]) rotate([90-pylon_top_angle, 0, 0]) cube(50, center = true);
        //translate([0, 0, width/2 -25 - rotor_head_width/2]) rotate([pylon_top_angle, 0, 0]) cube(50, center = true);


        h = width/2;


        // trubicky pro tlak
        union(){
            if(!$preview)
            curvedPipe([
                    sensor_pos + [sensor_nose_distance/2, -sensor_nose_hole_depth-sensor_sealing_nose_length+0.1, 0],
                    sensor_pos + [sensor_nose_distance/2, -5, 0],
        			pipe2_pos  + [0, distance/2-6, 0],
        			pipe2_pos + [0, 0, 0]
                ],
                3,
    			[4, 4, 2, 2],
    		    pipe_d, 0
            );

            if(!$preview)
            curvedPipe([
                    sensor_pos + [-sensor_nose_distance/2, -sensor_nose_hole_depth-sensor_sealing_nose_length+0.1, 0],
                    sensor_pos + [-sensor_nose_distance/2, -7, 0],
        			pipe1_pos + [0, distance/2-4, 0],
        			pipe1_pos + [0, 0, 0],

                ],
                3,
    			[3, 2, 1, 2],
    		    pipe_d, 0
            );


            for(x = [0.5, -0.5])
            translate(sensor_pos + [sensor_nose_distance*x, 0, 0])
                rotate([90, 0, 0]){
                    cylinder(d = sensor_nose_hole_diameter, h= sensor_nose_hole_depth*2, center=true, $fn = 15);
                    translate([0, 0, sensor_nose_hole_depth]) cylinder(d2 = pipe_d, d1 = sensor_sealing_nose_diameter ,h= sensor_sealing_nose_length, $fn = 15);
                }

            }
        }
    }

    //  otvory pro pripevneni vicka
    cap_bolts();

    union(){
        // Rails
        for(y = [rail_h, width - rail_h + 2])
            translate([length/2 + 0.01, distance/2 + sensor_rantl + pcb_thickness , y])
                difference(){
                    rotate([45, 0, 0])
                        cube([length + 0.01, rail_x, rail_x], center=true);
                }
        // Lid front cut-out
        translate([0, distance/2 + sensor_rantl - 3, -0.01])
            cube([cap_head_overlay + 0.01, sensor_rantl + pcb_thickness + 0.01, width + 0.02]);
    }


    //if($preview) translate([-50, -50, width/2]) cube(100);
    }
}

888_5001();



module support_888_5001(){
    difference(){
        union(){
        translate([length-15, -width/2+1, distance/2+4])
            cube([15, 1, 20-5]);
        translate([length-15, width/2-2, distance/2+4])
            cube([15, 1, 20-5]);
            echo(parent_module(0));
            echo($parent_modules);
        }

        rotate([-90, 0, 0]) translate([length-15, -distance/2, -width/2]) difference() {
            hull(){
                translate([0, -15, 0]) cylinder(d = 10+0.4, h = width);
                translate([5, 0, 0]) cylinder(d = 5+0.4, h = width);
                translate([-5, 0, 0]) cylinder(d = 5+0.4, h = width);
            }
    }
}
}
// % support_888_5001();

module 888_5001_cap() translate([0, -width/2, -30]) rotate([-90, 0, 0]) {
    difference(){
        translate([0, distance/2 + 1, 0])
            union(){
                difference(){
                    airfoil(naca = naca, L = 1.3*length, N = 50, h= width + 2, open = false);
                    // Bottom cut-out
                    translate([cap_head_overlay - global_clearance, -length + 5, -width/2])
                        cube([length, length, 2*width]);
                    translate([-length/2, -length - 1, -width/2])
                        cube([2*length, length, 2*width]);
                }
                // Rails
                for(y = [rail_h, width - rail_h + 2])
                    translate([length/2 + 1, 5 + global_clearance/2, y])
                        difference(){
                            rotate([45, 0, 0])
                                cube([length - 1.5, rail_x, rail_x], center=true);
                            translate([0, rail_h, 0])
                                cube([length, 2*rail_h, 2*rail_h], center=true);
                        }
            }
        // Tail cut-out
        translate([length, 0, -width/2])
            cube([length, length, 2*width]);
        // Vertical bolts cut-out
        cap_bolts();
        // Horizontal  bolts cut-out
    }
}

module cap_bolts() {
    // Vertical bolts cut-out
    translate([sensor_pos[0] + 5, bolt_z + distance/2 , M3_head_diameter/2])
        rotate([90, -90, 0])
            bolt(3, 10);
    translate([sensor_pos[0] + 5, bolt_z + distance/2 , width - M3_head_diameter/2 + 2])
        rotate([90, 90, 0])
            bolt(3, 10);
}


888_5001_cap();
echo(width + 2);
