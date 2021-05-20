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

side_base_thickness = 0.2*6;

platform_ears_en = 0;
platform_ears_position = base_patern * [6, 25];
platform_ears_height = 11 + battery_case_height;
platform_ears_thickness = 2;
platform_ears_corner_radius = 3.5;
platform_ears_hole_from_bottom = 5;

additional_edge_thickness = 0.1;

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
					offset(delta=0 + additional_edge_thickness)
						888_1003_outline();
				linear_extrude(3.1)
					offset(delta=-0.4*3 - additional_edge_thickness)
						888_1003_outline();
			}

			for(x=cover_holes)
				translate([x, 0, 0]){
					cylinder(d = 8 + additional_edge_thickness/2, h = 5, $fn=30);
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

		}

		// nedelat otvory pro srouby v mistech otvoru pro pripevneni bocnic
		difference(){
			for(x = [20:10:base_length])
		        translate([x, 0, -0.1])
	            	cylinder(d = M3_screw_diameter, h = 10, center = true, $fn = 50);

			// Otvory pro kryt
			for(x=cover_holes)
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
		for(x = [40:10:10*18])
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
			for(x=cover_holes)
				translate([x, 0, -0.1]){
					cylinder(d = M3_nut_diameter, h = M3_nut_height+0.1, $fn=6);
					translate([0, 0, M3_nut_height+0.2+0.1]) cylinder(d = M3_screw_diameter, h = 10, $fn=30);
				}

			// Usi pro pripevneni k platforme
			for (x = platform_ears_position)
				translate([x, -platform_ears_corner_radius, 0])
					hull(){
						translate([0, -platform_ears_height + platform_ears_hole_from_bottom, 0])
							cylinder(d = 3.5, h = platform_ears_thickness+3, center = true, $fn = 20);
					}

	}

	translate([28, 4, side_base_thickness-0.4])
		linear_extrude(1.2)
			text(str(week), size = 6);
}








suspension_holder_thickness = 0.41*15;
suspension_bow_diameter = 200;      //cylinder_r1
suspension_join_screw_distance = 10;
join_height = 17;
presah = 5;

module mirror_copy(v=[1,0,0])
{
    children();
    mirror(v) children();
}

//koncovky - hranatá
module puvodni_koncovka()
{
            difference(){
            translate([suspension_holder_thickness/2, suspension_bow_diameter/2 - join_height/2, 0])
                cube([suspension_holder_thickness, join_height + 2*presah, 2*join_height], center=true);

            mirror_copy([0, 0, 1])
            translate([-0.1, suspension_bow_diameter/2 + presah/2 - M3_screw_diameter/2, suspension_join_screw_distance/2])
                rotate([0, 90, 0])
                    cylinder(d= M3_screw_diameter, h = 30);

            mirror_copy([0, 0, 1])
            translate([-0.1, suspension_bow_diameter/2 - join_height - M3_screw_diameter/2, suspension_join_screw_distance/2])
                rotate([0, 90, 0])
                    cylinder(d= M3_screw_diameter, h = 30);
        }
}


// vlastni parametry
// FIXME: nastavit mezi prvni radu sroubu
//        a druhou (na baterii), pekne doprostred
start_x = 39.6;
start_y = -105.5;

// volitelne parametry
additional_x_move=0;
additional_y_move=0;
additional_thickness = 0; // e.g. height
additional_height = 0;
additional_height_y_move = 0;
additional_width = 0;
additional_width_x_move = 0 ;

additional_height_nuts = 0; //
// M3_nut_height+0.2 + additional_height_nuts < suspension_holder_thickness + additional_thickness
// 2.7 + 2 < 6.15 + 2
// best is same as additional_thickness

// minimalni zdvih
// additional_thickness = 1.5 ; // pro M3x12
// additional_thickness = -0.5 ; // pro M3x10

// FIXME: správné umístění
module 888_2004(){
difference(){
    translate([start_x + additional_x_move, start_y + additional_y_move, 6])
    rotate ([0,90,0])
        difference(){
            translate([suspension_holder_thickness/2 - additional_thickness/2 , suspension_bow_diameter/2 - join_height/2 + additional_height_y_move, additional_width_x_move])
                cube([suspension_holder_thickness + additional_thickness,
     join_height + 2*presah + additional_height,
     join_height + additional_width], center=true);
            translate([0,additional_height_y_move,additional_width_x_move])
            mirror_copy([0, 0, 1])
            translate([-0.1, suspension_bow_diameter/2 + presah/2 - M3_screw_diameter/2, suspension_join_screw_distance/2])
                rotate([0, 90, 0]){
                    translate([0,0,-additional_thickness])
                    cylinder(d= M3_screw_diameter, h = 30 + additional_thickness);
                    translate([0,0,2.4 -  additional_height_nuts])
                cylinder(d = M3_nut_diameter, h = M3_nut_height+0.2 + additional_height_nuts, $fn = 6);
            }
            translate([0,additional_height_y_move,additional_width_x_move])
            mirror_copy([0, 0, 1])
            translate([-0.1, suspension_bow_diameter/2 - join_height - M3_screw_diameter/2, suspension_join_screw_distance/2])
                rotate([0, 90, 0]){
                    translate([0,0,-additional_thickness])
                    cylinder(d= M3_screw_diameter, h = 30 + additional_thickness);
                    translate([0,0,2.4 - additional_height_nuts])
                cylinder(d = M3_nut_diameter, h = M3_nut_height+0.2 + additional_height_nuts, $fn = 6);
                }
        };
    888_1003();

    // clear bottom
    translate([0, -50, -0.5])
      cube([120,130,1.7]);

    // Otvory pro kryt
    //    - negativ difference (1003 has positive)
	for(x=cover_holes)
		translate([x, 0, 0])
			cylinder(d = 8 + additional_edge_thickness/2, h = suspension_holder_thickness+0.1, $fn=30);

    // dolni rada
	for(x = [20:10:base_length])
		        translate([x, 0, -0.1 + additional_thickness]){
                    translate([0, 0, -additional_thickness/2])
	            	cylinder(d = M3_screw_diameter, h = 10 +additional_thickness, center = true, $fn = 50);
    translate([0,0,4.6])
                cylinder(d = M3_head_diameter, h = M3_head_height + 0.2, $fn = 30, center = true);
            }
		
	
    // Rada sroubu pro akumulator
	for(x = [40:10:10*18])
	        translate([x, -bellow - 5, -0.1 +additional_thickness]){
                translate([0, 0, -additional_thickness/2])
	            cylinder(d = M3_screw_diameter, h = 10 + additional_thickness, center = true, $fn = 50);
                translate([0,0,4.6])
                cylinder(d = M3_head_diameter, h = M3_head_height + 0.2, $fn = 30, center = true);
            }
        }

}

// pozice soucastek - test
if(true){
    translate([start_x + additional_x_move, start_y + additional_y_move, 12.2+ additional_thickness])
        rotate ([0,90,0])
            puvodni_koncovka();
    888_1003();
    888_2004();
}
