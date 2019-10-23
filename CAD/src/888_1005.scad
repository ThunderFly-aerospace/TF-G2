// drzak podelnych tyci k ocasu

include <../parameters.scad>

flange_thickness = 3;
flange_length = 10.16*5;
flange_depth = 10;


module 888_1005(){

	difference(){
		union(){
			// zakladni kostka
			translate([0, 0, flange_thickness/2])
				cube([flange_depth, flange_length, flange_thickness], center = true);
			
			// Kostka pro tyc
			translate([-flange_depth/2, -tail_pipes_diameter/2- tail_pipes_min_wall - tail_pipes_distance/2, 0])
				cube([flange_depth, tail_pipes_min_wall*2+tail_pipes_diameter, 2*tail_pipes_min_wall + tail_pipes_diameter + 4]);

			translate([-flange_depth/2, -tail_pipes_diameter/2- tail_pipes_min_wall + tail_pipes_distance/2, 0])
				cube([flange_depth, tail_pipes_min_wall*2+tail_pipes_diameter, 2*tail_pipes_min_wall + tail_pipes_diameter + 4]);
		}

		

	//  diry pro trubku
		translate([0, tail_pipes_distance/2, tail_pipes_diameter/2 + tail_pipes_min_wall])
			rotate([0, 90, 0])
				cylinder(d = tail_pipes_diameter, h = 20, center = true, $fn = 60);

		translate([0, -tail_pipes_distance/2, tail_pipes_diameter/2 + tail_pipes_min_wall])
			rotate([0, 90, 0])
				cylinder(d = tail_pipes_diameter, h = 20, center = true, $fn = 60);


	// mezera umoznujici stazeni dilu
		translate([-flange_depth/2, -0.5 + tail_pipes_distance/2, tail_pipes_diameter/2 + tail_pipes_min_wall])
			cube([flange_depth, 1, 50]);

		translate([-flange_depth/2, -0.5 - tail_pipes_distance/2, tail_pipes_diameter/2 + tail_pipes_min_wall])
			cube([flange_depth, 1, 50]);


	// diry pro sesroubovani
		translate([0, 0, tail_pipes_diameter + tail_pipes_min_wall*2])
			rotate([90, 0, 0])
				cylinder(d = M3_screw_diameter, h = 100, center = true, $fn = 60);

		translate([0, -tail_pipes_distance/2 - 3, tail_pipes_diameter + tail_pipes_min_wall*2])
			rotate([90, 0, 0])
				cylinder(d = M3_nut_diameter, h = 10, $fn = 60);

		translate([0, tail_pipes_distance/2 + 3 + 10, tail_pipes_diameter + tail_pipes_min_wall*2])
			rotate([90, 0, 0])
				cylinder(d = M3_nut_diameter, h = 10, $fn = 60);

		translate([0, -tail_pipes_distance/2 + 3 + 10, tail_pipes_diameter + tail_pipes_min_wall*2])
			rotate([90, 0, 0])
				cylinder(d = M3_nut_diameter, h = 10, $fn = 6);

		translate([0, tail_pipes_distance/2 - 3 , tail_pipes_diameter + tail_pipes_min_wall*2])
			rotate([90, 0, 0])
				cylinder(d = M3_nut_diameter, h = 10, $fn = 6);


	// diry pro sesroubovani k podlozce
		for(i = [-1, 0, 1]){

			translate([0, base_patern*i, 0])
				cylinder(d = M3_screw_diameter, h = 10, center = true, $fn = 50);
		}
	}
}


888_1005();