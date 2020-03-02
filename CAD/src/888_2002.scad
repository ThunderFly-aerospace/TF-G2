include <../parameters.scad>

$fn = 50;
suspension_depth = 15;
suspension_thickness = 3;
suspension_holder_flange_height = 25;
suspension_holder_thickness = 4;

suspension_camber = 10;

suspension_join_length = 22;
suspension_join_screw_distance = 12;

suspension_bow_diameter = 200;



module 888_2002(){

    intersection(){
    difference(){
        cylinder(d = suspension_bow_diameter, h = suspension_depth);
        translate([0, 0, -0.1])
            cylinder(d = suspension_bow_diameter - suspension_thickness*2, h = suspension_depth + .2);
        rotate([0, 0, 90-10]) cube(200);
        rotate([0, 0, -90 + suspension_camber]) cube(200);
    }

    cube(200);
    }

    rotate([0, 0, suspension_camber])
    translate([suspension_bow_diameter/2, -5, 0])
    difference(){
        hull(){
            #translate([-suspension_thickness, 5, 0])
                cube([suspension_thickness, 1, suspension_depth]);
            translate([-6, -3, 0]) cube([6, 6, suspension_depth]);
            translate([0, 0, suspension_depth/2])
                rotate([0, -90, 0])
                    cylinder(d = M3_screw_diameter+5, h = 6);
        }


        translate([0, 0, suspension_depth/2])
            rotate([0, 90, 0])
                cylinder(d = M3_screw_diameter, h = 30, center = true);
    }

}


888_2002();
