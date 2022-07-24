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
additional_slider_thickness = 0.1;

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
fiberglass_gear = false;
fiberglass_gear_additional_height = 6;
fiberglass_gear_whole = false;

//if( ~fiberglass_gear ) {
// volitelne parametry
additional_x_move        = (fiberglass_gear ?  5.5 : 5 );
additional_y_move        = (fiberglass_gear ? -5.5 : 0 );
additional_y_move_holes  = (fiberglass_gear ?  5.5 : 0 );
additional_thickness     = 0; // e.g. height
additional_height        = (fiberglass_gear ?   20 : 6 );
additional_height_y_move = (fiberglass_gear ?   -1 : 1 );
additional_width         = 20;
additional_width_x_move  = 0 ;

additional_height_nuts = 0; //
// M3_nut_height+0.2 + additional_height_nuts < suspension_holder_thickness + additional_thickness
// 2.7 + 2 < 6.15 + 2
// best is same as additional_thickness

// minimalni zdvih
// additional_thickness = 1.5 ; // pro M3x12
// additional_thickness = -0.5 ; // pro M3x10
//} else {
// kupovany podvozek
//additional_x_move=5.5;
//additional_y_move=-5.5;
//additional_y_move_holes=+5.5;
//additional_thickness = 0; // e.g. height
//additional_height = 20; // e.g. y
//additional_height_y_move = -1;
//additional_width = 20; // eg. x
//additional_width_x_move = 0 ;

additional_height_for_fiberglass_gear = 14;
fiberglass_gear_width         = (fiberglass_gear_whole ? 30 :  27);
fiberglass_gear_thickness     = (fiberglass_gear_whole ?  3 : 4.5);
fiberglass_gear_oblique_angle = (fiberglass_gear_whole ? 10 :   0); // sikma cast


//if(fiberglass_gear_whole){ // v celku
//  fiberglass_gear_width = 30; // v celku
//  fiberglass_gear_thickness = 3; // v celku
//  fiberglass_gear_oblique_angle = 10; // sikma cast
//} else { // puleny
//  additional_height_for_fiberglass_gear = 14;
//  fiberglass_gear_width = 27 ; // puleny
//  fiberglass_gear_thickness = 4.5 ; // puleny
//  fiberglass_gear_oblique_angle = 0; // sikma cast
//}
//}
// FIXME: správné umístění
module 888_2004(draft, add_fiberglass_gear=false, long_slider=false){
    union(){
difference(){
    translate([start_x + additional_x_move, start_y + additional_y_move, 6])
    rotate ([0,90,0])
        difference(){
            union(){
                translate([suspension_holder_thickness/2 - additional_thickness/2 , suspension_bow_diameter/2 - join_height/2 + additional_height_y_move, additional_width_x_move])
                    cube([suspension_holder_thickness + additional_thickness, join_height + 2*presah + additional_height, join_height + additional_width], center=true);
                translate([suspension_holder_thickness/2 - additional_thickness/2 - cover_rantl_thickness - 0.2, suspension_bow_diameter/2 - join_height/2 + additional_height_y_move, additional_width_x_move])
                    cube([suspension_holder_thickness + additional_thickness, suspension_join_screw_distance + M3_screw_diameter, suspension_join_screw_distance + M3_screw_diameter], center=true);
            }
            translate([0,additional_height_y_move,additional_width_x_move])
            mirror_copy([0, 0, 1])
            translate([-0.1, suspension_bow_diameter/2 + presah/2 - M3_screw_diameter/2, suspension_join_screw_distance/2])
                rotate([0, 90, 0]){
                    //translate([0,0,-additional_thickness])
                    translate([0,additional_y_move_holes,-30.3 + M3_nut_height - layer_thickness - additional_thickness])
                    cylinder(d= M3_screw_diameter, h = 30 + additional_thickness,$fn = draft?10:50);
                    translate([0,additional_y_move_holes,2.4 -  additional_height_nuts])
                cylinder(d = M3_nut_diameter, h = M3_nut_height+0.2 + additional_height_nuts, $fn = 6);
            }
            translate([0,additional_height_y_move,additional_width_x_move])
            mirror_copy([0, 0, 1])
            translate([-0.1, suspension_bow_diameter/2 - join_height - M3_screw_diameter/2, suspension_join_screw_distance/2])
                rotate([0, 90, 0]){
                    //translate([0,0,-additional_thickness])
                    translate([0,additional_y_move_holes,-30.3 + M3_nut_height - layer_thickness - additional_thickness])
                    cylinder(d= M3_screw_diameter, h = 30 + additional_thickness,$fn = draft?10:50);
                    translate([0,additional_y_move_holes,2.4 - additional_height_nuts])
                cylinder(d = M3_nut_diameter, h = M3_nut_height+0.2 + additional_height_nuts, $fn = 6);
                }
        };
    888_1003();

    // clear bottom
    translate([0, -50, -0.5])
      cube([120,130,1.7]);


    // dolni rada
	for(x = [20:10:base_length])
		        translate([x, 0, -0.1 + additional_thickness]){
                    translate([0, 0, -additional_thickness/2])
	            	cylinder(d = M3_screw_diameter, h = 10 - (M3_head_height + 1.2 + layer_thickness ) + additional_thickness, center = true, $fn = 50);
    translate([0,0,4.6 +2])
                cylinder(d = M3_head_diameter, h = M3_head_height + 0.2 +4, $fn = 30, center = true);
            }


    // Rada sroubu pro akumulator
	for(x = [40:10:10*18])
	        translate([x, -bellow - 5, -0.1 +additional_thickness]){
                translate([0, 0, -additional_thickness/2])
	            cylinder(d = M3_screw_diameter, h = 10 - (M3_head_height + 1.2 + layer_thickness ) +  additional_thickness, center = true, $fn = 50);
                translate([0,0,4.6+2])
                cylinder(d = M3_head_diameter, h = M3_head_height + 0.2 +4, $fn = 30, center = true);
            }
     // box for week
     translate([28, 3.5, side_base_thickness-0.4])
		cube([9.2,6.5,1.3]);
     if(fiberglass_gear){            
       // koupene podvozky ze skelnehovlakna
       translate([30, // FIXME
              additional_y_move -33, 0])
           cube([fiberglass_gear_width + 0.2,fiberglass_gear_thickness + 0.2, 20 // FIXME
              ]);
       if(fiberglass_gear_oblique_angle != 0) {
       rotate([fiberglass_gear_oblique_angle, 0 ,0])
       translate([30, // FIXME
              additional_y_move -33, 0])
           cube([fiberglass_gear_width + 0.2, fiberglass_gear_thickness + 0.2, 20 // FIXME
              ]);
       }
   }
        }



        // pojezdny prouzek  = slider
     translate([30, // FIXME
            additional_y_move -35 + (fiberglass_gear? 0 : fiberglass_gear_additional_height)
        , 0.5])
        rotate([45, 0 ,0])
         cube([join_height + additional_width/2 + (long_slider?2*presah:0),
               1 + (long_slider?additional_slider_thickness:0),
               1 + (long_slider?additional_slider_thickness:0) // FIXME spravnou delku + presah pro odebrani z krytu
              ]);

        // pro odebrani casti, ktera by se prekryvala s krytem 2005
    if(add_fiberglass_gear){
     rotate([fiberglass_gear_oblique_angle, 0 ,0])
     translate([30, // FIXME
            additional_y_move -33, -40])
         cube([fiberglass_gear_width + 0.2 + additional_width, fiberglass_gear_thickness + 0.2, 50 // FIXME
]);        
    }
// dvojite odebrani der se pokusim znovu zakryt
//   // matice
//     translate([start_x + additional_x_move, start_y + additional_y_move, 6])
//    rotate ([0,90,0])
//   mirror_copy([0, 0, 1])
//            translate([-0.1, suspension_bow_diameter/2 + presah/2 - M3_screw_diameter/2, suspension_join_screw_distance/2])
//                rotate([0, 90, 0]){
//                    translate([0,0,1.7+additional_height_nuts + M3_nut_height - layer_thickness - additional_thickness])
//                    cylinder(d= M3_screw_diameter + 1, h = layer_thickness);
//                }
//   // sroub
//     translate([start_x + additional_x_move, start_y + additional_y_move, 6])
//    rotate ([0,90,0])
//   mirror_copy([0, 0, 1])
//            translate([-0.1, suspension_bow_diameter/2 + presah/2 - M3_screw_diameter/2, suspension_join_screw_distance/2])
//                rotate([0, 90, 0]){
//                    // FIXME: mel bych to vzit z 1003
//                    translate([0,0,2.9+layer_thickness - additional_thickness])
//                    cylinder(d= M3_screw_diameter + 1, h = layer_thickness);
//                }

                
//     translate([start_x + additional_x_move, start_y + additional_y_move, 6])
//    rotate ([0,90,0])
//     translate([0,additional_height_y_move,additional_width_x_move])
//            mirror_copy([0, 0, 1])
//            translate([-0.1, suspension_bow_diameter/2 - join_height - M3_screw_diameter/2, suspension_join_screw_distance/2])
//                rotate([0, 90, 0]){
//                    translate([0,0,1.7+additional_height_nuts + M3_nut_height - layer_thickness - additional_thickness])
//                    cylinder(d= M3_screw_diameter, h = layer_thickness);              }
                     
                
   }
}

// pozice soucastek - test
/*translate([start_x + additional_x_move, start_y + additional_y_move, 12.2+ additional_thickness])
    rotate ([0,90,0])
        puvodni_koncovka();*/
*888_1003();
888_2004(true,false,false);
