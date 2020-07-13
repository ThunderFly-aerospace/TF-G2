
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

angle = 70;
sin_angle = sin(angle);
cylinder_h = sqrt(((sin_angle^2)*(suspension_bow_diameter^2))/(4*((1-(sin_angle^2)))));

join_height = 10;
//join_height = suspension_depth/(tan(uhel)) + suspension_thickness;

module 888_2002()
{
	/*
	translate([suspension_depth,0,suspension_depth/6])
	rotate([90,-90,0])
 %cylinder(suspension_depth*10,suspension_depth/4,suspension_depth/4,$fn=3);
*/

//cylinder(h = cylinder_h, r1 = suspension_bow_diameter/2, r2 = cylinder_r2);

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
				//zpevnění
					union(){
							translate([suspension_depth/1.5,suspension_bow_diameter,suspension_depth/5.5])
								rotate([90,-90,0])
									cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
							
							translate([suspension_depth/1.5 + suspension_depth/3,suspension_bow_diameter,suspension_depth/3.07])
								rotate([90,90,0])
									cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
								rotate([180,0,0])
									union(){
										translate([suspension_depth/1.5,suspension_bow_diameter,suspension_depth/5.5])
											rotate([90,-90,0])
												cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
										
										translate([suspension_depth/1.5 + suspension_depth/3,suspension_bow_diameter,suspension_depth/3.07])
											rotate([90,90,0])
												cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
									}
						translate([suspension_depth - suspension_depth/3,0,0])
							union(){
									union(){
										translate([suspension_depth/1.5,suspension_bow_diameter,suspension_depth/5.5])
											rotate([90,-90,0])
												cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
										
										translate([suspension_depth/1.5 + suspension_depth/3,suspension_bow_diameter,suspension_depth/3.07])
											rotate([90,90,0])
												cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
									}
								rotate([180,0,0])
									union(){
										translate([suspension_depth/1.5,suspension_bow_diameter,suspension_depth/5.5])
											rotate([90,-90,0])
												cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
										
										translate([suspension_depth/1.5 + suspension_depth/3,suspension_bow_diameter,suspension_depth/3.07])
											rotate([90,90,0])
												cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
									}
							}
						translate([suspension_depth*2 - 2*suspension_depth/3,0,0])
							union(){
									union(){
										translate([suspension_depth/1.5,suspension_bow_diameter,suspension_depth/5.5])
											rotate([90,-90,0])
												cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
										
										translate([suspension_depth/1.5 + suspension_depth/3,suspension_bow_diameter,suspension_depth/3.07])
											rotate([90,90,0])
												cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
									}
								rotate([180,0,0])
									union(){
										translate([suspension_depth/1.5,suspension_bow_diameter,suspension_depth/5.5])
											rotate([90,-90,0])
												cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
										
										translate([suspension_depth/1.5 + suspension_depth/3,suspension_bow_diameter,suspension_depth/3.07])
											rotate([90,90,0])
												cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
									}
							}

						translate([suspension_depth*3 - 3*suspension_depth/3,0,0])
							union(){
									union(){
										translate([suspension_depth/1.5,suspension_bow_diameter,suspension_depth/5.5])
											rotate([90,-90,0])
												cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
										
										translate([suspension_depth/1.5 + suspension_depth/3,suspension_bow_diameter,suspension_depth/3.07])
											rotate([90,90,0])
												cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
									}
								rotate([180,0,0])
									union(){
										translate([suspension_depth/1.5,suspension_bow_diameter,suspension_depth/5.5])
											rotate([90,-90,0])
												cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
										
										translate([suspension_depth/1.5 + suspension_depth/3,suspension_bow_diameter,suspension_depth/3.07])
											rotate([90,90,0])
												cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
									}
							}
						translate([suspension_depth*4 - 4*suspension_depth/3,0,0])
							union(){
									union(){
										translate([suspension_depth/1.5,suspension_bow_diameter,suspension_depth/5.5])
											rotate([90,-90,0])
												cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
										
										translate([suspension_depth/1.5 + suspension_depth/3,suspension_bow_diameter,suspension_depth/3.07])
											rotate([90,90,0])
												cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
									}
								rotate([180,0,0])
									union(){
										translate([suspension_depth/1.5,suspension_bow_diameter,suspension_depth/5.5])
											rotate([90,-90,0])
												cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
										
										translate([suspension_depth/1.5 + suspension_depth/3,suspension_bow_diameter,suspension_depth/3.07])
											rotate([90,90,0])
												cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
									}
							}
						translate([suspension_depth*5 - 5*suspension_depth/3,0,0])
							union(){
									union(){
										translate([suspension_depth/1.5,suspension_bow_diameter,suspension_depth/5.5])
											rotate([90,-90,0])
												cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
										
										translate([suspension_depth/1.5 + suspension_depth/3,suspension_bow_diameter,suspension_depth/3.07])
											rotate([90,90,0])
												cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
									}
								rotate([180,0,0])
									union(){
										translate([suspension_depth/1.5,suspension_bow_diameter,suspension_depth/5.5])
											rotate([90,-90,0])
												cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
										
										translate([suspension_depth/1.5 + suspension_depth/3,suspension_bow_diameter,suspension_depth/3.07])
											rotate([90,90,0])
												cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
									}
							}
						translate([suspension_depth*6 - 6*suspension_depth/3,0,0])
							union(){
									union(){
										translate([suspension_depth/1.5,suspension_bow_diameter,suspension_depth/5.5])
											rotate([90,-90,0])
												cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
										
										translate([suspension_depth/1.5 + suspension_depth/3,suspension_bow_diameter,suspension_depth/3.07])
											rotate([90,90,0])
												cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
									}
								rotate([180,0,0])
									union(){
										translate([suspension_depth/1.5,suspension_bow_diameter,suspension_depth/5.5])
											rotate([90,-90,0])
												cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
										
										translate([suspension_depth/1.5 + suspension_depth/3,suspension_bow_diameter,suspension_depth/3.07])
											rotate([90,90,0])
												cylinder(suspension_depth*20, suspension_depth/3.5, suspension_depth/3.5,$fn=3);
									}
							}
					}



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
translate([0,-suspension_bow_diameter/2 - join_height,0])
	    difference(){
	        union(){
	            translate([0, suspension_bow_diameter/2-suspension_thickness/2, 0])
	                cube([suspension_holder_thickness, join_height + suspension_thickness/2, suspension_depth]);
	        }

	        translate([-0.1, suspension_bow_diameter/2 + join_height/2, suspension_depth/2 - 5])
	            rotate([0, 90, 0])
	                cylinder(d= M3_screw_diameter, h = 30);

	        translate([-0.1, suspension_bow_diameter/2 + join_height/2, suspension_depth/2 + 5])
	            rotate([0, 90, 0])
	               cylinder(d= M3_screw_diameter, h = 30);
	    }
	translate([0, -suspension_bow_diameter/2 - join_height/2, 0])

	        rotate([0, 0, suspension_camber])
	        translate([suspension_bow_diameter/2,-5, 0])
	            difference(){
	                hull(){
	                    translate([-suspension_thickness, 5, 0])
	                       cube([suspension_thickness, 1, suspension_depth]);
	                    #translate([-wheel_mount_thickness, -3, 0])
	                       cube([wheel_mount_thickness, 6, suspension_depth]);
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
