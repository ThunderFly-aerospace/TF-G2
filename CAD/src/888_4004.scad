include <../parameters.scad>;

module 888_4004() {
	blade_screws_distance = (16.47+11.86)/2;
    angle_between_blades = 360 / rotor_blades_count;
	screw_diameter = blade_mount_screw;
	move_index = 4+screw_diameter/2;
    blade_screws_distance = (16.47+11.86)/2;
	blade_holder_widh = blade_mount_width;
	thickness = 1.97;
	offset_size = 36;

	long_edge = 30.2+0.75;
	short_edge = 26.7+0.75;

	points = [
		[0, 0, 0],
		[long_edge, 0, 0],
		[short_edge, blade_holder_widh, 0],
		[0, blade_holder_widh, 0],
		[0, 0, thickness],
		[long_edge, 0, thickness],
		[short_edge, blade_holder_widh, thickness],
		[0, blade_holder_widh, thickness]
	];

	faces = [
		[0, 1, 2, 3],
		[4, 5, 1, 0],
		[7, 6, 5, 4],
		[5, 6, 2, 1],
		[6, 7, 3, 2],
		[7, 4, 0, 3]
	];

	difference() {
		union() {
			polyhedron(points, faces);

			rotate([0, 0, -90])
			translate([-blade_holder_widh/2, offset_size, thickness/2])
			hull(){
				cylinder(r = 3+9, h = thickness, center = true, $fn = 100);

				for (i = [0:rotor_blades_count]){
					rotate([0,0, i*angle_between_blades])
						translate([0, blade_screws_distance, 0])
							cube([blade_holder_widh, blade_screws_distance/2, thickness], center = true);
				}
          	}

			translate([move_index, blade_holder_widh/2, 1.97]) cylinder(d=1.6*blade_mount_nut, h=M3_nut_height, $fn=40	);
			translate([move_index+blade_screws_distance, blade_holder_widh/2, 1.97]) cylinder(d=1.6*blade_mount_nut, h=M3_nut_height, $fn=40);
		}

		translate([long_edge, 0, -10]) {
			rotate([0, 0, atan((long_edge-short_edge)/blade_holder_widh)]) {
				translate([0, -50, 0])
				cube([100, 100, 100]);
			}
		}


		translate([move_index, blade_holder_widh/2, 0]) cylinder(d=screw_diameter, h=2, $fn=20);
		translate([move_index+blade_screws_distance, blade_holder_widh/2, 0]) cylinder(d=screw_diameter, h=2, $fn=20);
		translate([move_index, blade_holder_widh/2, 1.97]) cylinder(d=blade_mount_nut, h=M3_nut_height, $fn=6);
		translate([move_index+blade_screws_distance, blade_holder_widh/2, 1.97]) cylinder(d=blade_mount_nut, h=M3_nut_height, $fn=6);
	}
}

888_4004();
