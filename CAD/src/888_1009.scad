//@set_slicing_config(slicing/default.ini)
// Vyztuzovaci krouzek, drzak serv a airspeed
include <../parameters.scad>


module servo(){
    translate([0, -6, 0]) cube([25, 23, 13], center = true);
    cube([33, 2, 13], center = true);
}

module 888_1009(){

    difference(){
        translate([0, 0, -pilon_ring_height]) cube([pilon_ring_length, pilon_ring_width+3, pilon_ring_height_rantl], center = true);


// Odecteni sikmych ploch pro sesroubovani
        translate([0, 10+pilon_ring_width/2])
            rotate([90-pilon_bottom_angle, 0, 0])
                cube([pilon_ring_length+1, 20, 20], center = true);
        translate([0, -10 - pilon_ring_width/2])
            rotate([pilon_bottom_angle, 0, 0])
                cube([pilon_ring_length+1, 20, 20], center = true);

        hull(){
            translate([-pilon_ring_length/2 - 0.5, pilon_ring_width/2 - pilon_ring_thickness, -pilon_ring_height_rantl/2 ])
                rotate([90-pilon_top_angle, 0, 0])
                    cube([pilon_ring_length+1, 0.1, 20]);
            translate([-pilon_ring_length/2 - 0.5, - pilon_ring_width/2 + pilon_ring_thickness, -pilon_ring_height_rantl/2 ])
                rotate([pilon_top_angle, 0, 0])
                    cube([pilon_ring_length+1, 20, 0.1]);
            }

        difference(){
            cube([pilon_ring_length-15, pilon_ring_width-15, 30], center = true);
                cube([5, pilon_ring_width-15, 30], center = true);
                for(x = [-1, 1])
                    translate([0, 25/2*x, 0])
                        cylinder(d = 10, h=30, center = true);
        }
                for(x = [-1, 1])
                    translate([0, 25/2*x, 0])
                        cylinder(d = M3_screw_diameter, h=30, center = true, $fn = 30);

// Otvory pro sesroubovani s pilonem
        for(x = [-pilon_ring_length/2+5:10:pilon_ring_length/2-5])
            translate([x, 0, -pilon_ring_height/4])
            rotate([90, 0, 0])
                cylinder(d = M3_screw_diameter, h = 60, center = true, $fn = $preview?10:30);

        %translate([0, pilon_ring_width/2+5, 22]) rotate([0, 90, 0]) servo();
    }
}

888_1009();
