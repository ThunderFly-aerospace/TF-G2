//@set_slicing_config(slicing/default.ini)
//Spodni cast pilonu

include <../parameters.scad>



module 888_1007(){
    translate([0, 0, pilon_thickness/2])
    difference(){
        union(){
            hull(){
                cube([pilon_base_length/2, 10, pilon_thickness], center = true);
                translate([0, pilot_height_separation, 0])
                    cube([pilon_base_length/2, 10, pilon_thickness], center = true);
            }
            hull(){
                cube([pilon_base_length/2, 10, pilon_thickness], center = true);
                translate([0, 0, pilon_thickness/2])
                    rotate([90-pilon_angle, 0, 0])
                        cube([pilon_base_length, 10, 0.1], center = true);
            }
    translate([0, pilot_height_separation, 0])
            hull(){
                cube([pilon_base_length/4, 10, pilon_thickness], center = true);
                translate([0, 0, pilon_thickness/2])
                    rotate([90-pilon_angle, 0, 0])
                        cube([pilon_base_length/2, 10, 0.1], center = true);
            }
        }
        difference(){
            hull(){
                translate([0, 10/2, 0])
                    cube([pilon_base_length-20, 0.1, pilon_thickness+1], center = true);
                translate([0, pilot_height_separation - 10/2, 0])
                    cube([pilon_base_length/2-20, 0.1, pilon_thickness+1], center = true);
            }
                translate([0, pilot_height_separation/2 - 10/2, 0])
                    cube([pilon_base_length/2, 10, pilon_thickness+1], center = true);
        }


    for(x = [-pilon_base_length/2+5:10:pilon_base_length/2-5])
    translate([x, 0, 0])
        rotate([90-pilon_angle, 0, 0])
            cylinder(d = M3_screw_diameter, h = 20, center = true, $fn = $preview?10:30);

    for(x = [-pilon_base_length/4+5:10:pilon_base_length/4-5])
    translate([x, pilot_height_separation, 0])
        rotate([90-pilon_angle, 0, 0])
            cylinder(d = M3_screw_diameter, h = 20, center = true, $fn = $preview?10:30);
    }
}

888_1007();
