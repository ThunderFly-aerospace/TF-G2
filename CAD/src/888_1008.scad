//@set_slicing_config(slicing/default.ini)
//Spodni cast pilonu

include <../parameters.scad>


module 888_1008(){
    translate([0, 0, pilon_thickness/2])
    difference(){
        union(){
            hull(){
                cube([pilon_ring_length, 10, pilon_thickness], center = true);
                translate([0, pilon_height - pilot_height_separation, 0])
                    cube([pilon_top_length, 10, pilon_thickness], center = true);
                translate([0, pilon_height - pilot_height_separation + 15, 0])
                    cylinder(d = 10, h=pilon_thickness, center = true);
            }
            /* hull(){
                cube([pilon_ring_length, 10, pilon_thickness], center = true);
                translate([0, 0, pilon_thickness/2])
                    rotate([90-pilon_angle, 0, 0])
                        cube([pilon_ring_length, 10, 0.1], center = true);
            }
    translate([0, pilot_height_separation, 0])
            hull(){
                cube([pilon_base_length/4, 10, pilon_thickness], center = true);
                translate([0, 0, pilon_thickness/2])
                    rotate([90-pilon_angle, 0, 0])
                        cube([pilon_base_length/2, 10, 0.1], center = true);
            } */
        }
        translate([0, pilon_height - pilot_height_separation + 15, 0])
            cylinder(d = M3_screw_diameter, h=pilon_thickness+1, center = true, $fn = 50);

        difference(){
            hull(){
                translate([0, 10/2, 0])
                    cube([pilon_ring_length-20, 0.1, pilon_thickness+1], center = true);
                    translate([0, pilon_height - pilot_height_separation - 10/2, 0])
                        cube([pilon_top_length-10, 0.1, pilon_thickness+1], center = true);
            }
                difference(){
                    union(){
                        translate([0, pilot_height_separation/2 - 8/2 + 0.4, 0])
                            cube([pilon_base_length/2, 8, pilon_thickness+1], center = true);

                        translate([0, pilot_height_separation/2 - 8*1.5 - 23 - 0.4, 0])
                            cube([pilon_base_length/2, 8, pilon_thickness+1], center = true);
                    }
                    translate([0, pilot_height_separation/2 - 8 + 3, 0])
                        cylinder(d = M2_5_screw_diameter, h = 10, $fn = 50, center = true);
                    translate([0, pilot_height_separation/2 - 8 - 23 - 3, 0])
                        cylinder(d = M2_5_screw_diameter, h = 10, $fn = 50, center = true);

                }
        }




    for(x = [-pilon_ring_length/2+5:10:pilon_ring_length/2-5])
    translate([x, 0, 0])
            cylinder(d = M3_screw_diameter, h = 20, center = true, $fn = $preview?10:30);

    for(x = [-pilon_top_length/2+5:10:pilon_top_length/2-5])
    translate([x, pilon_height - pilot_height_separation, 0])
            cylinder(d = M3_screw_diameter, h = 20, center = true, $fn = $preview?10:30);
    }
}

888_1008();
