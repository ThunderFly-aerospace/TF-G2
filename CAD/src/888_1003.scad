//bocni steny

//@set_slicing_config(slicing/default.ini)
include <../parameters.scad>

sides_height = 90; //vyska sten
bellow = 5;
height = 20;
front_overlap = 0;
back_overlap = 20;
length = base_length + front_overlap + back_overlap; //delka sten z vykresu, nepouzity
thickness = 3; //sirka sten
drzak_height = 70; //spatny rozmer so far
sides_split_positions = [0, length/3, length/3*2, length];



module 888_1003(){

	difference(){
		hull(){
//kvadrik ("spolecny s podlozkou")
            translate([10, -base_thickness -rantl_height/2, 0])
	           cube([base_length-10, base_thickness + rantl_height, thickness]);

		    translate([3-front_overlap, 3-bellow, 0])
				cylinder(d = 6, h = thickness);

			translate([3-front_overlap, 3-bellow+10, 0])
				cylinder(d = 6, h = thickness);

			translate([30, 35-bellow, 0])
				cylinder(d = 12, h = thickness);

			translate([43-front_overlap + 20, -bellow + height + 19, 0])
				cylinder(d = 30, h = thickness);

			translate([43-front_overlap + 20 + 120, -bellow + height + 19, 0])
				cylinder(d = 30, h = thickness);

			translate([-40/2 + back_overlap + base_length, 10-bellow, 0])
				cylinder(d = 20, h = thickness);

			translate([-50/2 + back_overlap + base_length - 20, 25-bellow, 0])
				cylinder(d = 20, h = thickness);

			translate([-80 + base_length, height + 20 - 25, 0])
				cylinder(d = 30, h = thickness);
	   	}


        for(x = [10:10:base_length-10])
	        translate([x, 0, 0])
	            cylinder(d = M3_screw_diameter, h = 10, center = true, $fn = 50);

		for(x = [10*3:10:10*4])
	        translate([x, motor_holder_side_mount_height-5, 0])
	            cylinder(d = M3_screw_diameter, h = 10, center = true, $fn = 50);

        //for(x = [10+base_patern, 10+base_patern*2])
		for(x = [10*3:10:10*18])
	        translate([x, motor_holder_side_mount_height, 0])
	            cylinder(d = M3_screw_diameter, h = 10, center = true, $fn = 50);

		#for(x = [10*6:10:10*18])
	        translate([x, pilon_holder_side_mount_height, 0])
	            cylinder(d = M3_screw_diameter, h = 10, center = true, $fn = 50);


		// otvory ve stene
		for (i=[0:7])
			translate([i*28+50, 6.5, 0])
				minkowski(){
					cube([18, 12, 5]);
					cylinder(d=5, h = 2);
				}

		for (i=[0:4])
			translate([i*32+50, 31.5, 0])
				minkowski(){
					cube([18, 3, 5]);
					cylinder(d=5, h = 2);
				}


		translate([-1*32+50, 6.5, 0])
			minkowski(){
				cube([23, 7, 5]);
				cylinder(d=5, h = 2);
			}


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
        translate([i - front_overlap, 0, 0])
            cube([0.01, 200, 20], center = true);
    }
}

888_1003_crop_visualisation();
