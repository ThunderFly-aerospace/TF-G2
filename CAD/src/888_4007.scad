include <../parameters.scad>

// Diameter of the whole holder
diameter = 20;
// Tooth diameter
tooth_diameter = 3;

module 888_4007(){
	difference(){
		union(){
			cylinder(r=diameter/2, h=3, center=true, $fn = 600);
	        cylinder(d=3 * M3_screw_diameter, h = 3 * M3_screw_diameter, $fn = 50);
		}

		for ( i = [0 : 30 : 360] ){
			translate([sin(i)*diameter/2,cos(i)*diameter/2,-3]) cylinder(r=tooth_diameter/2,h=6, $fn=50);
		}

		translate([0,0,-1.5-0.1])
	        cylinder(d = M3_nut_diameter, h = 3 * M3_screw_diameter, $fn=6);
		translate([0,0,3 * M3_screw_diameter -1.5 + layer_thickness])
	        cylinder(d = M3_screw_diameter, h=5, $fn=20);

		translate([0,0,M3_screw_diameter])
					rotate([90,0,0])
				       cylinder(d = M3_nut_diameter/2, h = 3 * M3_screw_diameter, $fn=6, center= true);

	}
}

888_4007();
