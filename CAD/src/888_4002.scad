
//
//
//

include <../parameters.scad>

module 888_4002(hole_diameter=3)
{
    angle_between_blades = 360 / rotor_blades_count;
    shaft_diameter = M3_screw_diameter;
    thickness = 1.8;
    blade_screws_distance = (16.47+11.86)/2;
    blade_holder_widh = blade_mount_width;

    translate([0, 0, thickness/2])
    difference () {
        union () {
          hull(){
            cylinder(r = 3+9, h = thickness, center = true, $fn = 100);
            for (i = [0:rotor_blades_count]){
                rotate([0,0, i*angle_between_blades])
                    translate([0, blade_screws_distance, 0])
                        cube([blade_holder_widh, blade_screws_distance/2, thickness], center = true);
            }
          }



            for (i = [0:rotor_blades_count]){
                rotate([0,0, i*angle_between_blades])
                    translate([0, 20, 0])
                        cube([blade_holder_widh, 30, thickness], center = true);
            }
        }

        cylinder(d = shaft_diameter, h = 2* thickness, center = true, $fn = 20);


        for (i = [1:rotor_blades_count]){
            rotate([0,0, i*angle_between_blades])
                translate([0, 16.5 + blade_screws_distance/2, 0]) {
                    translate([0, blade_screws_distance/2, 0])
                        cylinder(d = blade_mount_screw, h = 2* thickness, center = true, $fn = 20);
                    translate([0, -blade_screws_distance/2, 0])
                        cylinder(d = blade_mount_screw, h = 2* thickness, center = true, $fn = 20);

                    //diry pro lepsi moznost utrzeni listu
                    translate ([blade_holder_widh/2 + hole_diameter/3, -blade_screws_distance/2, 0])
                        cylinder (h=thickness*2, d=2.2 * hole_diameter, center=true, $fn=4);

                    translate ([-blade_holder_widh/2 - hole_diameter/3, -blade_screws_distance/2, 0])
                        cylinder (h=thickness*2, d=2.2 * hole_diameter, center=true, $fn=4);


                }
        }

        rotate([0,0, -rotor_delta_angle])
        for (i = [1:rotor_blades_count]){
            rotate([0,0, i*angle_between_blades + angle_between_blades/2])
                translate([0, 3 + 4.5 + blade_mount_screw/2, 0])
                    cylinder(d = blade_mount_screw, h = 2* thickness, center = true, $fn = 20);
        }

        translate([-3.5, 3, 0.4])
          linear_extrude(1)
            text(str(week), size = 5);

        translate([-4.5, -8, 0.4])
          linear_extrude(1)
            text(str(thickness), size = 5);
    }
}

888_4002();
