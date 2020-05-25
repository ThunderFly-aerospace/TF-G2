
//@set_slicing_config(../slicing/default.ini)
include <../parameters.scad>

$fn = 90;
suspension_depth = 18;
suspension_thickness = 0.41*6;
suspension_holder_flange_height = 25;
suspension_holder_thickness = 0.41*15;

suspension_camber = 10;

suspension_join_length = 22;
suspension_join_screw_distance = 12;

suspension_bow_diameter = 200;

join_height = 10;

wheel_mount_thickness = 7;

module 888_2002()
/*
translate([0, -suspension_bow_diameter/2 - join_height/2, 0]){

    intersection(){
        difference(){
            cylinder(d = suspension_bow_diameter, h = suspension_depth);
            translate([0, 0, -0.1])
                cylinder(d = suspension_bow_diameter - suspension_thickness*2, h = suspension_depth + .2);
            rotate([0, 0, 90]) cube(200);
            rotate([0, 0, -90 + suspension_camber]) cube(200);
        }

        cube(200);
    }

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

    rotate([0, 0, suspension_camber])
        translate([suspension_bow_diameter/2, -5, 0])
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
*/
//prolis

union(){
translate([0,-suspension_bow_diameter/2 - join_height/2,9])
	color([0,0.5,0])
		difference(){
			difference(){
				union(){
						cylinder(h=350, r1=suspension_bow_diameter/2, r2=1);
					rotate([180,0,0])
						cylinder(h=350, r1=suspension_bow_diameter/2, r2=1);
				}
				union(){
					translate([0,0,-0.01])
							cylinder(h=300, r1=suspension_bow_diameter/2 - suspension_thickness, r2=1);
					translate([0,0,0.01])
						rotate([180,0,0])
							cylinder(h=300, r1=suspension_bow_diameter/2 - suspension_thickness, r2=1);
				}
			}
			translate([-150,-200,-30])
					cube([150,400,450]);
			translate([-150,0,-30])
				rotate([0,0,-90])
					cube([150,400,450]);
			translate([-1,-1,9])
					cube([150,400,450]);
			translate([-450/2,-450/2,-450 - 9])
					cube([450,450,450]);
				rotate([0, 0, -90 + suspension_camber]) 
					translate([1,0,-10])
				   		cube(200);

					//translate([0,0,-0.1])
			//cylinder(h=4, r1=suspension_bow_diameter/2 - suspension_thickness);
		}
}
translate([0, -suspension_bow_diameter/2 - join_height/2 - 4.2, 0])
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



888_2002();
