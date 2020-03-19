
//@set_slicing_config(../slicing/default.ini)
include <../parameters.scad>

$fn = 50;

suspension_holder_length = 25;
suspension_holder_height = 20;
suspension_holder_thickness = 4;



module 888_1004(){

    difference(){
        union(){

            translate([-suspension_holder_length/2, -base_width/2, -suspension_holder_thickness])
                cube([suspension_holder_length, base_width, suspension_holder_thickness]);

            translate([-suspension_holder_length/2, -base_width/2, -suspension_holder_height])
                cube([suspension_holder_length, suspension_holder_thickness, suspension_holder_height]);

            translate([-suspension_holder_length/2, base_width/2 -suspension_holder_thickness, -suspension_holder_height])
                cube([suspension_holder_length, suspension_holder_thickness, suspension_holder_height]);


            hull(){
                translate([-suspension_holder_length/2, -base_width/2, -suspension_holder_height])
                    cube([suspension_holder_thickness, suspension_holder_thickness, suspension_holder_height]);
                translate([-suspension_holder_length/2, -base_width/2, -suspension_holder_thickness])
                    cube([suspension_holder_thickness, suspension_holder_height, suspension_holder_thickness]);
                }

            hull(){
                translate([-suspension_holder_length/2, base_width/2 - suspension_holder_thickness, -suspension_holder_height])
                    cube([suspension_holder_thickness, suspension_holder_thickness, suspension_holder_height]);
                translate([-suspension_holder_length/2, base_width/2 - suspension_holder_height, -suspension_holder_thickness])
                    cube([suspension_holder_thickness, suspension_holder_height, suspension_holder_thickness]);
                }
        }


        translate([-5, 0, -suspension_holder_height/2]) rotate([90, 0, 0]) cylinder(d = M3_screw_diameter, h = 200, center = true);
        translate([ 5, 0, -suspension_holder_height/2]) rotate([90, 0, 0]) cylinder(d = M3_screw_diameter, h = 200, center = true);

        translate([-5, 0, -suspension_holder_height/2]) rotate([90, 30, 0]) cylinder(d = M3_nut_diameter, h = base_width - suspension_holder_thickness*2 + 3, center = true, $fn = 6);
        translate([ 5, 0, -suspension_holder_height/2]) rotate([90, 30, 0]) cylinder(d = M3_nut_diameter, h = base_width - suspension_holder_thickness*2 + 3, center = true, $fn = 6);

    }

}

rotate([180, 0, 0])
    888_1004();
