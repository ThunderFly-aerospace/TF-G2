include <../parameters.scad>

use <lib/stdlib/curvedPipe/curvedPipe.scad>
//use <lib/copyFunctions.scad>




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

type = "naca"; // "naca" or "cylinder"
//type = "cylinder";
width = 30;

pipe_d = 2;


// for NACA type
naca = 0040;
distance = 30;
length = 60;
profile_thickness = surface_distance(x = 0.25, naca = naca)*length;

sensor_rantl = 4;
sensor_pos = [10, distance/2 + sensor_rantl, width/2];
sensor_nose_distance = 4.3;
sensor_nose_hole_depth = 3;
sensor_nose_hole_diameter = 3;


// for cylinder type

stage1_len = 5;
stage1_dia = 20;
stage2_pos = 25;
stage2_dia = 10;
stage2_len = 5;
stage3_len = 1;
stage3_dia = 20;


pipe1_pos = [type=="naca"? 3: stage1_len/2, 0, width/2];
pipe2_pos = [type=="naca"?length*0.3333 : stage2_pos+stage2_len/2, 0, width/2];

    if(type == "naca"){
        intersection(){
            translate([0, -distance/2, 0]) airfoil(naca = naca, L = length, N = 50, h= width, open = false);
            translate([0, -distance/2, 0]) cube([length, distance, width]);
        }
            translate([0, -distance/2, -2]) cube([length, distance, 2]);
            translate([0, -distance/2, width]) cube([length, distance, 2]);

    }

    difference(){
        union(){
            if(type == "naca"){
            intersection(){
                translate([0, distance/2, 0]) airfoil(naca = naca, L = length, N = 50, h= width, open = false);
                translate([0, -distance/2, 0]) cube([length, distance, width]);
            }}
            else{
                difference(){
                    translate([0, -distance/2, -2]) cube([length, distance, width+4]);
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
                translate([-15/2 + sensor_pos[0], distance/2, 0]) cube([20, sensor_rantl, width]);
                translate([-15/2 + sensor_pos[0], distance/2, 0]) cube([35, 0.1, width]);
            }
        }

        h = width/2;

        if(!$preview)
        curvedPipe([
                sensor_pos + [sensor_nose_distance/2, 0, 0],
                sensor_pos + [sensor_nose_distance/2, -5, 0],
    			pipe2_pos  + [0, distance/2-5, 0],
    			pipe2_pos + [0, 0, 0]
            ],
            3,
			[4, 4, 3, 3],
		    pipe_d, 0
        );

        if(!$preview)
        curvedPipe([
                sensor_pos + [-sensor_nose_distance/2, 0, 0],
                sensor_pos + [-sensor_nose_distance/2, -5, 0],
    			pipe1_pos + [0, distance/2-5, 0],
    			pipe1_pos + [0, 0, 0],

            ],
            3,
			[4,4,3,3],
		    pipe_d, 0
        );


        for(x = [0.5, -0.5])
        translate(sensor_pos + [sensor_nose_distance*x, 0, 0])
            rotate([90, 0, 0])
                cylinder(d = sensor_nose_hole_diameter, h= sensor_nose_hole_depth*2, center=true, $fn = 15);

        }
}




888_5001();
