include<../parameters.scad>
include<lib/stdlib/sweep.scad>
use<888_3002.scad>

height = 150;
height_bottom_part = 130;
depth_max = 200;

below_height = 30;
rudder_depth = 60;

N = 80;

rudder_below = 10;
rudder_radius = 6;


module tail_rudder(servo_hand = true, axis = true){
    difference(){
        intersection(){
            tail_vertical();

        // space for rudder
            rotate([0, -rudder_inclination, 0])
            translate([-15,0,-70])
            difference(){
                hull(){
                    rotate([0, rudder_inclination, 0])
                        translate([depth_max - rudder_depth, -10, height/2])
                            cube([rudder_depth*2/3, 20, height]);
                    translate([depth_max - rudder_depth+10, -10, -20])
                        cube([rudder_depth/2, 20, 2*height]);
                    translate([depth_max - rudder_depth, 0, 0])
                        cylinder(d = 5, h = 2*height_bottom_part, $fn=60);
                }
        // beveled top of rudder
                translate([depth_max - rudder_depth - rudder_radius -5, 0, height_bottom_part + 15])
                    cylinder(r1 = rudder_radius/2 + 2, r2 = 8*rudder_radius + 2, h = height - height_bottom_part + 40 );

            }
        }
        // hole for rotation axis
        if(axis == true)
        rotate([0, -rudder_inclination, 0])
            translate([depth_max - rudder_depth - 15, 0, -1.3*height_bottom_part])
              cylinder(d = 2.6, h = 2*height_bottom_part+rudder_below+1, $fn = 60);
    }

    // servo hand
    if(servo_hand == true)
    translate([depth_max - rudder_depth, 0, 0]) difference(){
        hull(){
            translate([10, 0, 1]) cube([10, 2, 2], center = true);
            translate([0, 20, 0]) cylinder(d = 7, h=2, $fn=40);
        }
        translate([0, 20, 0]) cylinder(d = 2, h=2, $fn=40);
    }
}

tail_rudder();

module 888_3004()
    tail_rudder();

module 888_3004_modif_pipe(){
  difference(){
    rotate([0, -rudder_inclination, 0])
        translate([depth_max - rudder_depth - 15, 0,  -1.3*height_bottom_part])
            cylinder(d = 3.4, h = 2*height_bottom_part+rudder_below+1, $fn = 60);
    rotate([0, 180, 180])
        translate([0,-10,0])
            cube([2*rudder_depth_max, 20, 2*height]);
  }
}

%888_3004_modif_pipe();


module 888_3004_modif_hand(){
    translate([depth_max - rudder_depth, 0, -rudder_below]) hull(){
        translate([10, 0, 1]) cube([10, 2, 2], center = true);
        translate([0, 20, 0]) cylinder(d = 7, h=2, $fn=40);
    }
}

% 888_3004_modif_hand();
