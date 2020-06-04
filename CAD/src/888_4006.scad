include <../parameters.scad>;

module 888_4006(AOA = rotor_blade_AOA) {
    blade_screws_distance = (16.47+11.86)/2;
    move_index = 4+blade_mount_screw/2;

    points = [
    	[0, 0, 0],
    	[26.15, 0, 0],
    	[28.8, 14, 0],
    	[0, 14, 0],
    	[0, 0, 10],
    	[25, 0, 10],
    	[27.4, 14, 10],
    	[0, 14, 10]
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
    	polyhedron(points, faces);
    	translate([move_index, 7,  -global_clearance])
            cylinder(d=blade_mount_screw, h=4, $fn=20);
    	translate([move_index+blade_screws_distance, 7,  -global_clearance])
            cylinder(d=blade_mount_screw, h=4, $fn=20);
        
        // Vytvoreni sikme plochy
        translate([0, 14/2, 0])
            rotate([-AOA, 0, 0]){
                translate([0, 0, 100/2+2])
                    cube(100, center = true);
                translate([15, -5, 2-0.2])
                    rotate([0, 0, 90])
                        linear_extrude(10)
                            text(str(AOA), size = 5);
                }
    }
}
888_4006();
