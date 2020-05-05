//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni tazneho motoru
include <../../../parameters.scad>

translate([base_patern*20-6, 0, -base_thickness-12.5]) rotate([0, 90, 0]) difference(){
    cylinder(d=10, h = 500, $fn=$preview? 7:50);
    translate([0, 0, -0.5]) cylinder(d=10-3, h = 501, $fn=$preview? 7:50);
}
