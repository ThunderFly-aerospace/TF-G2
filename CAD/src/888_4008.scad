include <../parameters.scad>
include <lib/stdlib/polyScrewThread_r1.scad>


angle_between_blades = 360 / rotor_blades_count;

//shaft_diameter = 6.1;
thickness = 2.3;
top_thickness = 3;
//blade_screws_distance = (16.47+11.86)/2;

height_from_rotor_nut = 11.5 - 1.65 ;

// %cylinder(d = 5, h = height_from_rotor_nut);

rotor_center_r=12 + 1+0.5;
edge_distance_from_center = 7.5;

starter_top_h=M3_screw_head_height+3;
starter_pipe_d_top = 20;
starter_pipe_d_middle = 27;
starter_pipe_d_bottom = 20;
starter_neck_h=1;
starter_bottom_h=5;  
starter_rope_diameter=2;

sensor_cap_height=starter_top_h+starter_neck_h+starter_bottom_h;

rpm_sensor_h = height_from_rotor_nut - starter_top_h;
rpm_sensor_count=16;
rpm_hole_h = 50;

screws_h=14;

Ribbon_width = 6 - 1.2;
Ribbon_part_w = height_from_rotor_nut- (16.5 - 1.65) + Ribbon_width; // Auxiliary variable

/// Inner cliff
End_Wall_Thickness = 5;

// Holes for self-cutting screws in inner cliff
Self_screw_diameter = 2;
Depth_self_screw = 30;
Number_of_holes = 3;

// Groove for sensors
Depth_Groove_Sensors = 3.5;

Wire_thickness = 1.5 + 0.2;


pcb_holder_height = 3;
pcb_holder_width = starter_pipe_d_middle+0.2-End_Wall_Thickness*2+34;

total_height = top_thickness+starter_top_h+rpm_sensor_h+pcb_holder_height;

module 888_4008(draft = true) {
    translate([0,0,-top_thickness])
    rotate([0,0, rotor_delta_angle])
	difference() {
		union() {
			difference() {
				hull () {
					/// Cup + big cylinder (originaly for starter rope)
					cylinder(r = rotor_center_r, h = total_height-pcb_holder_height, $fn = draft?rpm_sensor_count:120);
					translate([0, 0, total_height])
					cylinder(d = pcb_holder_width, h = pcb_holder_height, $fn = draft?rpm_sensor_count:120); 
				}

				// Groove for sensors
				translate([0, 0, top_thickness+starter_top_h+rpm_sensor_h+pcb_holder_height+3-Depth_Groove_Sensors+.01])
				difference(){
					cylinder(d = pcb_holder_width-3, h = Depth_Groove_Sensors, $fn = draft?16:120);  
					
					cylinder(d = starter_pipe_d_middle+2.5, h = Depth_Groove_Sensors, $fn = draft?16:120);
					
				} 

				difference() {
					translate([0,0,top_thickness])
					cylinder(h=sensor_cap_height/2 + M3_nut_height, d1=starter_pipe_d_top - top_thickness, d2 = starter_pipe_d_middle, $fn=draft?rpm_sensor_count:120);

					translate([0,0,top_thickness])
					cylinder(h=M3_nut_height, d1=M3_nut_diameter*2, d2 = M3_nut_diameter * 1.2, $fn=draft?rpm_sensor_count:120);
					translate([0,0,top_thickness+M3_nut_height/2])
					difference() {
						cube([M3_nut_diameter * 1.2-.01, 30, M3_nut_height], center = true); 
							
						cube([M3_nut_diameter * 1.2, M3_nut_diameter*1.2+4, M3_nut_height], center = true); 
							
						translate([0,0,2.15])
						rotate([45,0,0])
						cube([M3_nut_diameter * 1.2,M3_nut_diameter*1.2+3,M3_nut_diameter*1.2+3], center = true); 
					}

					for (i = [1:rotor_blades_count]) {
						rotate([0, 0, i*angle_between_blades + angle_between_blades/2 + 180])
						translate([0, edge_distance_from_center+15/2, -10/2+thickness/2])
						union() {
							translate([0,-9,6.6])
							rotate([atan2(starter_top_h,(16-edge_distance_from_center)),0,0])
							translate([-14,0,-10])
							cube([30,15,10]);
						}
					}
				}

				/// Inner cut from the big cylinder (originaly for starter rope)
				translate([0,0,top_thickness + M3_nut_height + sensor_cap_height/2 - .01])
				cylinder(h=sensor_cap_height*2, d=starter_pipe_d_middle, $fn=draft?rpm_sensor_count:120);
				
				translate([0,0,top_thickness + M3_nut_height + 1.2*sensor_cap_height])
				cylinder(h=sensor_cap_height, d1=starter_pipe_d_middle, d2 = starter_pipe_d_bottom, $fn=draft?rpm_sensor_count:120);
			}

			////// INNER CLIFF                        
			difference() {
				translate([0,0,top_thickness + M3_nut_height + sensor_cap_height/2-4.5+1])
				cylinder(h=sensor_cap_height*0.7+Ribbon_part_w+pcb_holder_height-0.545, d=starter_pipe_d_middle-.01, $fn = draft?16:120);

				translate([0,0,top_thickness + M3_nut_height + sensor_cap_height/2-5.5])
				cylinder(h=sensor_cap_height*0.7+Ribbon_part_w+2.25+pcb_holder_height+.5, d1=starter_pipe_d_middle-4.9, d2 = starter_pipe_d_middle-End_Wall_Thickness*2, $fn = draft?16:120);
				
				translate([0,0,top_thickness + M3_nut_height + sensor_cap_height/2-3.5])
				cylinder(h=sensor_cap_height*0.7+Ribbon_part_w+2.25+pcb_holder_height+.5, d = starter_pipe_d_middle-End_Wall_Thickness*2, $fn = draft?16:120);
				
				// Groove for "grounded" wire
				rotate([0, 0,60])
				hull(){
					translate([starter_pipe_d_middle/2-End_Wall_Thickness+0, 0, 10])
					cylinder(h = 20, d = Wire_thickness, $fn = draft?6:20);
					translate([starter_pipe_d_middle/2-End_Wall_Thickness+1.5, 0, 10])
					cylinder(h = 20, d = Wire_thickness, $fn = draft?6:20);
				}

				// Holes for self-cutting screws
				for (i = [1:Number_of_holes]) {
					rotate([0, 0, i*360/Number_of_holes])
					translate([starter_pipe_d_middle/2-End_Wall_Thickness/2, 0, top_thickness + M3_nut_height + sensor_cap_height/2+Ribbon_width/2+1.15])
					cylinder(h = Depth_self_screw, d = Self_screw_diameter, center = true, $fn=20);                
				}
				
				for (i = [1:4]) {
					rotate([0, 0, i*360/4])
					translate([starter_pipe_d_middle/2-End_Wall_Thickness/2, 0, top_thickness + M3_nut_height + sensor_cap_height/2+Ribbon_width/2+1.15])
					cylinder(h = Depth_self_screw, d = Self_screw_diameter, center = true, $fn=20); 
				}
			}

			// Cylinders for the right compilation with disc
			rotate([0, 0, -45+35-rotor_delta_angle])
			translate([starter_pipe_d_middle/2-End_Wall_Thickness/2, 0, total_height+3])
			cylinder(h = 2, d = 3, $fn = 20);
			
			rotate([0, 0, -45+180+35-rotor_delta_angle])
			translate([starter_pipe_d_middle/2-End_Wall_Thickness/2, 0, total_height+3])
			cylinder(h = 2, d = 3, $fn = 20);
		}
        
        // Rotor nut
        translate([0, 0, -.01])
        cylinder(d = M3_nut_diameter, h = 40, $fn = 6);
        
        // Bottom holes
        translate([0, 0, thickness/2])
        for (i = [1:rotor_blades_count]) {
            rotate([0, 0, i*angle_between_blades + angle_between_blades/2 + 180])
            translate([0, edge_distance_from_center+15/2, -10/2+thickness/2])
            union() {
                cube([30, 15, 10], center = true);
                translate([0,-7.5,5])
                rotate([atan2(starter_top_h,(16-edge_distance_from_center)),0,0])
                translate([-15,0,-10])
                cube([30,30,10]);
            }
        
            angle=(rotor_blades_count/2 == round(rotor_blades_count/2))? (i*angle_between_blades):i*angle_between_blades - angle_between_blades/2;
            
            rotate([0,0, angle])
            union() {
                // Two screw holes around rotor axis
                translate([0, 3 + 4.5 + blade_mount_screw/2, -5])
                cylinder(d = blade_mount_screw, h = 8, $fn = 20);
                
                translate([0, 3 + 4.5 + blade_mount_screw/2,1.15 + M3_nut_height + layer_thickness]) 
                cylinder(d = blade_mount_screw, h = 3, $fn = 20);
                
                translate([0, 3 + 4.5 + blade_mount_screw/2, screws_h/2+thickness/2-7])
                cylinder(d = M3_nut_diameter, h =M3_nut_height, $fn = 6);
                
                translate([0, 3 + 4.5 + blade_mount_screw/2+4, screws_h/2+thickness/2-7+M3_nut_height/2])
                cube([M3_nut_diameter, 8  ,  M3_nut_height], center = true);
            }
        }
 
		// Hole for a wire
		rotate([0, 90,60])                
		translate([-(top_thickness + M3_nut_height + sensor_cap_height/2+Ribbon_width/2)/2-2, 0, starter_pipe_d_middle/2-End_Wall_Thickness+0])
		cylinder(h = 20, d = Wire_thickness+1, $fn = draft?6:20);
    }
}

difference() {
	888_4008(draft=true);

	//translate([-50, 0, -20])
	//cube([100, 50, 50]);
}
