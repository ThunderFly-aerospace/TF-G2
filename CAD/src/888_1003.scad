//bocni steny

//@set_slicing_config(slicing/default.ini)
include <../parameters.scad>

$fn = $preview? 10:30;

sides_height = 90; //vyska sten
bellow = 5;
height = 20;
front_overlap = 7;
back_overlap = 20;
length = base_length + front_overlap + back_overlap; //delka sten z vykresu, nepouzity
thickness = 1; //tloustka sten
drzak_height = 70; //spatny rozmer so far
sides_split_positions = [-5, length/3-5, length/3*2, length];



platform_ears_en = 0;
platform_ears_position = base_patern * [6, 25];
platform_ears_height = 25;
platform_ears_height = 11 + battery_case_height;
platform_ears_thickness = 2;
platform_ears_corner_radius = 3.5;
platform_ears_hole_from_bottom = 5;



module 888_1003_outline(){

		projection()
			difference(){
				union(){
					hull(){
			//kvadrik ("spolecny s podlozkou")
				        translate([10+15, -base_thickness -rantl_height/2, 0])
				        	cube([base_length+6-15, base_thickness + rantl_height, 1]);

				       	// vepredu ve vysce prostrednich der na policky
					    translate([10*3, motor_holder_side_mount_height, 0])
					    	cube([M3_screw_diameter+7, M3_screw_diameter+15, 1], center = true);
							//cylinder(d = M3_screw_diameter+7, h = 1);

						translate([45, 45-bellow, 0])
							cylinder(d = 12, h = 1);

						translate([50-front_overlap + 13 + 200, -bellow + height + 22, 0])
							cylinder(d = 20, h = 1);

	                    for(x = [42:10:10*26+2])
				            translate([x, pylon_holder_side_mount_height, -0.1])
				                cylinder(d = 5.5+5, h = 10);

					}
				


				translate([battery_case_start_x,0,0])
					hull(){
					//Spodni cast pro akumulator
	        			translate([0, -base_thickness -rantl_height/2, 0])
	        				cube([battery_length+20, base_thickness + rantl_height, 1]);

			    		translate([10, -bellow - 10, 0])
							cylinder(d = 8, h = 1);

						translate([battery_length+10, -bellow - 10, 0])
							cylinder(d = 8, h = 1);
					}
				}
			// otvory ve stene
			for (i=[0:6])
				translate([i*42, 0, 0]+[25, 5.5, -1])
				{
					if(i!=0)hull(){
						translate([12, 0, 0]) cylinder(d=3, h = 20);
						translate([-12, 0, 0]) cylinder(d=3, h = 20);
						translate([0, 14, 0]) cylinder(d=3, h = 20);
					}
					if(i!=6)hull(){
						translate([21+12, 14, 0]) cylinder(d=3, h = 20);
						translate([21-12, 14, 0]) cylinder(d=3, h = 20);
						translate([21, 0, 0]) cylinder(d=3, h = 20);
					}
				}


			for (i=[0:5])
				translate([i*42, 0, 0]+[25+42/2, 6+23.5, -1])
				{
					hull(){
						translate([12, 0, 0]) cylinder(d=1, h = 20);
						translate([-12, 0, 0]) cylinder(d=1, h = 20);
						translate([0, 11, 0]) cylinder(d=1, h = 20);
					}
					if(i<5)hull(){
						translate([21+12, 11, 0]) cylinder(d=1, h = 20);
						translate([21-12, 11, 0]) cylinder(d=1, h = 20);
						translate([21, 0, 0]) cylinder(d=1, h = 20);
					}
				}


		}

}


module 888_1003(){

	difference(){


		union(){
			linear_extrude(side_base_thickness)
				888_1003_outline();

			difference(){
				linear_extrude(3)
					offset(delta=0)
						888_1003_outline();
				linear_extrude(3.1)
					offset(delta=-0.4*3)
						888_1003_outline();
			}

			for(x=platform_mount_points)
				translate([x, 0, 0]){
					cylinder(d = 8, h = 5, $fn=30);
				}

			// Usi pro pripevneni k platforme
			
			if(platform_ears_en)
			for (x = platform_ears_position)
				translate([x, 0, 0]){
					hull()
						for(pos = [[-base_patern, 0], [base_patern, 0], [-base_patern/2, -platform_ears_height], [base_patern/2, -platform_ears_height] ])
							translate([pos[0], pos[1], 0])
								cylinder(r = platform_ears_corner_radius, h = platform_ears_thickness);
						for(pos = [[-base_patern/2, -platform_ears_height], [base_patern/2, -platform_ears_height] ])
							hull(){
								translate([pos[0]-1, pos[1]+8, 0]) cube([2, 32, 4]);

					}
				}

			if(1){
				translate([35, 0, 0]) translate([-10, -15-4, 0]) cube([20, 23, 5]);
				translate([35, 0, 0]) translate([-10, -15-4, 0]) cube([15, 23+5, 3]);
			}

		}

		// nedelat otvory pro srouby v mistech otvoru pro pripevneni bocnic
		difference(){
			for(x = [20:10:base_length])
		        translate([x, 0, -0.1])
	            	cylinder(d = M3_screw_diameter, h = 15, center = true, $fn = 50);

			// Otvory pro kryt
			for(x=platform_mount_points)
				translate([x, 0, 0])
					cylinder(d = 8, h = 5, $fn=30);
		}

        //for(x = [10+base_patern, 10+base_patern*2])
		for(x = [10*3:10:10*27])
	        translate([x, motor_holder_side_mount_height, -0.1])
	            cylinder(d = M3_screw_diameter, h = 10, center = true, $fn = 50);
	            //cylinder(d = 5.5, h = 10, center = true, $fn = 50);

		// Horni rada sroubu pro pylon
		for(x = [42:10:10*26+2])
	        translate([x, pylon_holder_side_mount_height, -0.1])
	            cylinder(d = M3_screw_diameter, h = 10, center = true, $fn = 50);
	            //cylinder(d = 5.5, h = 10, center = true, $fn = 50);

		// Rada sroubu pro akumulator
		for(x = [60:10:10*18])
	        translate([x, -bellow - 5, -0.1])
	            cylinder(d = M3_screw_diameter, h = 10, center = true, $fn = 50);
	            //cylinder(d = 5.5, h = 10, center = true, $fn = 50);
        
		// Rada sroubu predni sklonena hrana
        translate([42, pylon_holder_side_mount_height, 0])
	        rotate([0,0,-135])
				for(x = [0:10:10*1])
			        translate([x, 0, -0.1])
			            cylinder(d = M3_screw_diameter, h = 10, center = true, $fn = 50);
        
		// Rada sroubu zadni sklonena hrana
        translate([10*26+2, pylon_holder_side_mount_height, 0])
        rotate([0,0,-48])
		for(x = [0:10:10*5])
	        translate([x, 0, -0.1])
	            cylinder(d = M3_screw_diameter, h = 10, center = true, $fn = 50);


		// Otvory pro kryt
		for(x=platform_mount_points)
			translate([x, 0, -0.1]){
				cylinder(d = M3_nut_diameter, h = M3_nut_height+0.1, $fn=6);
				translate([0, 0, M3_nut_height+0.2+0.1]) cylinder(d = M3_screw_diameter, h = 10, $fn=30);
			}

		// // Usi pro pripevneni k platforme
		// for (x = platform_ears_position)
		// 	translate([x, -platform_ears_corner_radius, 0])
		// 		hull(){
		// 			translate([0, -platform_ears_height + platform_ears_hole_from_bottom, 0])
		// 				cylinder(d = 3.5, h = platform_ears_thickness+3, center = true, $fn = 20);
		// 	}

	}

	translate([48, -13, side_base_thickness-0.4])
		linear_extrude(1.2)
			text(str(week), size = 6);
}


888_1003();



module 888_1003_part(part = 0){

    x0 = sides_split_positions[part];
    length = sides_split_positions[part+1] - sides_split_positions[part];

    translate([-x0, 0, 0])
	    intersection(){
	        translate([x0, -100, -10])
	        	cube([length, 200, base_thickness+30]);
	        888_1003();
	    }
}

module 888_1003_crop_visualisation(){
    %for (i=sides_split_positions) {
        translate([i - front_overlap, 20, 0])
            cube([0.01, 80, 10], center = true);
    }
}

888_1003_crop_visualisation();
