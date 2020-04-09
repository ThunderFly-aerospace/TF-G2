//@set_slicing_config(slicing/default.ini)
// Vyztuzovaci krouzek, drzak serv a airspeed
include <../parameters.scad>


module 888_1009(){

    difference(){
        cube([pilon_ring_length, pilon_ring_width, pilon_ring_height_rantl], center = true);

        translate([0, 0, pilon_ring_height/2])
            cube([pilon_ring_length+1, pilon_ring_width-6, pilon_ring_height_rantl], center = true);


    }
}

888_1009();
