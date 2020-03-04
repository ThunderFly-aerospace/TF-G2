//bocni steny

//@set_slicing_config(../slicing/default.ini)
include <../parameters.scad>

sides_height = 90; //vyska sten
bellow = 10;
height = 70;
front_overlap = 15;
back_overlap = 20;
length = base_length + front_overlap + back_overlap; //delka sten z vykresu, nepouzity
thickness = 3; //sirka sten
drzak_height = 70; //spatny rozmer so far
sides_split_positions = [0, length/3, length/3*2, length];



module 888_1003(){

	difference(){
		hull(){
//kvadrik ("spolecny s podlozkou")
            translate([0, -base_thickness -rantl_height/2, 0])
	           cube([base_length, base_thickness + rantl_height, thickness]);

			translate([15-front_overlap, 15-bellow, 0])
				cylinder(d = 30, h = thickness);
			translate([30-front_overlap + 20, -bellow + height - 30, 0])
				cylinder(d = 60, h = thickness);

			translate([-30/2 + back_overlap + base_length, 15-bellow, 0])
				cylinder(d = 30, h = thickness);
			translate([-80 + base_length, -bellow + height - 35, 0])
				cylinder(d = 40, h = thickness);

	   	}


        for(x = [10:10:base_length-10])
	        translate([x, 0, 0])
	            cylinder(d = M3_screw_diameter, h = 10, center = true, $fn = 50);
	}
}

888_1003();



module 888_1003_crop_visualisation(){
    %for (i=sides_split_positions) {
        translate([i - front_overlap, 0, 0])
            cube([0.01, 200, 20], center = true);
    }
}

888_1003_crop_visualisation();
