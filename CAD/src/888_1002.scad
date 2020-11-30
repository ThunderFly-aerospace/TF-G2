//@set_slicing_config(slicing/default.ini)

//dil pro pripevneni tazneho motoru
include <../parameters.scad>

sides_height = 80; //vyska sten
lenght = 33; //delka sten z vykresu, nepouzity
thickness = motor_holder_thickness; //sirka sten - dost random
drzak_height = 70; //vyska drzaku

motor_diameter = 35.2;


x_offset = 50;

motor_angle = -5; //angle of proppler axis

if(0)
translate([x_offset, 0, motor_holder_motor_height -(-rantl_height + base_thickness + 0.2)])
  rotate([0, -90 - motor_angle, 0]) translate([0, 0, thickness]) {
    cylinder(d = motor_diameter, h = 50);
    translate([0, 0, -20]) cylinder(d = 5, h = 50);

  }

module 888_1002(motor_angle = motor_angle) translate([-5, 0, 0]) {
//translate([0, -motor_holder_thickness/2, 0])
difference(){
	//translate([0, 0, -rantl_height + base_thickness + 0.2])
	union(){

// zakladni tvar
		hull(){
			translate([0, -base_width/2, 0])
				cube([10, base_width, motor_holder_motor_height*1.5]);

				translate([x_offset-15, 0, 0]) cylinder(d = 20, h=2);

	        translate([x_offset, 0, motor_holder_motor_height -(-rantl_height + base_thickness + 0.2)])
	            rotate([0, 90 - motor_angle, 0]){
	            	translate([0, 1, 0]) cylinder(d=motor_diameter+thickness*0, h=thickness, $fn=100);
	            	translate([0, -1, 0]) cylinder(d=motor_diameter+thickness*0, h=thickness, $fn=100);
              }
		}


/*
	translate([15, -thickness/2+0.2, 1])
		rotate([90, 0, 0])
			linear_extrude(0.2+0.6+2.5)
				text(str(week), size=6);

	translate([-25, -thickness/2+0.2, 1])
		rotate([90, 0, 0])
			linear_extrude(0.2+0.6+2.5)
				text(str(motor_angle), size=6); */

	}


    translate([x_offset, 0, motor_holder_motor_height -(-rantl_height + base_thickness + 0.2)])
      rotate([0, 90 - motor_angle, 0]){

        cylinder(d=13, h=20, $fn=100);

        for(x = [1,2,3,4])
          rotate([0, 0, 90*x+45])
            translate([0, 25/2, 0])
              cylinder(d = M3_screw_diameter, h = 20);

        for(x = [1,2,3,4])
          rotate([0, 0, 90*x])
            translate([0, 25/2, 0])hull(){
              translate([2, 0, 0]) cylinder(d = M5_screw_diameter, h = 20);
              translate([-2, 0, 0]) cylinder(d = M5_screw_diameter, h = 20);
            }
    }

    // spodni vyrez - odlehceni
    hull(){
  			cube([thickness*6, base_width-thickness*4, 20], center = true);
				translate([x_offset-15, 0, 0]) cylinder(d = 20-thickness, h=10);


    }

    difference(){
  		hull(){
  			translate([-0.1, -base_width/2+thickness*1.5, thickness])
  				cube([thickness*3, base_width-thickness*3, motor_holder_motor_height*1.5]);

  			translate([-0.1, -base_width/2+thickness, motor_holder_height/3])
  				cube([thickness*3, base_width-thickness*2, motor_holder_motor_height*1.5]);

  				translate([x_offset-15, 0, thickness]) cylinder(d = 20, h=2);

  	        translate([x_offset, 0, motor_holder_motor_height -(-rantl_height + base_thickness + 0.2)])
  	            rotate([0, 90 - motor_angle, 0])
                  hull(){
                    cylinder(d=motor_diameter, h=0.1, $fn=100);
                    translate([-3,0,0]) cylinder(d=motor_diameter, h=0.1, $fn=100);
                  }


  		}
          translate([-1, -base_width/2 + 0.3, 0.2])
            cube([30, rantl_thickness*1.5, rantl_height+5]);

          translate([-1, base_width/2 - rantl_thickness - 0.3, 0.2])
            cube([30, rantl_thickness*1.5, rantl_height+5]);




    }

	translate([0, 0, 4])
			translate([5, 0, 0]){
				cylinder(d = M3_screw_diameter, h = motor_holder_thickness+10, $fn = 30, center=true);
				cylinder(d = M3_nut_diameter, h = motor_holder_thickness+1, $fn = 6);
      }

  for(z = [[motor_holder_side_mount_height+rantl_height/2, 0, 6], [rantl_height/2, 0, 10], [rantl_height/2, 10, 13]])
		translate([5+z[1], 0, z[0]])
			rotate([90, 0, 0]){
					cylinder(d = M3_screw_diameter, h = base_width+10, $fn = 30, center = true);
					translate([0, 0, (base_width-z[2])/2 - 3]) cylinder(d = M3_nut_diameter, h = 6, $fn = 6, center = true);
					translate([0, 0,-(base_width-z[2])/2 + 3]) cylinder(d = M3_nut_diameter, h = 6, $fn = 6, center = true);
				}


//+2 kvadriky

    for(m = [0,1])
    mirror([0, m, 0])
    translate([-1, -base_width/2 -0.1, -0.1])
      hull(){
        cube([30, rantl_thickness+0.3, rantl_height+0.5]);
        translate()cube([30, 0.1, rantl_height+7]);
      }


	}
}


888_1002();
