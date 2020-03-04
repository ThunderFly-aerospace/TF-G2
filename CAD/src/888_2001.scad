
//@set_slicing_config(../slicing/default.ini)
include <../parameters.scad>

$fn = 50;
suspension_depth = 15;
suspension_holder_flange_height = 25;
suspension_holder_thickness = 4;

suspension_join_length = 22;
suspension_join_screw_distance = 12;



module 888_2001(){

    difference(){
        union(){
            translate([0, 0, -suspension_depth/2])
                cube([suspension_holder_thickness, suspension_holder_flange_height, suspension_depth]);

            hull(){
                translate([2, 0, 0])
                    cylinder(d = suspension_holder_thickness, h = suspension_depth, center = true);
                translate([0, -2, 0] + [10, 0, 0])
                    cylinder(d = suspension_holder_thickness, h = suspension_depth, center = true);

            }

            translate([10, 0, 0])
                rotate([0, 0, -90-10])
                    translate([0, 0, -suspension_depth/2])
                        cube([suspension_holder_thickness, suspension_join_length, suspension_depth]);
        }

        translate([10, 0, 0])
            rotate([0, 0, -90-10])
                translate([0, 0, 0])
                    for (i=[1,-1])
                        translate([0, suspension_join_length/2-i*suspension_join_screw_distance/2, 00])
                            rotate([0, 90, 0])
                                cylinder(d=M3_screw_diameter, h = 10, center = true);




    }

}


888_2001();
