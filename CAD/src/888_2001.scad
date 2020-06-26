
//@set_slicing_config(../slicing/default.ini)
include <../parameters.scad>

$fn = 50;

front_axle_track = 300;
front_suspension_height = 100;
front_arm_shift = base_patern*0;
rear_arm_shift = base_patern*5;

arm_base_distance = 30;

arm_wire_thickness = 2.5;
arm_pipe_wall = 2;

module 888_2001_a(){

    difference(){
        union(){
          translate([0, 0, 1.5])
            cube([10, base_patern*3, 3], center = true);

        rotate([50, 0, 20]) difference(){
          cylinder(d = arm_wire_thickness+2*arm_pipe_wall, h=10);
          cylinder(d = arm_wire_thickness, h=10);
        }

        }

    }

}


888_2001_a();
