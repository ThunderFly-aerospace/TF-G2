//bocni steny

//@set_slicing_config(slicing/default.ini)
include <../parameters.scad>
use <888_1003.scad>


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

additional_edge_thickness = 0.1;

suspension_holder_thickness = 0.41*15;
suspension_bow_diameter = 200;      //cylinder_r1
suspension_join_screw_distance = 20;
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

// pomocne parametry
// layer_thickness = 0;

// volitelne parametry
additional_x_move=5;
additional_y_move=0;
additional_thickness = 0; // e.g. height
additional_height = 6;
additional_height_y_move = 1;
additional_width = 20;
additional_width_x_move = 0 ;

additional_height_nuts = 0; //
// M3_nut_height+0.2 + additional_height_nuts < suspension_holder_thickness + additional_thickness
// 2.7 + 2 < 6.15 + 2
// best is same as additional_thickness

// minimalni zdvih
// additional_thickness = 1.5 ; // pro M3x12
// additional_thickness = -0.5 ; // pro M3x10

// FIXME: správné umístění
module 888_2004(draft){
difference(){
    translate([start_x + additional_x_move, start_y + additional_y_move, 6])
    rotate ([0,90,0])
        difference(){
            translate([suspension_holder_thickness/2 - additional_thickness/2 , suspension_bow_diameter/2 - join_height/2 + additional_height_y_move, additional_width_x_move])
                cube([suspension_holder_thickness + additional_thickness, join_height + 2*presah + additional_height, join_height + additional_width], center=true);
            translate([0,additional_height_y_move,additional_width_x_move])
            		mirror_copy([0, 0, 1])
				            translate([-0.1, suspension_bow_diameter/2 + presah/2 - M3_screw_diameter, suspension_join_screw_distance/2])
				                rotate([0, 90, 0]){
				                    translate([0,0,-additional_thickness])
				                    		cylinder(d= M3_screw_diameter, h = 30 + additional_thickness,$fn = draft?10:50);
				             				translate([0,0,2.4 -  additional_height_nuts])
				                				cylinder(d = M3_nut_diameter, h = M3_nut_height+0.2 + additional_height_nuts, $fn = 6);
				            }
            translate([0,additional_height_y_move,additional_width_x_move])
            mirror_copy([0, 0, 1])
            translate([-0.1, suspension_bow_diameter/2 - join_height - M3_screw_diameter, suspension_join_screw_distance/2])
                rotate([0, 90, 0]){
                    translate([0,0,-additional_thickness])
                    		#cylinder(d= M3_screw_diameter, h = 30 + additional_thickness,$fn = draft?10:50);
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
	for(x=platform_mount_points)
		translate([x, 0, 0])
			cylinder(d = 8 + additional_edge_thickness/2, h = suspension_holder_thickness+0.1, $fn=30);

    // dolni rada
	for(x = [20:10:base_length])
		        translate([x, 0, -0.1 + additional_thickness]){
                    translate([0, 0, -additional_thickness/2])
	            	cylinder(d = M3_screw_diameter, h = 10 - (M3_head_height + 1.2 + layer_thickness ) + additional_thickness, center = true, $fn = 50);
    translate([0,0,4.6])
                cylinder(d = M3_head_diameter, h = M3_head_height + 0.2, $fn = 30, center = true);
            }


    // Rada sroubu pro akumulator
	for(x = [40:10:10*18])
	        translate([x, -bellow - 5, -0.1 +additional_thickness]){
                translate([0, 0, -additional_thickness/2])
	            cylinder(d = M3_screw_diameter, h = 10 - (M3_head_height + 1.2 + layer_thickness ) +  additional_thickness, center = true, $fn = 50);
                translate([0,0,4.6])
                cylinder(d = M3_head_diameter, h = M3_head_height + 0.2, $fn = 30, center = true);
            }
        }

}

// pozice soucastek - test
/*translate([start_x + additional_x_move, start_y + additional_y_move, 12.2+ additional_thickness])
    rotate ([0,90,0])
        puvodni_koncovka();*/
888_1003();
888_2004();
