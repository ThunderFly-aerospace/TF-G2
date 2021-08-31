//dil pro pripevneni tazneho motoru
include <../parameters.scad>
use <888_1004.scad>

thickness = motor_holder_thickness; //sirka sten - dost random

motor_diameter = 35.2;
side_thickness = 3;

motor_x_shift = engine_offset;
motor_angle = engine_angle; //angle of proppler axis


// nahled motoru
/*if($preview)
%translate([motor_x_shift, 0, motor_holder_motor_height -(-rantl_height + base_thickness + 0.2)])
  rotate([0, -90 - motor_angle, 0]) translate([0, 0, thickness]) {
    cylinder(d = motor_diameter, h = 50);
    translate([0, 0, -20]) cylinder(d = 5, h = 50);

  }
*/

module 888_1002(motor_angle = motor_angle) translate([-5, 0, 0]) {
//translate([0, -motor_holder_thickness/2, 0])
difference(){
	union(){
  // zakladni tvar
		hull(){
  			translate([0, -base_width/2 - side_thickness, 0])
          cube([15, base_width + 2*side_thickness, pylon_holder_side_mount_height]);

        translate([0, -base_width/2 - side_thickness, 0])
          cube([25, base_width + 2*side_thickness, 10]);

				translate([motor_x_shift-15, 0, 0])
          cylinder(d = 20, h=pylon_holder_side_mount_height);

        translate([motor_x_shift, 0, motor_holder_motor_height -(-rantl_height + base_thickness + 0.2)])
          rotate([0, 90 - motor_angle, 0])
              cylinder(d=motor_diameter+thickness*1, h=thickness, $fn=100);

        translate([0, 0,  (base_width + 2*side_thickness)/2])
          rotate([0, 90 - motor_angle, 0])
              cylinder(d=base_width + 2*side_thickness, h=thickness, $fn=100);

		}
	}

    // Otvory pro pripevneni a vetrani motoru
    translate([motor_x_shift, 0, motor_holder_motor_height -(-rantl_height + base_thickness + 0.2)])
      rotate([0, 90 - motor_angle, 0]) rotate([0, 0, 45]){

        cylinder(d=13, h=20, $fn=100);

        for(x = [1,2,3,4])
          rotate([0, 0, 90*x+45])
            translate([0, 25/2, 0])
              cylinder(d = M3_screw_diameter, h = 20, $fn=20);

        for(x = [1,2,3,4])
          rotate([0, 0, 90*x])
            translate([0, 25/2, 0])hull(){
              translate([1.5, 0, 0]) cylinder(d = M6_screw_diameter, h = 20, $fn=20);
              translate([-1.5, 0, 0]) cylinder(d = M6_screw_diameter, h = 20, $fn=20);
            }
    }

    // spodni vyrez - odlehceni
    hull(){
		     cube([thickness*16, base_width-thickness*4, 20], center = true);
		     translate([motor_x_shift-15, 0, 0])
            cylinder(d = 20-thickness, h=10);
    }

    difference(){
  		hull(){
	  			translate([-0.1, -base_width/2+thickness*1.5, thickness*2])
	  				cube([thickness*8, base_width-thickness*3, pylon_holder_side_mount_height]);

					translate([0, 0,  pylon_holder_side_mount_height*1.2])
	          rotate([0, 90 - motor_angle, 0])
	              cylinder(d= base_width-thickness*3, h=thickness, $fn=100);

  				translate([motor_x_shift-15, 0, thickness/3])
              cylinder(d = 20, h=2);
  	      translate([motor_x_shift, 0, motor_holder_motor_height -(-rantl_height + base_thickness + 0.2)])
  	         rotate([0, 90 - motor_angle, 0])
                  hull(){
                    cylinder(d=motor_diameter, h=0.1, $fn=100);
                //    translate([-3,0,0])
                //        cylinder(d=motor_diameter, h=0.1, $fn=100);
                  }
  		}

      translate([-1, -base_width/2 + 0.3, 0.2])
        cube([30, rantl_thickness*1.5, rantl_height+5]);

      translate([-1, base_width/2 - rantl_thickness - 0.3, 0.2])
        cube([30, rantl_thickness*1.5, rantl_height+5]);
    }

  hull(){
    translate([-1,- base_width, motor_holder_side_mount_height + rantl_height/2 + M3_screw_diameter])
      cube([30, base_width*2, motor_holder_side_mount_height]);

#		translate([0, 0,  pylon_holder_side_mount_height*1.2])
			rotate([90, 0 - motor_angle, 0])
					cylinder(d= thickness*3, h=base_width, center = true,  $fn=100);


	}
  // Srouby do bocnic
  for(z = [[motor_holder_side_mount_height+rantl_height/2, 0, 6], [rantl_height/2, 0, 10], [rantl_height/2, 10, 10]])
		translate([5+z[1], 0, z[0]])
			rotate([90, 0, 0]){
				cylinder(d = M3_screw_diameter, h = base_width+10, $fn = 30, center = true);
		    translate([0, 0, (base_width-z[2])/2 - 3])
          cylinder(d = M3_nut_diameter, h = 6, $fn = 6, center = true);
        translate([0, 0,(base_width)/2  +rantl_thickness+0.1 + side_base_thickness])
          cylinder(d = M3_head_diameter, h = 6, $fn = 30, center = true);
				translate([0, 0,-(base_width-z[2])/2 + 3])
          cylinder(d = M3_nut_diameter, h = 6, $fn = 6, center = true);
        translate([0, 0,-(base_width)/2  -rantl_thickness-0.1 - side_base_thickness])
          cylinder(d = M3_head_diameter, h = 6, $fn = 30, center = true);
				}


  // Vyrez pro ochranny ram nad motorem
  for(m = [0, 1])
    mirror([0, m, 0])
      translate([motor_protective_frame_x_shift, 0, motor_protective_frame_z_base]){
        translate([0, 0, 10])
          cube([motor_protective_frame_beam_width, motor_protective_frame_width, 20], center=true);
        translate([0, motor_protective_frame_width/2-motor_protective_frame_plug_thickness/2, 0])
          cube([motor_protective_frame_beam_width, motor_protective_frame_plug_thickness, motor_protective_frame_plug_length*2], center=true);
      }

  if($preview)
    %translate([motor_protective_frame_x_shift, 0, motor_protective_frame_z_base]) rotate([0, -90, 0])
      888_1004();

// Vyrez na zapusteni bocnic
    for(m = [0,1])
      mirror([0, m, 0])
        translate([-0.5, base_width/2, -0.1])
          cube([10+1, 20, 50]);



    for(m = [0,1])
      mirror([0, m, 0])
        translate([-0.1, -base_width/2 -0.1, -0.1]){
            cube([25.1, rantl_thickness+0.3, rantl_height+1]);

          hull(){
            cube([10+0.5, rantl_thickness+0.3, rantl_height+1]);
            cube([10+0.5, 0.1, rantl_height+4]);
          }
      }
	}


// popisky
  translate([21, base_width/2+rantl_thickness, 8])
    rotate([90, 0, 180])
      linear_extrude(0.5)
        text(str(week), size = 6);

  translate([12, -base_width/2-rantl_thickness, 8])
    rotate([90, 0, 0])
      linear_extrude(0.5)
        text(str(motor_angle), size = 6);

  translate([motor_wire_holder_x_shift, -motor_wire_holder_thickness - motor_wire_holder_space + base_width/2 - rantl_thickness - thickness +1 , motor_wire_holder_z_shift]) cube([motor_wire_holder_width, motor_wire_holder_thickness, motor_wire_holder_height]);
  translate([motor_wire_holder_x_shift, -motor_wire_holder_thickness - motor_wire_holder_space + base_width/2 - rantl_thickness - thickness +1 , motor_wire_holder_z_shift + motor_wire_holder_height -1]) cube([motor_wire_holder_width, motor_wire_holder_thickness+1, 1]);

  hull(){
    translate([motor_wire_holder_x_shift, -motor_wire_holder_thickness - motor_wire_holder_space + base_width/2 - rantl_thickness/2 , 0]) cube([motor_wire_holder_width, motor_wire_holder_thickness, 0.1]);
    translate([motor_wire_holder_x_shift, -motor_wire_holder_thickness - motor_wire_holder_space + base_width/2 - rantl_thickness - thickness +1 , motor_wire_holder_z_shift]) cube([motor_wire_holder_width, motor_wire_holder_thickness, 0.1]);
  }
}

difference(){
  888_1002();
  translate([30, 0, 0]) cube(100);
}
