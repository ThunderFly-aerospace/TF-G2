include <../parameters.scad>

module 888_4003(){

    angle_between_blades = 360 / rotor_blades_count;
	blade_holder_widh = blade_mount_width;
    rotor_center_plate_size = 30;
    rotor_mounting_plate_size = 20;
    shaft_diameter = 6.1;
    thickness = 2.3;
    blade_screws_distance = (16.47+11.86)/2;

    edge_distance = 15;
    spacer_disc_diameter = 3 * M3_screw_diameter;
    spare_disc_height = 0.6;

    translate([0,0,thickness/2])
        rotate([0,0, rotor_delta_angle]) {
            difference() {
                union(){
                    cylinder(r = 3+9, h = thickness, center = true, $fn = 100);
                    translate([0,0,-thickness/2])
                        cylinder(d = spacer_disc_diameter, h = thickness + 0.5, $fn = 100);


                    
                    rotate([0, 0, -90-rotor_delta_angle])
                    hull(){
                        cylinder(r = 3+9, h = thickness, center = true, $fn = 100);

                        for (i = [0:rotor_blades_count]){
                            rotate([0,0, i*angle_between_blades])
                                translate([0, blade_screws_distance, 0])
                                    cube([blade_holder_widh, blade_screws_distance/2, thickness], center = true);
                        }
                    }
                }

                cylinder(d = M3_screw_diameter, h = 3* thickness, center = true, $fn = 20);
                translate([0,0,thickness - M3_nut_height/4])
                    cylinder(d = M3_nut_diameter, h = M3_nut_height, center = true, $fn = 6);

                for (i = [1:rotor_blades_count]){
                    rotate([0, 0, i*angle_between_blades + angle_between_blades/2 + 180])
                        translate([0, edge_distance, 0])
                            cube([30, 15, 10], center = true);

                    if (rotor_blades_count/2 == round(rotor_blades_count/2))  // check if there is even or odd blade number
                    {
                        rotate([0,0, i*angle_between_blades])
                            translate([0, 3 + 4.5 + blade_mount_screw/2, 0])
                                cylinder(d = blade_mount_screw, h = 2* thickness, center = true, $fn = 20);
                    }
                    else
                    {
                        rotate([0,0, i*angle_between_blades - angle_between_blades/2 ])
                            translate([0, 3 + 4.5 + blade_mount_screw/2, 0])
                                cylinder(d = blade_mount_screw, h = 2* thickness, center = true, $fn = 20);
                    }
                }
            }
        }
}

888_4003();
