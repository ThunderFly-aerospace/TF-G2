//@set_slicing_config(slicing/default.ini)
//Spodni cast pylonu

include <../parameters.scad>



module 888_1007(){
    translate([0, 0, pylon_thickness/2])
    difference(){
        union(){
            // Zakladni tvar
            hull(){
                cube([pylon_base_length, 10, pylon_thickness], center = true);
                translate([0, pilot_height_separation, 0])
                    cube([pylon_ring_length, 10, pylon_thickness], center = true);
            }

// Vytvoreni sikmych ploch
            /* hull(){
                cube([pylon_base_length, 10, pylon_thickness], center = true);
                translate([0, 0, pylon_thickness/2])
                    rotate([90-pylon_angle, 0, 0])
                        cube([pylon_base_length, 10, 0.1], center = true);
            }

            translate([0, pilot_height_separation, 0])
                hull(){
                    cube([pylon_ring_length, 10, pylon_thickness], center = true);
                    translate([0, 0, pylon_thickness/2])
                        rotate([90-pylon_angle, 0, 0])
                            cube([pylon_ring_length, 10, 0.1], center = true);
                } */
        }

// Odecet stredniho odlehceni
        difference(){
            hull(){
                translate([0, 10/2, 0])
                    cube([pylon_base_length-20, 0.1, pylon_thickness+1], center = true);
                translate([0, pilot_height_separation - 10/2, 0])
                    cube([pylon_ring_length-20, 0.1, pylon_thickness+1], center = true);
            }
                translate([0, pilot_height_separation/2 - 10/2, 0])
                    cube([pylon_ring_length, 10, pylon_thickness+1], center = true);
        }


//  Otvory pro prisroubovani
    for(x = [-pylon_base_length/2+5:10:pylon_base_length/2-5])
    translate([x, 0, 0])
        rotate([90-pylon_angle, 0, 0])
            cylinder(d = M3_screw_diameter, h = 20, center = true, $fn = $preview?10:30);

    for(x = [-pylon_ring_length/2+5:10:pylon_ring_length/2-5])
    translate([x, pilot_height_separation, 0])
        rotate([90-pylon_angle, 0, 0])
            cylinder(d = M3_screw_diameter, h = 20, center = true, $fn = $preview?10:30);


    }
}

888_1007();
