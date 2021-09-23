
//@set_slicing_config(../slicing/default.ini)
include <../parameters.scad>

use <./888_4002.scad>
use <./888_4004.scad>
use <./888_4005.scad>
use <./888_4006.scad>
use <./888_4007.scad>


angle_between_blades = 360 / rotor_blades_count;
blade_holder_widh = blade_mount_width;
rotor_center_plate_size = 30;
rotor_mounting_plate_size = 20;
shaft_diameter = 6.1;
thickness = 2.3;
blade_screws_distance = (16.47+11.86)/2;

edge_distance = 15;
spacer_disc_diameter = 3 * blade_mount_screw;
spare_disc_height = 0.6;

module 888_4010_rotorhead_assembly() {
	888_4002(); // trhaci podlozka

    for(r = [180, 0])
		rotate([0, 0, r])
		translate([-8.5, -36, 0])
		rotate([180, 0, 90])
		888_4004(); // podlozky rotoru spodni

	translate([0, 0, 1.8])
	rotate([0, 0, 90-25])
	888_4005(); // pevna podlozka

    for(r = [180, 0])
		rotate([0, 0, r])
		translate([0, 0, 1.8])
		888_4006(); // podlozky rotoru horni

	translate([0, 0, 1.8+12.5])
	rotate([0, 180, 0])
	888_4007(); // utahovací matka
}

module 888_4010_cam() {
	// camera body
	translate([-(59.2-10)/2, -(40.6-10)/2, 0])
	minkowski() {
		cylinder(d=10, h=30, $fn=30);

		cube([59.2-10, 40.6-10, .01]);
	}
	
	// camera view visual
	translate([0, 0, 30])
	cylinder(d1=12, d2=30, h=40, $fn=30);

	// photo screw
	translate([0, -40.6/2+.1, 15])
	rotate([90, 0, 0])
	cylinder(d=6.5, h=10, $fn=30);

	// record button
	translate([-59.2/2+15, 40.6/2-.1, 14])
	rotate([-90, 0, 0])
	cylinder(d=13.5, h=10, $fn=30);

	// power button
	translate([59.2/2-13, 40.6/2-.1, 14])
	rotate([-90, 0, 0])
	cylinder(d=10.5, h=10, $fn=30);
}

module 888_4010_rotor_washer(thickness=2.3) {
	translate([0,0,thickness/2])
	rotate([0,0, -rotor_delta_angle])
	difference() {
		union(){
			rotate([0, 0, -90+rotor_delta_angle])
			hull(){
				cube([40, 20, thickness], center=true);

				for (i = [0:rotor_blades_count]){
					rotate([0,0, i*angle_between_blades])
						translate([0, blade_screws_distance, 0])
							cube([blade_holder_widh, blade_screws_distance/2, thickness], center = true);
				}
			}
		}

		cylinder(d = M3_screw_diameter, h = 3* thickness, center = true, $fn = 20);
		for (i = [1:rotor_blades_count]){
			rotate([0, 0, i*angle_between_blades + angle_between_blades/2 + 180])
				translate([0, edge_distance, 0])
					cube([50, 15, 10], center = true);

			if (rotor_blades_count/2 == round(rotor_blades_count/2))  // check if there is even or odd blade number
			{
				rotate([0,0, i*angle_between_blades])
					translate([0, 3 + 4.5 + blade_mount_screw/2, 0]) {
						cylinder(d = blade_mount_screw, h = 10, center = true, $fn = 20);
					}
			}
			else
			{
				rotate([0,0, i*angle_between_blades - angle_between_blades/2 ])
					translate([0, 3 + 4.5 + blade_mount_screw/2, 0]) {
						cylinder(d = blade_mount_screw, h = 10, center = true, $fn = 20);
					}
			}
		}

	// space for rotor fixing nut
	translate([0,0,thickness-thickness/2+0.5])
		cylinder(d = spacer_disc_diameter, h = thickness + 0.5, $fn = 100);

	}
}

module 888_4010() {
	difference() {
		union() {
			difference() {
				hull() {
					translate([0, 3.4, (59.2+4)/2+18])
					cube([20, 40.6+4, 59.2+4], true);
					
					translate([0, 0, thickness*2+1.8])
					888_4010_rotor_washer();
				}

				translate([-15-0.75, 3.5, 59.2/2+20])
				rotate([0, 90, 0])
				888_4010_cam();

				cylinder(d=M3_screw_diameter, h=30, $fn=30);
			}

			888_4010_rotor_washer(thickness*2+2);
		}

		translate([0, 0, thickness])
		hull() {
			translate([0, 0, 2.5])
			cube([30, 30, 5], center=true);

			translate([0, 0, 14])
			cube([30, 25, 5], center=true);
		}
		
		/*
		translate([0, -(40.6+6)/2+3, (59.2+4)/2+18])
		cube([30, .6, 15], center=true);
	
		translate([0, -(40.6+6)/2+.3, (59.2+4)/2+18-7.5])
		cube([30, 6, .6], center=true);
	
		translate([0, -(40.6+6)/2+6-.3, (59.2+4)/2+18+7.5])
		cube([30, 6, .6], center=true);
		*/

		translate([-25, 3.4, 59.2-5+20])
		rotate([0, 90, 0])
		for(i=[0:1:1]) {
			mirror([0, i, 0])
			translate([0, -(40.6-10)/2, 0])
			difference() {
				cylinder(d=40, h=40, $fn=30);

				translate([0, 0, -.01])
				cylinder(d=14, h=50, $fn=30);

				translate([0, 25, 25])
				cube([50, 50, 60], center=true);

				translate([25, 0, 25])
				cube([50, 50, 60], center=true);
			}
		}
	}
}


888_4010();

translate([-15-0.75, 3.4, 59.2/2+20])
rotate([0, 90, 0])
#888_4010_cam();

translate([0, 0, thickness])
rotate([0, 0, 90])
#888_4010_rotorhead_assembly();


