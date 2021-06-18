
//@set_slicing_config(../slicing/default.ini)
include <../../../parameters.scad>

use <../../888_1010.scad>
use <../../888_1011.scad>
use <../../888_1012.scad>
use <../../888_4008.scad>



module rotor_head(){
translate([-10, 0, -42.5])
    rotate([0, 0, 180])
        888_1010() 888_1011() 888_1012();
}

translate([183, 0, 250])
rotor_head();
