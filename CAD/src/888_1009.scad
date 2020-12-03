//@set_slicing_config(slicing/default.ini)
// Trhaci predel rotorove hlavy

include <../parameters.scad>
inclode <MCAD/servos.scad>


module servo(){
    translate([0, -6, 0]) cube([25, 23, 13], center = true);
    cube([33, 2, 13], center = true);
}

module 888_1009(){


}

888_1009();
