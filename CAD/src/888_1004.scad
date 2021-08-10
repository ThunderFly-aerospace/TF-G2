//Ochranny ram nad motorem
include <../parameters.scad>


$fn = $preview? 20:30;

module 888_1004(){


	for(y = [-1, 1])
		translate([-motor_protective_frame_plug_length/2, y*motor_protective_frame_width/2 - y*(motor_protective_frame_plug_thickness-0.2)/2, 0])
			cube([motor_protective_frame_plug_length, motor_protective_frame_plug_thickness-0.2, motor_protective_frame_beam_width], center=true);

		difference(){
			scale([motor_protective_frame_z_scale, 1, 1])
				cylinder(d = motor_protective_frame_width, h = motor_protective_frame_beam_width, center=true);
			scale([motor_protective_frame_z_scale, 1, 1])
				cylinder(d = motor_protective_frame_width - motor_protective_frame_beam_thickness*2, h = motor_protective_frame_beam_width+1, center=true);
			translate([-100, -50, -10]) cube([100, 100, 20]);
	}
}


rotate([0, -90, 0]) 888_1004();