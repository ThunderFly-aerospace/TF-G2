include <../parameters.scad>;

module 888_4006(AOA = rotor_blade_AOA) {
    blade_screws_distance = (16.47+11.86)/2;
    move_index = 4+blade_mount_screw/2;
	  blade_holder_widh = blade_mount_width;
    angle_between_blades = 360 / rotor_blades_count;
    thickness = 10;
    offset_size = 36;

    short_edge_bottom = 26.65;
    short_edge_top = 25;
    long_edge_bottom = 30.3;

    points = [
    	[0, 0, 0],
    	[short_edge_bottom, 0, 0],
    	[long_edge_bottom, blade_holder_widh, 0],
    	[0, blade_holder_widh, 0],
    	[0, 0, 10],
    	[short_edge_top, 0, 10],
    	[27.4, blade_holder_widh, 10],
    	[0, blade_holder_widh, 10]
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
        }


		translate([short_edge_bottom, 0, 0]) {
			rotate([0, -atan((short_edge_bottom-short_edge_top)/thickness), -atan((long_edge_bottom-short_edge_bottom)/blade_holder_widh)]) {
				translate([0, -50, -10])
				cube([100, 100, 100]);
			}
		}



    	translate([move_index, blade_holder_widh/2,  -global_clearance])
          rotate([-AOA, 0, 0])
            cylinder(d=blade_mount_screw, h=4, $fn=20);
    	translate([move_index+blade_screws_distance, blade_holder_widh/2,  -global_clearance])
          rotate([-AOA, 0, 0])
            cylinder(d=blade_mount_screw, h=4, $fn=20);

        // Vytvoreni sikme plochy
        translate([0, blade_holder_widh/2, 0])
            rotate([-AOA, 0, 0]){
                translate([0, 0, 150/2+2])
                    cube(150, center = true);
                translate([15, -5, 2-0.2])
                    rotate([0, 0, 90])
                        linear_extrude(10)
                            text(str(AOA), size = 5);
                }
    }
}
888_4006();
