include <../parameters.scad>



thickness_top = 4;
thickness_flange = 0.8;
thickness_flange_out = 1.2;

inner_d = 20+M3_screw_diameter;
inner_thick_d = 25;


flange_thick_w = 2.5;
flange_thin_w = 8;

module 888_2007(){
difference(){
	
	union(){
		translate([0, 0, thickness_flange_out/2]) cube([inner_thick_d+2*flange_thin_w, inner_thick_d+2*flange_thin_w, thickness_flange_out], center=true);
		translate([0, 0, thickness_top/2]) cube([inner_thick_d+2*flange_thick_w, inner_thick_d+2*flange_thick_w, thickness_top], center=true);
	}

	translate([0, 0, 10])
		cube([inner_d, inner_d, 20], center=true);
	translate([0, 0, 10+thickness_flange])
		cube([inner_thick_d, inner_thick_d, 20], center=true);
	
	translate([100+inner_d/2, 0, 0]) cube(200, center=true);


	for (x = [-3:1]){
		translate([x*6+2, -inner_thick_d/2-flange_thin_w+3])
			cylinder(d=2, h =20, center=1, $fn=10);
		translate([x*6+2, -1*(-inner_thick_d/2-flange_thin_w+3)])
			cylinder(d=2, h =20, center=1, $fn=10);
			}

	for (x = [-2:2]){
		translate([(-inner_thick_d/2-flange_thin_w+3), x*6, 0])
			cylinder(d=2, h =20, center=1, $fn=10);
	}
}
}

888_2007();