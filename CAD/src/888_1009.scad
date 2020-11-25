//@set_slicing_config(slicing/default.ini)
// Vyztuzovaci krouzek, drzak serv a airspeed
include <../parameters.scad>


module servo(){
    translate([0, -6, 0]) cube([25, 23, 13], center = true);
    cube([33, 2, 13], center = true);
}

module 888_1009(){

    difference(){
        translate([0, 0, -pylon_ring_height]) cube([pylon_ring_length, pylon_ring_width+3, pylon_ring_height_rantl], center = true);


// Odecteni sikmych ploch pro sesroubovani
        translate([0, 10+pylon_ring_width/2])
            rotate([90-pylon_bottom_angle, 0, 0])
                cube([pylon_ring_length+1, 20, 20], center = true);
        translate([0, -10 - pylon_ring_width/2])
            rotate([pylon_bottom_angle, 0, 0])
                cube([pylon_ring_length+1, 20, 20], center = true);

        difference(){
        hull(){
            translate([-pylon_ring_length/2 - 0.5, pylon_ring_width/2 - pylon_ring_thickness, -pylon_ring_height_rantl/2 ])
                rotate([90-pylon_top_angle, 0, 0])
                    cube([pylon_ring_length+1, 0.1, 20]);
            translate([-pylon_ring_length/2 - 0.5, - pylon_ring_width/2 + pylon_ring_thickness, -pylon_ring_height_rantl/2 ])
                rotate([pylon_top_angle, 0, 0])
                    cube([pylon_ring_length+1, 20, 0.1]);
            }

            translate([0,0,-8]) cube([pylon_ring_length, 24, 10], center = true);



        }

        difference(){
            cube([pylon_ring_length-10, pylon_ring_width-10, 30], center = true);
                cube([5, pylon_ring_width, 30], center = true);
                cube([pylon_ring_length, 24, 30], center = true);
                /* for(x = [-1, 1])
                    translate([0, 20/2*x, 0])
                        cylinder(d = 10, h=30, center = true); */
        }

        // otvory na pripevneni prislusenstvi
        //for(x = [-1, 1])
        translate([pylon_ring_length/2-21, 0, 0])
            cylinder(d = M3_screw_diameter, h=30, center = true, $fn = 30);

        translate([pylon_ring_length/2-27.5, 0, -pylon_ring_height_rantl/2])
            cube([4,9,30], center = true);

        translate([pylon_ring_length/2, 0, -pylon_ring_height_rantl/2-2+6])
            cube([4*2,20,12], center = true);
        translate([pylon_ring_length/2, 0, -pylon_ring_height_rantl/2+5-2])
            cube([38*2,20,4], center = true);
        translate([pylon_ring_length/2, 0, -pylon_ring_height_rantl/2+5-2])
            cube([32*2,20,7], center = true);
/* 
        for(x = [-1, 1])
            translate([0, 20/2*x, -pylon_ring_height-pylon_ring_thickness-1.5])
                cylinder(d = M3_nut_diameter, h=30, $fn = 6); */

// Otvory pro sesroubovani s pylonem
        for(x = [-pylon_ring_length/2+5:10:pylon_ring_length/2-5])
            translate([x, 0, -pylon_ring_height/4])
            rotate([90, 0, 0])
                cylinder(d = M3_screw_diameter, h = 60, center = true, $fn = $preview?10:30);

        %translate([0, pylon_ring_width/2+5, 22]) rotate([0, 90, 0]) servo();
    }
}

888_1009();
