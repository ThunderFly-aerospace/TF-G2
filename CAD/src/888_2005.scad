include <../parameters.scad>
use <888_1003.scad>
use <888_1002.scad>
use <888_2004.scad>

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

// FIXME should be in parameters, see 2004
fiberglass_gear = false;

module mirror_copy(v=[0,0,1])
{
    children();
    translate([0,0,-base_width])
    mirror(v) children();
}




// vlastni parametry 2004
// FIXME: nastavit mezi prvni radu sroubu
//        a druhou (na baterii), pekne doprostred
//start_x = 39.6;
//start_y = -105.5;

// pomocne parametry
// layer_thickness = 0;

// volitelne parametry
//additional_x_move=5.5;
//additional_y_move=-5.5;
//additional_thickness = 2; // e.g. height
//additional_height = 20; // e.g. y
//additional_height_y_move = 0;
//additional_width = 22; // eg. x
//additional_width_x_move = 0 ;

//additional_height_nuts = 0; //
// M3_nut_height+0.2 + additional_height_nuts < suspension_holder_thickness + additional_thickness
// 2.7 + 2 < 6.15 + 2
// best is same as additional_thickness

// minimalni zdvih
// additional_thickness = 1.5 ; // pro M3x12
// additional_thickness = -0.5 ; // pro M3x10

// kupovany podvozek
//fiberglass_gear_whole=true;
//if(fiberglass_gear_whole){ // v celku
//  fiberglass_gear_width = 30; // v celku
//  fiberglass_gear_thickness = 3; // v celku
//  fiberglass_gear_oblique_angle = 10; // sikma cast
//} else { // puleny
  //fiberglass_gear_width = 27 ; // puleny
  //fiberglass_gear_thickness = 4.5 ; // puleny
  //fiberglass_gear_oblique_angle = 0; // sikma cast
//}

// vlastni parametry 2005
//minimal_height = battery_height;

// FIXME some how connected with fiberglass_gear_additional_height
move_down=( fiberglass_gear ? 13 : 1);
over_height = 5;
over_bottom = 3;
over_lem = 3.5;
over_thickness = 3;
over_thickness_middle = 1;
over_margin = -2;
1001_margin = 0.2;
// FIXME: správné umístění
module 888_2005_base(draft){
    
    // spodni vyrez - odlehceni
translate([11, -13.2, -35])
  rotate ([-90,0,0])
    difference(){
      hull(){translate([6.4, 0, 10])
			     cube([thickness*16-1.6, 10+base_width-thickness*4, 0.1], center = true);
			        translate([-12.4, 0, 10]) cylinder(d = 20-thickness, h=0.1);
          translate([16 , 0, -16 - over_bottom - move_down + (over_thickness + over_lem)/2 ]) //cylinder(d = 5-thickness, h=0.1);
          cube([thickness, 10+base_width-thickness*4 + 2*over_height, over_thickness + over_lem], center = true);;
      }

     hull(){translate([6 +2 + over_margin, 0, 10 + 1])
			     cube([thickness*16, 10+base_width-thickness*4 -3-3, 0.1], center = true);
			        translate([-13 +3 + over_margin, 0, 10+1]) cylinder(d = 20-thickness, h=0.1);
          translate([16.5, 0, -16 -over_bottom - move_down + 1 + over_thickness_middle]) //cylinder(d = 5-thickness, h=0.1);
          cube([max(thickness + over_margin,thickness) , 10+base_width-thickness*4 -3-3, 0.1 +3], center = true);;
      }
      //translate([base_patern, 0, 0]) cube([2, base_width, 5*2], center=true);
      //translate([base_patern, 0, 0]) cube([6, base_width, 2], center=true);
    }

// spodni okraje
translate([26.5, -29.2 - over_bottom - move_down, -1])
  cube([35,over_thickness + over_lem,4+over_height]);
translate([26.5, -29.2 - over_bottom - move_down, -70])
  cube([35,over_thickness_middle,70]);
translate([26.5, -29.2 - over_bottom - move_down, -73-over_height])
  cube([35,over_thickness + over_lem,4+over_height]);

}

module 888_2005(draft){
    difference(){
        888_2005_base(draft);
        mirror_copy(){
            888_2004(draft,fiberglass_gear, true);
        }
        // horni vyrezy na 1001        
translate([10-1001_margin, -3-base_thickness-1001_margin, -70])
  cube([35,base_thickness+1,70]);
    }
}

// pozice soucastek - bottom
//translate([10.1, -13.2, -35])
//  rotate ([-90,0,0])
//translate([20, 0, -15]) cylinder(d = 5-thickness, h=0.1);

// pozice soucastek - test
/*translate([start_x + additional_x_move, start_y + additional_y_move, 12.2+ additional_thickness])
    rotate ([0,90,0])
        puvodni_koncovka();*/
*translate([30.1, -3.2, -35])
  rotate ([-90,180,0])
    888_1002();
*888_1003();
*888_2004();
888_2005(true);
