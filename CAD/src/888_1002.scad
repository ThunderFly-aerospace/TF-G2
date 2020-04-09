//@set_slicing_config(slicing/default.ini)

//dil pro pripevneni tazneho motoru
include <../parameters.scad>

sides_height = 80; //vyska sten
lenght = 33; //delka sten z vykresu, nepouzity
thickness = motor_holder_thickness; //sirka sten - dost random
drzak_height = 70; //vyska drzaku



module 888_1002(){
translate([0, -motor_holder_thickness/2, 0])
difference(){
	translate([0, 0, -rantl_height + base_thickness + 0.2])
	union(){

// zakladni tvar
		hull(){
			translate([-base_width/2,-thickness/2,0])
				cube([base_width,thickness, motor_holder_motor_height*1.56]);
		    translate([0, thickness/2, motor_holder_motor_height])
		        rotate([90,0,0])
			        cylinder(d=50,h=thickness,$fn=100);
		}

// Spodni priruba
		hull(){
			translate([0, 0, motor_holder_thickness/2+2])
				cube([30, 1, motor_holder_thickness+4], center = true);

			translate([0, - 10 + motor_holder_thickness/2, 0])
				cylinder(d = 10, h = motor_holder_thickness, $fn=80);
		}

// Bocni priroby
		for(i = [0, -1]) mirror([i, 0, 0])
			translate([-base_width/2, 0, motor_holder_side_mount_height -(-rantl_height + base_thickness + 0.2)])
				hull(){
					translate([motor_holder_thickness/2+2.5, 0, 0])
						cube([motor_holder_thickness+5, 1, 20], center = true);

					translate([0, - 10 + motor_holder_thickness/2, 0])
						rotate([0,90, 0])
							cylinder(d = 10, h = motor_holder_thickness, $fn=80);
				}

	}

	translate([0, 0, -rantl_height + base_thickness + 0.2])
			translate([0, - 10 + motor_holder_thickness/2, 0])
				cylinder(d = M3_screw_diameter, h = motor_holder_thickness+1, $fn = 30);

	translate([0, 0, -rantl_height + base_thickness + 0.2 + 1.5])
			translate([0, - 10 + motor_holder_thickness/2, 0])
				cylinder(d = M3_nut_diameter, h = motor_holder_thickness+1, $fn = 6);

		translate([0, -10 + motor_holder_thickness/2, motor_holder_side_mount_height])
			rotate([0, 90, 0])
				union(){
					cylinder(d = M3_screw_diameter, h = base_width+1, $fn = 30, center = true);
					cylinder(d = M3_nut_diameter, h = base_width+-6, $fn = 6, center = true);
				}

	union(){
//+2 kvadriky
        for (i=[base_width-rantl_thickness,0,0])
            translate([i-base_width/2-0.15,-20/2, -base_thickness])
                cube([rantl_thickness+0.3, 20, rantl_height+0.2]);

//dira uprostred
        translate([0, thickness/2 + 0.5, motor_holder_motor_height])
            rotate([90,0,0])
		        cylinder(d=10,h=thickness+1,$fn=100);

// Otvor pro vzduch do motoru
        translate([0, thickness/2 + 0.5, motor_holder_motor_height])
            rotate([90,0,0])
			difference(){
		        cylinder(d=36,h=thickness+1,$fn=100);
		        cylinder(d=17,h=thickness+1,$fn=100);
				cube([10, 50, 50], center = true);
				cube([50, 10, 50], center = true);
			}

//diry na sroubky uvnitr
        for (i=[0,90,180,270])
            translate([0,thickness/2,motor_holder_motor_height]) //posunuti teziste triketry
                rotate([90,0,0]) //otoceni valecku, aby to byla dirka
                    rotate([0,0,i]) //triketra itself
                        translate([0,25/2,-0.5]) //ramena triketry
                            cylinder(d=M3_screw_diameter,h=thickness+1,$fn=50);

    }
}

}


888_1002();
