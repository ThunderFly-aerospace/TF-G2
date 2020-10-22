
//@set_slicing_config(../slicing/default.ini)
include <../parameters.scad>

$fn = 90;

zmenseni = 1.5;

cylinder_r2 = 0;
suspension_depth = 18; // zvetšit treba na 34
suspension_thickness = 0.41*6;
suspension_holder_flange_height = 25;
suspension_holder_thickness = 0.41*15;

suspension_camber = -2; // úhel zakončení, délka konstrukce

suspension_join_length = 22;
suspension_join_screw_distance = 10; // zvetsit na 20

suspension_bow_diameter = 200;		//cylinder_r1
suspension_bow_diameter_1 = 200 - 2*zmenseni;




wheel_mount_thickness = 7;

angle = 55;
sin_angle = sin(angle);
cylinder_h = sqrt(((sin_angle^2)*(suspension_bow_diameter^2))/(4*((1-(sin_angle^2)))));


cylinder_h_1 = sqrt(((sin_angle^2)*(suspension_bow_diameter^2))/(4*((1-(sin_angle^2))))) - zmenseni;

join_height = 10;
join_height_1 = 10 - zmenseni;


//join_height = suspension_depth/(tan(uhel)) + suspension_thickness;

presah = 3; //prodloužení kvůli přesahu ze zmenšení úhlu

module 888_2002()
{
////DRUHÝ POKUS



//rotate([0,0,180])


//obal
difference()
{


    union(){

       		cylinder (cylinder_h, suspension_bow_diameter/2,0);
        translate([0,0,-cylinder_h])
        	cylinder(cylinder_h,0, suspension_bow_diameter/2);
    }

    translate([join_height/2,0, -join_height])
    	cylinder(cylinder_h, suspension_bow_diameter/2,0);

    translate([join_height/2,0,+ join_height - cylinder_h])
    	cylinder(cylinder_h,0,suspension_bow_diameter/2);



//odstranění zbylého kužele
  	translate([0,-100,-200])
    	cube([200,200,400]);

    translate([-100,0,-200])
      	cube([200,200,400]);

  	translate([-100,-100,join_height - 0.1])
   		cube([200,200,400]);

  	translate([-100,-100,-400 - join_height + 0.1])
   		cube([200,200,400]);


//dutý
union(){
	difference()
	{


	    union(){
	       		cylinder (cylinder_h_1, suspension_bow_diameter_1/2,0);
	        translate([0,0,-cylinder_h_1])
	        	cylinder(cylinder_h_1,0, suspension_bow_diameter_1/2);
	    }

	    translate([join_height_1/2 - zmenseni,-zmenseni, -join_height_1])
	    	cylinder(cylinder_h_1, suspension_bow_diameter_1/2,0);

	    translate([join_height_1/2 - zmenseni,-zmenseni,+ join_height_1 - cylinder_h_1])
	    	cylinder(cylinder_h_1,0,suspension_bow_diameter_1/2);



	//odstranění zbylého kužele
	  	translate([zmenseni,-100,-200])
	    	cube([200,200,400]);

	    translate([-100,zmenseni,-200])
	      	cube([200,200,400]);

	  	translate([-100,-100,join_height_1 - 0.1])
	   		cube([200,200,400]);

	  	translate([-100,-100,-400 - join_height_1 + 0.1])
	   		cube([200,200,400]);

	}
}


	//prořezy

	for (i = [1:14])
		translate([0,0, + suspension_depth/9*i/14 + 2])
			rotate([90,-90,-6*i])
				cylinder(h = suspension_depth*10, r = suspension_depth/10 + (i*0.15), $fn=3);

	for (a = [1:15])
		translate([0,0, + (suspension_depth/9)*(a/15) + 3])
			rotate([90,-270,-6*a + 3])
				cylinder(h = suspension_depth*10, r = suspension_depth/10 + (a*0.15), $fn=3);


	for (b = [1:15])
		translate([0,0, - (suspension_depth/6)*(b/14) - 3 ])
			rotate([90,-90,-6*b + 3])
				cylinder(suspension_depth*10, suspension_depth/7, suspension_depth/7, $fn=3);

	for (c = [1:14])
		translate([0,0, - (suspension_depth/6)*(c/15) -  2])
			rotate([90,-270,-6*c])
				cylinder(suspension_depth*10, suspension_depth/7, suspension_depth/7, $fn=3);

}


//koncovky - hranatá
translate([4,0,-join_height +1])
	rotate ([0,0,90])
	    difference(){
	        union(){
	            translate([0, suspension_bow_diameter/2-suspension_thickness/2 - presah*2.6, 0])
	                cube([suspension_holder_thickness, join_height + suspension_thickness/2 + presah*2.6, suspension_depth]);
	        }

	        translate([-0.1, suspension_bow_diameter/2 + join_height/2, suspension_depth/2 - suspension_join_screw_distance/2])
	            rotate([0, 90, 0])
	                cylinder(d= M3_screw_diameter, h = 30);

	        translate([-0.1, suspension_bow_diameter/2 + join_height/2, suspension_depth/2 + suspension_join_screw_distance/2])
	            rotate([0, 90, 0])
	               cylinder(d= M3_screw_diameter, h = 30);
	    }

// koncovky - oblá
	    rotate([180, 0, -90])
	       translate([suspension_bow_diameter/2,-5, -suspension_depth/2])
	            difference(){
	                hull(){
	                    translate([-suspension_thickness, 5, 0])
	                       cube([suspension_thickness, 1, suspension_depth]);
	                    translate([-wheel_mount_thickness - presah*2.5, -3, 0])
	                       cube([wheel_mount_thickness + presah*2.5, 6, suspension_depth]);
	                    translate([0, 0, suspension_depth/2])
	                        rotate([0, -90, 0])
	                            cylinder(d = M3_screw_diameter+8, h = wheel_mount_thickness);
	                }

	                translate([0, 0, suspension_depth/2])
	                    rotate([0, 90, 0])
	                        cylinder(d = M3_screw_diameter, h = 30, center = true);

	            }


////PRVNÍ POKUS
/*

	union(){
//	translate([0,-suspension_bow_diameter/2 - join_height/2,suspension_depth/2])
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
					//zešikmení
					 translate([3,0,-cylinder_h*2])
				               cylinder(cylinder_h*4,suspension_bow_diameter/2-5,suspension_bow_diameter/2-10);


				//prořezy
				//horní

				union(){
				translate([0,0,suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,172])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);

				translate([0,0,suspension_depth/4.5 + suspension_depth/16])
					rotate([90,-270,168])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);

				translate([0,0,suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,164])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);

				translate([0,0,suspension_depth/4.5 + suspension_depth/16])
					rotate([90,-270,160])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);

				translate([0,0,suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,156])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);

				translate([0,0,suspension_depth/4.5 + suspension_depth/16])
					rotate([90,-270,152])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);

				translate([0,0,suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,148])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);

				translate([0,0,suspension_depth/5 + suspension_depth/16])
					rotate([90,-270,144])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);

				translate([0,0,suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,140])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);

				translate([0,0,suspension_depth/5 + suspension_depth/16])
					rotate([90,-270,136])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);

				translate([0,0,suspension_depth/4.5 - suspension_depth/16])
					rotate([90,-90,132])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);

				translate([0,0,suspension_depth/5 + suspension_depth/16])
					rotate([90,-270,128])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);

				translate([0,0,suspension_depth/4.5 - suspension_depth/16])
					rotate([90,-90,124])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);

				translate([0,0,suspension_depth/6 + suspension_depth/16])
					rotate([90,-270,120])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);


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

				translate([0,0,suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,100])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,suspension_depth/4 + suspension_depth/16])
					rotate([90,-270,96])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,92])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				}


				//dolní
				translate([0,0, - suspension_depth/3.5 + suspension_depth/16])
					rotate([90,-270,172])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);

				translate([0,0,- suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,168])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);

				translate([0,0, - suspension_depth/3.5 + suspension_depth/16])
					rotate([90,-270,164])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);

				translate([0,0,- suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,160])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);

				translate([0,0, - suspension_depth/3.5 + suspension_depth/16])
					rotate([90,-270,156])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);

				translate([0,0,- suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,152])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);

				translate([0,0, - suspension_depth/4 + suspension_depth/16])
					rotate([90,-270,148])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);

				translate([0,0,- suspension_depth/4.5 - suspension_depth/16])
					rotate([90,-90,144])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);

				translate([0,0, - suspension_depth/4 + suspension_depth/16])
					rotate([90,-270,140])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);

				translate([0,0,- suspension_depth/4.5 - suspension_depth/16])
					rotate([90,-90,136])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);

				translate([0,0, - suspension_depth/4.5 + suspension_depth/16])
					rotate([90,-270,132])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);

				translate([0,0,- suspension_depth/5 - suspension_depth/16])
					rotate([90,-90,128])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);

				translate([0,0, - suspension_depth/4.5 + suspension_depth/16])
					rotate([90,-270,124])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);

				translate([0,0,- suspension_depth/5.5 - suspension_depth/16])
					rotate([90,-90,120])
						cylinder(suspension_depth*10, suspension_depth/5, suspension_depth/5, $fn=3);

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

				translate([0,0, - suspension_depth/4 + suspension_depth/16])
					rotate([90,-270,100])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0,- suspension_depth/4 - suspension_depth/16])
					rotate([90,-90,96])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

				translate([0,0, - suspension_depth/4 + suspension_depth/16])
					rotate([90,-270,92])
						cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);


				//odečtení zbylého kužele
				translate([-suspension_bow_diameter,-suspension_bow_diameter,-cylinder_h*2])
						cube([suspension_bow_diameter,suspension_bow_diameter*2,cylinder_h*4]);
				translate([-suspension_bow_diameter,suspension_camber*2,-suspension_depth])
					rotate([0,0,-90])
						cube([suspension_bow_diameter,suspension_bow_diameter*2,cylinder_h*2]);
				translate([-suspension_bow_diameter,-suspension_bow_diameter,suspension_depth/2])
						cube([suspension_bow_diameter*2,suspension_bow_diameter*2,cylinder_h*2]);
				translate([-suspension_bow_diameter,-suspension_bow_diameter, -cylinder_h*2 - suspension_depth/2])
						cube([suspension_bow_diameter*2,suspension_bow_diameter*2,cylinder_h*2]);


				}
	}
//koncovky - hranatá
translate([0,-suspension_bow_diameter/2 - join_height,0])
	    difference(){
	        union(){
	            translate([0, suspension_bow_diameter/2-suspension_thickness/2 - presah*2.6, 0])
	                cube([suspension_holder_thickness, join_height + suspension_thickness/2 + presah*2.6, suspension_depth]);
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
	                    translate([-wheel_mount_thickness - presah*2.5, -3, 0])
	                       cube([wheel_mount_thickness + presah*2.5, 6, suspension_depth]);
	                    translate([0, 0, suspension_depth/2])
	                        rotate([0, -90, 0])
	                            cylinder(d = M3_screw_diameter+8, h = wheel_mount_thickness);
	                }

	                translate([0, 0, suspension_depth/2])
	                    rotate([0, 90, 0])
	                        cylinder(d = M3_screw_diameter, h = 30, center = true);
	            }


//druhá strana

	union(){
	//translate([0,-suspension_bow_diameter/2 - join_height,+ suspension_depth/2])
	translate([0,-suspension_bow_diameter/2 - join_height/2,0])

			color([0,0,1])
				difference(){

					intersection(){
						difference(){
							union(){
										cylinder(cylinder_h, suspension_bow_diameter/2, cylinder_r2);
								translate([0,0, -cylinder_h + suspension_depth])
										cylinder(cylinder_h, cylinder_r2, suspension_bow_diameter/2);
							}

						union(){
								translate([1,0,-2])
									cylinder(cylinder_h, suspension_bow_diameter/2 - suspension_thickness, cylinder_r2);
								translate([1,0,+2 - cylinder_h + suspension_depth])
									cylinder(cylinder_h, cylinder_r2, suspension_bow_diameter/2 - suspension_thickness);

							}

						}
					//zešikmení
					translate([3,0,-cylinder_h*2])
				          cylinder(cylinder_h*4,suspension_bow_diameter/2-5,suspension_bow_diameter/2-10);

					}





/////////////////////



					//}

					//prořezy
					//horní

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

					translate([0,0,suspension_depth/4 - suspension_depth/16])
						rotate([90,-90,100])
							cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

					translate([0,0,suspension_depth/4 + suspension_depth/16])
						rotate([90,-270,96])
							cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

					//dolní

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

					translate([0,0, - suspension_depth/4 + suspension_depth/16])
						rotate([90,-270,100])
							cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);

					translate([0,0,- suspension_depth/4 - suspension_depth/16])
						rotate([90,-90,96])
							cylinder(suspension_depth*10, suspension_depth/4, suspension_depth/4, $fn=3);



					//odečtení zbylého kužele

				translate([-suspension_bow_diameter,suspension_camber*2,-suspension_depth])
					rotate([0,0,-90])
						cube([suspension_bow_diameter,suspension_bow_diameter*2,cylinder_h*2]);
				translate([-suspension_bow_diameter,-suspension_bow_diameter - join_height/2,suspension_depth])
						cube([suspension_bow_diameter*2,suspension_bow_diameter*2,cylinder_h*2]);
				translate([-suspension_bow_diameter,-suspension_bow_diameter, -cylinder_h*2])
						cube([suspension_bow_diameter*2,suspension_bow_diameter*2,cylinder_h*2]);


					//zrkácení délky

						rotate([0, 0, -90 + suspension_camber])
							translate([1,0,-10])
						   		cube(200);

							translate([-200 ,0,-10])
						   		cube(200);

					// koncovky - oblá - odečtení otvoru pro šroub
			        rotate([0, 0, suspension_camber])
			        	translate([suspension_bow_diameter/2,-join_height/2, 0])
			                    rotate([0, 90, 0])
			                       cylinder(d = M3_screw_diameter, h = 30, center = true);
				}

	}
*/









}

888_2002();
