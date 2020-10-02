include <../parameters.scad>

use <lib/stdlib/curvedPipe/curvedPipe.scad>
//use <lib/copyFunctions.scad>




type = "naca"; // "naca" or "cylinder"
//type = "cylinder";
width = rotor_head_width;
echo("Sirka");
echo(rotor_head_width);

pipe_d = 2;


// for NACA type
naca = 0040;
distance = 25;
length = 45;
profile_thickness = surface_distance(x = 0.25, naca = naca)*length;

sensor_rantl = 3;
sensor_pos = [10, distance/2 + sensor_rantl, width/2];
sensor_nose_distance = 4.3;
sensor_nose_hole_depth = 2.5;
sensor_nose_hole_diameter = 3.5;
sensor_sealing_nose_diameter = 1.5;
sensor_sealing_nose_length = 2;


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

    union(){
    if(type == "naca"){
        intersection(){
            translate([0, -distance/2, 0]) airfoil(naca = naca, L = length, N = 50, h= width, open = false);
            //translate([0, -distance/2, 0]) cube([length, distance, width]);
        }
            translate([0, -distance/2, 0]) cube([length, distance, 2]);
            translate([0, -distance/2, width-2]) cube([length, distance, 2]);
    }

    translate([length-15, -distance/2, 0]) difference() {
        hull(){
            translate([0, -15, 0]) cylinder(d = 10, h = width);
            translate([5, 0, 0]) cylinder(d = 5, h = width);
            translate([-5, 0, 0]) cylinder(d = 5, h = width);
        }

        translate([0, -15, width/2]) cube( rotor_head_width-2*rotorhead_wall_thickness, center = true);

        }

    difference(){
        union(){
            if(type == "naca"){
            intersection(){
                translate([0, distance/2, 0]) airfoil(naca = naca, L = length, N = 50, h= width, open = false);
                union(){
                    translate([0, -distance/2, 0]) cube([length, distance, width]);
                    cube([10, distance/2 + sensor_rantl, width]);
                }
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
            hull(){
                translate([-15/2 + sensor_pos[0], distance/2, 0]) cube([15, sensor_rantl, width]);
                translate([-15/2 + sensor_pos[0], distance/2, 0]) cube([20, 0.1, width]);
            }
        }



        translate([0, 0, width/2 + 25 + rotor_head_width/2]) rotate([90-pylon_top_angle, 0, 0]) cube(50, center = true);
        translate([0, 0, width/2 -25 - rotor_head_width/2]) rotate([pylon_top_angle, 0, 0]) cube(50, center = true);


        h = width/2;


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


    // difference od celeho tvaru


    /// otvory pro pripevneni rotorove hlavy
    translate([length-15, -distance/2, 0]){
        translate([0, -15, 0])
            cylinder(d = M3_screw_diameter, h = width, $fn = 20);

        for(y = [5, -5])
            translate([y, 0, 0]){
                cylinder(d = M3_screw_diameter, h = width, $fn = 20);
                for(x = [4, width-4-M3_nut_height])
                    translate([0, 0, x])
                        hull(){
                            cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6);
                            translate([0, -10, 0]) cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6);
                        }

            }
        }

    //  otvory pro pripevneni vicka

    translate([0, 0, 0])
        for(y = [[4, 1], [width-4, -1]])
            translate([sensor_pos[0], +distance/2+sensor_rantl, y[0]]){
            rotate([90, 0, 0]) cylinder(d = M3_screw_diameter, h=8, $fn = 15);
            hull(){
                translate([0, -3, 0]) rotate([90, 0, 0]) cylinder(d = M3_nut_diameter, h=M3_nut_height, $fn = 6);
                translate([0, -3, -10*y[1]]) rotate([90, 0, 0]) cylinder(d = M3_nut_diameter, h=M3_nut_height, $fn = 6);
            }
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
% support_888_5001();
