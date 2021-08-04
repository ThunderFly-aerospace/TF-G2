
//@set_slicing_config(../slicing/default.ini)
include <../../parameters.scad>

//use <../../888_1010.scad>
use <../888_1011.scad>
use <../888_1012.scad>
use <../888_4008.scad>

Bwall = 1.6; // wall around bearing

module rotor_head(){
translate([-10, 0, -42.5])
    rotate([0, 0, 180])
        888_1011() 888_1012();
    
    translate([-10 , -5.2, -42.5 -bearing_outer_diameter/2- Bwall+3.9])
    rotate([180, 0, -90])
    bearing_house();
}

translate([0, 0, 0])
rotor_head();

