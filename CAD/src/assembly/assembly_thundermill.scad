
//@set_slicing_config(../slicing/default.ini)
include <../../parameters.scad>

//use <../../888_1010.scad>
use <../888_1011.scad>
use <../888_1012_THUNDERMILL.scad>
use <../888_4008.scad>
use <../888_4045.scad>

Bwall = 1.6; // wall around bearing

 starter_top_h=M3_screw_head_height+3;
 height_from_rotor_nut = 11.5 - 1.65 ;
 starter_bottom_h=5;
 Ribbon_width = 6-1.2;  // Modification of mill Z position
 rpm_sensor_h = height_from_rotor_nut - starter_top_h;
 Space_between_discs = 2;

module rotor_head(){
translate([-10, 0, -42.5])
    rotate([0, 0, 180])
        888_1012();

    translate([-10 , -bearing_outer_diameter/2- Bwall + 6.7, -42.5 - 6.7 ])
    rotate([0, 0, 180]) bearing_house();



}


difference(){
    union(){
    translate([183+42.5, 0, 250-16.5]) rotate([0, 90, 0]) rotor_head();
 


    translate([183, 0, 250+30-4.5+15-16.6])
    rotate([180, 0, 90]) {
       888_4008();

//  translate([0, 0, starter_bottom_h+Ribbon_width+rpm_sensor_h - 1.4 - 2 +0])  Mezikus();


    color("blue") translate([0, 0, starter_bottom_h+Ribbon_width+rpm_sensor_h - 1.4 + +0.95+ 6 - Space_between_discs])  rotate([0, 0, 25])  mill_rot();

    translate([0,0,starter_bottom_h+Ribbon_width+rpm_sensor_h -1.4 + 4 +1.6+2 +0.95])   rotate([0, 0, -90]) mill_static();
//    %translate([0, 0, 14]) color("yellow") rotate([0, 0, -90]) projection() Cu_butterfly(draft = true);


    }
}
// cross section for model construction
    translate([183+42.5-140, 0, 250-16.5-150]) cube([200, 60, 300]);

}