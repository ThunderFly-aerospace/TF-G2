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
thickness = 3; //sirka sten
drzak_height = 70; //spatny rozmer so far
sides_split_positions = [0, length/3, length/3*2, length];


module 888_1003_outline(){

		projection() difference(){
			union(){
				hull(){
		//kvadrik ("spolecny s podlozkou")
	        translate([10, -base_thickness -rantl_height/2, 0])
	         cube([base_length, base_thickness + rantl_height, thickness]);

			    translate([front_overlap, 9-bellow, 0])
						cylinder(d = 8, h = thickness);

					translate([front_overlap+18, 3-bellow+28, 0])
						cylinder(d = 6, h = thickness);

					translate([45, 45-bellow, 0])
						cylinder(d = 12, h = thickness);

					translate([43-front_overlap + 20, -bellow + height + 15, 0])
						cylinder(d = 30, h = thickness);

					translate([50-front_overlap + 13 + 200, -bellow + height + 22, 0])
						cylinder(d = 20, h = thickness);

					translate([-32 + back_overlap + base_length, 23, 0])
						cylinder(d = 10, h = thickness);

				}

				hull(){
					for(x = [10*13,10*21])
		        translate([x, pylon_holder_side_mount_height, -0.1])
		            cylinder(d = 5.5+5, h = 10);

						}

			}

			// otvory ve stene
			for (i=[0:6])
				translate([i*42, 0, 0]+[25, 5.5, -1])
				{
					hull(){
						translate([12, 0, 0]) cylinder(d=3, h = 20);
						translate([-12, 0, 0]) cylinder(d=3, h = 20);
						translate([0, 14, 0]) cylinder(d=3, h = 20);
					}
					if(i<6)hull(){
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
			linear_extrude(0.2*5)
				888_1003_outline();

			difference(){
				linear_extrude(3)
					offset(delta=0)
						888_1003_outline();
				linear_extrude(3.1)
					offset(delta=-0.4*3)
						888_1003_outline();
			}
		}
        for(x = [20:10:base_length])
	        translate([x, 0, -0.1])
	            cylinder(d = M3_screw_diameter, h = 10, center = true, $fn = 50);
	            //cylinder(d = 5.5, h = 10, center = true, $fn = 50);

        //for(x = [10+base_patern, 10+base_patern*2])
		for(x = [10*3:10:10*27])
	        translate([x, motor_holder_side_mount_height, -0.1])
	            cylinder(d = M3_screw_diameter, h = 10, center = true, $fn = 50);
	            //cylinder(d = 5.5, h = 10, center = true, $fn = 50);

		// Horni rada sroubu pro pylon
		for(x = [10*13:10:10*21])
	        translate([x, pylon_holder_side_mount_height, -0.1])
	            cylinder(d = M3_screw_diameter, h = 10, center = true, $fn = 50);
	            //cylinder(d = 5.5, h = 10, center = true, $fn = 50);

	}
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
