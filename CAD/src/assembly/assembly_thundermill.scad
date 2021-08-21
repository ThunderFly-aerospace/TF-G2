
//@set_slicing_config(../slicing/default.ini)
include <../../parameters.scad>

//use <../../888_1010.scad>
use <../888_1011.scad>
use <../888_1012.scad>
use <../888_4008.scad>
use <../888_4045.scad>

Bwall = 1.6; // wall around bearing

 starter_top_h=M3_screw_head_height+3;
 height_from_rotor_nut = 11.5 - 1.65 ;
 starter_bottom_h=5;
 Ribbon_width = 6-1.2;  // Modification of mill Z position
 rpm_sensor_h = height_from_rotor_nut - starter_top_h;

module rotor_head(){
translate([-10, 0, -42.5])
    rotate([0, 0, 180])
        888_1012();

    translate([-10 , -bearing_outer_diameter/2- Bwall + 6.7, -42.5 - 6.7 ])
    rotate([0, 0, 180]) bearing_house();



}

translate([183+42.5, 0, 250-16.5])
 rotate([0, 90, 0]) rotor_head();


 translate([183, 0, 250+30-4.5+15-17.5])
    rotate([180, 0, 90]) {
        //888_4008();

    //translate([0, 0, starter_bottom_h+Ribbon_width+rpm_sensor_h - 1.4 - 2]) Mezikus();


    color("blue") translate([0, 0, starter_bottom_h+Ribbon_width+rpm_sensor_h - 1.4 + 4])    mill_rot();

    translate([0,0,starter_bottom_h+Ribbon_width+rpm_sensor_h -1.4 + 4 +1.6+2 ])  mill_static();
    %translate([0, 0, 14]) color("yellow") projection() Cu_butterfly(draft = true);


    }
