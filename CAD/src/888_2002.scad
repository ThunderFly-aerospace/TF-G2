
//@set_slicing_config(../slicing/default.ini)
include <../parameters.scad>

$fn = 90;

cylinder_r2 = 0;
suspension_depth = 18;
suspension_thickness = 0.41*6;
suspension_holder_flange_height = 25;
suspension_holder_thickness = 0.41*15;

suspension_camber = 10;

suspension_join_length = 22;
suspension_join_screw_distance = 12;

suspension_bow_diameter = 200;		//cylinder_r1



wheel_mount_thickness = 7;

angle = 55;
sin_angle = sin(angle);
cylinder_h = sqrt(((sin_angle^2)*(suspension_bow_diameter^2))/(4*((1-(sin_angle^2)))));

join_height = 10;
//join_height = suspension_depth/(tan(uhel)) + suspension_thickness;

presah = 3; //prodloužení kvůli přesahu ze zmenšení úhlu

module 888_2002()
{

	union(){
	translate([0,-suspension_bow_diameter/2 - join_height/2,suspension_depth/2])
		color([0,0.5,0])
			difference(){
				difference(){
					union(){
							cylinder(h= cylinder_h, r1=suspension_bow_diameter/2, r2= cylinder_r2);
						rotate([180,0,0])
							cylinder(h= cylinder_h, r1=suspension_bow_diameter/2, r2= cylinder_r2);
					}
					union(){
						translate([0,0,-0.01])
								cylinder(h= cylinder_h, r1=suspension_bow_diameter/2 - suspension_thickness, r2=1);
						translate([0,0,0.01])
							rotate([180,0,0])
								cylinder(h = cylinder_h, r1=suspension_bow_diameter/2 - suspension_thickness, r2=1);
					}


				}
				
				//prořezy
				//horní
				translate([0,0,suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,172])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,suspension_depth/4 + suspension_depth/16])
					rotate([90,-270,168])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,164])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,suspension_depth/4 + suspension_depth/16])
					rotate([90,-270,160])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,156])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,suspension_depth/4 + suspension_depth/16])
					rotate([90,-270,152])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,148])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,suspension_depth/4 + suspension_depth/16])
					rotate([90,-270,144])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,140])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,suspension_depth/4 + suspension_depth/16])
					rotate([90,-270,136])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,132])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,suspension_depth/4 + suspension_depth/16])
					rotate([90,-270,128])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,124])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,suspension_depth/4 + suspension_depth/16])
					rotate([90,-270,120])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,116])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,suspension_depth/4 + suspension_depth/16])
					rotate([90,-270,112])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,108])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,suspension_depth/4 + suspension_depth/16])
					rotate([90,-270,104])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				//dolní
				translate([0,0, - suspension_depth/4 + suspension_depth/16])
					rotate([90,-270,172])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,- suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,168])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0, - suspension_depth/4 + suspension_depth/16])
					rotate([90,-270,164])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,- suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,160])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0, - suspension_depth/4 + suspension_depth/16])
					rotate([90,-270,156])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,- suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,152])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0, - suspension_depth/4 + suspension_depth/16])
					rotate([90,-270,148])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,- suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,144])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0, - suspension_depth/4 + suspension_depth/16])
					rotate([90,-270,140])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,- suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,136])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0, - suspension_depth/4 + suspension_depth/16])
					rotate([90,-270,132])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,- suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,128])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0, - suspension_depth/4 + suspension_depth/16])
					rotate([90,-270,124])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,- suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,120])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0, - suspension_depth/4 + suspension_depth/16])
					rotate([90,-270,116])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,- suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,112])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0, - suspension_depth/4 + suspension_depth/16])
					rotate([90,-270,108])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,- suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,104])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);
					


				//odečtení zbylého kužele
				translate([-suspension_bow_diameter,-suspension_bow_diameter,-cylinder_h*2])
						cube([suspension_bow_diameter,suspension_bow_diameter*2,cylinder_h*4]);
				translate([-suspension_bow_diameter,0,-suspension_depth])
					rotate([0,0,-90])
						cube([suspension_bow_diameter,suspension_bow_diameter*2,cylinder_h*2]);
				translate([-1,-1,suspension_depth/2])
						cube([suspension_bow_diameter,suspension_bow_diameter*2,cylinder_h*2]);
				translate([-suspension_bow_diameter,-suspension_bow_diameter,- cylinder_h*2- suspension_depth/2])
						cube([suspension_bow_diameter*2,suspension_bow_diameter*2,cylinder_h*2]);
					rotate([0, 0, -90 + suspension_camber])
						translate([1,0,-10])
					   		cube(200);
				}
	}
//koncovky - hranatá
translate([0,-suspension_bow_diameter/2 - join_height,0])
	    difference(){
	        union(){
	            translate([0, suspension_bow_diameter/2-suspension_thickness/2 - presah, 0])
	                cube([suspension_holder_thickness, join_height + suspension_thickness/2 + presah, suspension_depth]);
	        }

	        translate([-0.1, suspension_bow_diameter/2 + join_height/2, suspension_depth/2 - 5])
	            rotate([0, 90, 0])
	                cylinder(d= M3_screw_diameter, h = 30);

	        translate([-0.1, suspension_bow_diameter/2 + join_height/2, suspension_depth/2 + 5])
	            rotate([0, 90, 0])
	               cylinder(d= M3_screw_diameter, h = 30);
	    }
// koncovky - oblá
	translate([0, -suspension_bow_diameter/2 - join_height/2, 0])

	        rotate([0, 0, suspension_camber])
	        translate([suspension_bow_diameter/2,-5, 0])
	            difference(){
	                hull(){
	                    translate([-suspension_thickness, 5, 0])
	                       cube([suspension_thickness, 1, suspension_depth]);
	                    #translate([-wheel_mount_thickness - presah, -3, 0])
	                       cube([wheel_mount_thickness + presah, 6, suspension_depth]);
	                    translate([0, 0, suspension_depth/2])
	                        rotate([0, -90, 0])
	                            cylinder(d = M3_screw_diameter+8, h = wheel_mount_thickness);
	                }

	                translate([0, 0, suspension_depth/2])
	                    rotate([0, 90, 0])
	                        cylinder(d = 6.5, h = 30, center = true);
	            }
}

888_2002();
