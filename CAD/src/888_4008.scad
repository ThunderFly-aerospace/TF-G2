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

starter_rope_d = 27;

sensor_cap_height=starter_top_h+starter_neck_h+starter_bottom_h;

//  rpm_sensor_inner_r=12.5;
//  rpm_sensor_thickness = 1.3;
rpm_sensor_h = height_from_rotor_nut - starter_top_h;
//  rpm_sensor_base_h= 2;
rpm_sensor_count=16;
rpm_hole_h = 50;
//rpm_hole_width = 7;

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


// Mezikus
Total_w_mezikus = 6;
D_mezikus = starter_pipe_d_middle+0.2-End_Wall_Thickness*2+34;

module 888_4008(draft = true) {
    /// Inner paws for nut holders
    //         Paw_diameter = 10;
    //         Paw_h = 20; // Total height of paw
    //         Paw_thick = 2; // Thickness of the paw between screw head and nut
    //                    Paw_hole_diameter = M3_screw_diameter+0.1;
    
    /*module Paw(){                   
    // Pomocná proměnná
    H = top_thickness + M3_nut_height + sensor_cap_height/2+sensor_cap_height*0.7+Ribbon_part_w+0.25-2.5;
    difference(){
    union(){
    
    translate([starter_pipe_d_middle/2+(starter_rope_d + starter_rope_diameter-starter_pipe_d_middle)/2-Paw_diameter/2,0, H-Paw_h])
    cylinder(h=Paw_h, d1=Paw_diameter, d2 = Paw_diameter, $fn=draft?rpm_sensor_count:120);
    translate([starter_pipe_d_middle/2+(starter_rope_d + starter_rope_diameter-starter_pipe_d_middle)/2-Paw_diameter/2,-Paw_diameter/2,H-Paw_h])
    cube([2.5, Paw_diameter, Paw_h]);
    //                    translate([starter_pipe_d_middle/2+2,-Paw_diameter/2, H-Paw_h-Ribbon_part_w-2])
    //                        cube([1, Paw_diameter, 2]);
    }
    
    translate([starter_pipe_d_middle/2+(starter_rope_d + starter_rope_diameter-starter_pipe_d_middle)/2-Paw_diameter-2.5+1.4,-Paw_diameter/2,H-Paw_h-1])
    cube([2.5, Paw_diameter, Paw_h+4]);
    
    
    // Hole for screw
    translate([starter_pipe_d_middle/2+(starter_rope_d + starter_rope_diameter-starter_pipe_d_middle)/2-Paw_diameter/2+0.2,0, H-15])
    cylinder(h=30, d1=Paw_hole_diameter, d2 = Paw_hole_diameter, $fn=draft?rpm_sensor_count:120);
    
    // Nut hole 
    translate([starter_pipe_d_middle/2+(starter_rope_d + starter_rope_diameter-starter_pipe_d_middle)/2-15,-6/2, H-14-Paw_thick])
    cube([10, 6, 14]);
    
    translate([starter_pipe_d_middle/2+(starter_rope_d + starter_rope_diameter-starter_pipe_d_middle)/2-Paw_diameter/2+0.2,0, H-3-Paw_thick+0.5])
    cylinder(d = M3_nut_diameter, h = 2.5, $fn = 6);
    
    } 
    }
    */
    
    translate([0,0,-top_thickness])
    rotate([0,0, rotor_delta_angle])
    difference() {
        union() {
            difference() {
                /// Cup + big cylinder (originaly for starter rope)
                union() {
                    cylinder(r1 = rotor_center_r, d2=starter_rope_d, h = top_thickness+starter_top_h, $fn = draft?rpm_sensor_count:120);
                        
                    translate([0,0, top_thickness + starter_top_h])
                    cylinder(h=rpm_sensor_h, d=starter_rope_d , $fn=draft?rpm_sensor_count:120);
                }
        
                /// Cup with holes for rotor blades holder
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
                cylinder(h=sensor_cap_height*0.7, d1=starter_pipe_d_middle, d2 = starter_pipe_d_middle, $fn=draft?rpm_sensor_count:120);
                
                translate([0,0,top_thickness + M3_nut_height + 1.2*sensor_cap_height])
                cylinder(h=sensor_cap_height, d1=starter_pipe_d_middle, d2 = starter_pipe_d_bottom, $fn=draft?rpm_sensor_count:120);
                
                
            }
            
            ////// INNER CLIFF                        
            difference() {
                translate([0,0,top_thickness + M3_nut_height + sensor_cap_height/2-4.5])
                cylinder(h=sensor_cap_height*0.7+Ribbon_part_w+2.25-.01, d1=starter_pipe_d_middle-.01, d2 = starter_pipe_d_middle-.01, $fn = draft?16:120);
        
                translate([0,0,top_thickness + M3_nut_height + sensor_cap_height/2-5.5])
                cylinder(h=sensor_cap_height*0.7+Ribbon_part_w+2.25, d1=starter_pipe_d_middle-4.9, d2 = starter_pipe_d_middle-End_Wall_Thickness*2, $fn = draft?16:120);
                
                translate([0,0,top_thickness + M3_nut_height + sensor_cap_height/2-3.5])
                cylinder(h=sensor_cap_height*0.7+Ribbon_part_w+2.25, d = starter_pipe_d_middle-End_Wall_Thickness*2, $fn = draft?16:120);
                
                translate([0,0,top_thickness + M3_nut_height + sensor_cap_height/2-2.5+sensor_cap_height*0.7+Ribbon_part_w+0.25-4-0])
                difference() {
                    cylinder(h=4, d=starter_pipe_d_middle, $fn = draft?16:120);
                    
                    cylinder(h=4, d1=starter_pipe_d_middle, d2 = starter_pipe_d_middle-End_Wall_Thickness*2, $fn = draft?16:120);
                    
                    // Triangular protrusions for the right compilation with the second part
                    rotate([0, 0, 90 + 55])
                    translate([starter_pipe_d_middle/2-End_Wall_Thickness/2-.5, 0, 0])
                    rotate([0, 0, 60])
                    cylinder(h = 10, d1 = 8, d2 = 0, $fn = 3);
                    
                    rotate([0, 0, 90 - 55])
                    translate([starter_pipe_d_middle/2-End_Wall_Thickness/2-.5, 0, 0])
                    rotate([0, 0, 60])
                    cylinder(h = 10, d1 = 8, d2 = 0, $fn = 3);
                    
                    rotate([0, 0, - 90 + 55])
                    translate([starter_pipe_d_middle/2-End_Wall_Thickness/2-.5, 0, 0])
                    rotate([0, 0, 60])
                    cylinder(h = 10, d1 = 8, d2 = 0, $fn = 3);
                    
                    rotate([0, 0, - 90 - 55])
                    translate([starter_pipe_d_middle/2-End_Wall_Thickness/2-.5, 0, 0])
                    rotate([0, 0, 60])
                    cylinder(h = 10, d1 = 8, d2 = 0, $fn = 3);
                }
        
                translate([0,0,top_thickness + M3_nut_height + sensor_cap_height/2+32.3])
                cube([50,50,50], true);
                
                // Groove for "grounded" wire
                rotate([0, 0,60])
                hull(){
                    translate([starter_pipe_d_middle/2-End_Wall_Thickness+0, 0, 10])
                    cylinder(h = 10, d = Wire_thickness, $fn = draft?6:20);
                    translate([starter_pipe_d_middle/2-End_Wall_Thickness+1.5, 0, 10])
                    cylinder(h = 10, d = Wire_thickness, $fn = draft?6:20);
                }
                
      
                // Drážka pro uchycení stuhy
                //       rotate(90+360/Number_of_holes/2)
                //      translate([0,starter_pipe_d_middle/2,top_thickness + M3_nut_height + sensor_cap_height/2+Ribbon_width/2+1.15])
                //       cube([1,20,Ribbon_width], center=true ); 
        
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
        }
        
        /*
        //hex_screw(15,4,55,30,1.5,2,24,8,0,0);
        // Zavit pro namotani provazku
        translate([0, 0, top_thickness]) difference(){
        cylinder(d = starter_rope_d+10, h = rpm_sensor_h + starter_top_h);
        screw_thread(starter_rope_d, starter_rope_diameter, 45, rpm_sensor_h + starter_top_h, draft?3:PI/3, -2);
        
        // light blocking rim
        translate([0, 0, rpm_sensor_h + starter_top_h - 1.5*starter_rope_diameter])
        cylinder(d1 = starter_pipe_d_middle, d2 = starter_rope_d+starter_rope_diameter/2, h = starter_rope_diameter, $fn = draft?rpm_sensor_count:120);
        translate([0, 0, rpm_sensor_h + starter_top_h - starter_rope_diameter/2])
        cylinder(d = starter_rope_d+starter_rope_diameter/2, h = starter_rope_diameter, $fn = draft?rpm_sensor_count:120);
        }
        /*
        * Just a 100mm long threaded rod.
        *
        * screw_thread(15,   // Outer diameter of the thread
        *               4,   // Step, traveling length per turn, also, tooth height, whatever...
        *              55,   // Degrees for the shape of the tooth
        *                       (XY plane = 0, Z = 90, btw, 0 and 90 will/should not work...)
        *             100,   // Length (Z) of the tread
        *            PI/2,   // Resolution, one face each "PI/2" mm of the perimeter,
        *               0);  // Countersink style:
        *                         -2 - Not even flat ends
        *                         -1 - Bottom (countersink'd and top flat)
        *                          0 - None (top and bottom flat)
        *                          1 - Top (bottom flat)
        *                          2 - Both (countersink'd)
        *
        // screw_thread(15,4,55,100,PI/2,2);
        
        // Otvor na zastrceni provazku
        translate([0, 0, starter_top_h+top_thickness + rpm_sensor_h -1.65 ])
        rotate([-90, 0, -rotor_delta_angle - 45])
        cylinder(d = starter_rope_diameter, h = 50, center = false, $fn = 10);
        
        // Cut for rope fix before start
        rotate([0, 0, 180])
        translate([-starter_pipe_d_middle/2, starter_pipe_d_top/2 + (starter_pipe_d_middle/2 - starter_pipe_d_top/2)/2, starter_top_h - starter_top_h/3])
        rotate([30, 3, 0])
        cube([starter_pipe_d_middle, starter_pipe_d_middle, starter_rope_diameter]);
        */
        
        // Otvory pro senzor
        translate([0,0,top_thickness + M3_nut_height + sensor_cap_height])
        intersection() {
            union(){  // sensor teeth outer rim
                cylinder(d = starter_pipe_d_middle, h = rpm_hole_h/4, $fn = draft?rpm_sensor_count:120);
                
                translate([0, 0, - M3_nut_height - sensor_cap_height + rpm_sensor_h + starter_top_h - starter_rope_diameter])
                cylinder(d1 = starter_pipe_d_middle, d2 = starter_rope_d - starter_rope_diameter/2, h = starter_rope_diameter, $fn = draft?rpm_sensor_count:120);
            }
        
            for (i=[0:rpm_sensor_count]) rotate([0, 0, (360/rpm_sensor_count)*i]){
                linear_extrude(height = rpm_hole_h)
                polygon(points=[[0,0],[starter_rope_d/2, ((starter_rope_d/2) * sin(360/rpm_sensor_count/2))/2], [starter_rope_d/2, -((starter_rope_d/2) * sin(360/rpm_sensor_count/2))/2]]);
            }
        }
        
        // Rotor nut
        translate([0, 0, -.01])
        cylinder(d = M3_nut_diameter, h = 20, $fn = 6);
        
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
                cube([30,17,10]);
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
                    cylinder(h = 10, d = Wire_thickness+1, $fn = draft?6:20);
        
      
        
    }
}



module Mezikus(draft=true){
    rotate([0,0, rotor_delta_angle])
    difference() {
        union () {
            cylinder(d = D_mezikus, h = Total_w_mezikus, $fn = draft?16:120); 
    
            // Cliff for ribbon
            difference() {   
                cylinder(h = 2, d1 = D_mezikus+ 3, d2 = D_mezikus, $fn = draft?16:120);
                
                cylinder(h = 2, d = D_mezikus- 3, $fn = draft?16:120);       
            }
        }
        
        translate([0, 0, 6-4-1.6])
        cylinder(h=4, d1=starter_pipe_d_middle, d2 = starter_pipe_d_middle-End_Wall_Thickness*2, $fn = draft?16:120);
            
        // Triangular protrusions for the right compilation with the second part
        translate([0, 0, 0.3])
        intersection() {
            union() {
                rotate([0, 0, 90 + 55])
                translate([starter_pipe_d_middle/2-End_Wall_Thickness/2-.5, 0, 0])
                rotate([0, 0, 60])
                cylinder(h = 10+.1, d1 = 8+.1, d2 = 0, $fn = 3);
                
                rotate([0, 0, 90 - 55])
                translate([starter_pipe_d_middle/2-End_Wall_Thickness/2-.5, 0, 0])
                rotate([0, 0, 60])
                cylinder(h = 10+.1, d1 = 8+.1, d2 = 0, $fn = 3);
                
                rotate([0, 0, - 90 + 55])
                translate([starter_pipe_d_middle/2-End_Wall_Thickness/2-.5, 0, 0])
                rotate([0, 0, 60])
                cylinder(h = 10+.1, d1 = 8+.1, d2 = 0, $fn = 3);
                    
                rotate([0, 0, - 90 - 55])
                translate([starter_pipe_d_middle/2-End_Wall_Thickness/2-.5, 0, 0])
                rotate([0, 0, 60])
                cylinder(h = 10, d1 = 8, d2 = 0, $fn = 3);
            }
            
            translate([0, 0, 0])
            cylinder(d=starter_pipe_d_middle*2, h=4+.05, $fn=30);
        }
        
        cylinder(d = starter_pipe_d_middle-End_Wall_Thickness*2, h = Total_w_mezikus+.01, $fn = draft?16:120);
        
        translate([0, 0, -1.6]) 
        cylinder(d = starter_pipe_d_middle+0.2, h = Total_w_mezikus -4+.01, $fn = draft?16:120);
        
        // Holes for self-cutting screws  - ENLARGED
        for (i = [1:Number_of_holes]) {
            rotate([0, 0, i*360/Number_of_holes])
            translate([starter_pipe_d_middle/2-End_Wall_Thickness/2, 0, top_thickness + M3_nut_height + sensor_cap_height/2+Ribbon_width/2+0.15])
            cylinder(h = Depth_self_screw, d = Self_screw_diameter+0.5, center = true, $fn=20);
        }
        
        for (i = [1:4]) {
            rotate([0, 0, i*360/4])
            translate([starter_pipe_d_middle/2-End_Wall_Thickness/2, 0, top_thickness + M3_nut_height + sensor_cap_height/2+Ribbon_width/2+0.15])
            cylinder(h = Depth_self_screw, d = Self_screw_diameter + 0.5, center = true, $fn=20); 
        } 

        // Groove for "grounded" wire
        rotate([0, 0,60])
        hull(){
                translate([starter_pipe_d_middle/2-End_Wall_Thickness+0, 0, 0])
                cylinder(h = 10, d = Wire_thickness, $fn = draft?6:20);
                translate([starter_pipe_d_middle/2-End_Wall_Thickness+1.5, 0, 0])
                cylinder(h = 10, d = Wire_thickness, $fn = draft?6:20);
        }
        rotate([0, 0,60])
        translate([starter_pipe_d_middle/2-End_Wall_Thickness/2, 0, Total_w_mezikus])
        cube([End_Wall_Thickness+3, Wire_thickness ,  Wire_thickness*2], center = true);
        
        
        // Groove for sensors
        translate([0, 0, Total_w_mezikus-Depth_Groove_Sensors+.01])
        difference(){
            cylinder(d = D_mezikus-3, h = Depth_Groove_Sensors, $fn = draft?16:120);  
            
            cylinder(d = starter_pipe_d_middle+2.5, h = Depth_Groove_Sensors, $fn = draft?16:120);
            
        } 

 
    }
    
    // Cylinders for the right compilation with disc
    rotate([0, 0, 35])
    translate([starter_pipe_d_middle/2-End_Wall_Thickness/2, 0, Total_w_mezikus])
    cylinder(h = 2, d = 3, $fn = 20);
    
    rotate([0, 0, 180+35])
    translate([starter_pipe_d_middle/2-End_Wall_Thickness/2, 0, Total_w_mezikus])
    cylinder(h = 2, d = 3, $fn = 20);
    
    /*      // Partitions between holes for sensors of rotation speed measurement
    Number_of_holes2 = 26;                
    translate([0, 0, Total_w_mezikus-Depth_Groove_Sensors/2])  
    for (i = [1:Number_of_holes2]){
    rotate([0, 0, i*360/Number_of_holes2])
    translate([starter_pipe_d_middle/2-End_Wall_Thickness/2+7.7, 0, 0])
    cube([8.6, 0.8  ,  Depth_Groove_Sensors], center = true);
    }
    
    */
}

difference(){
    union(){
        888_4008(draft=true);

        translate([0, 0, starter_bottom_h+Ribbon_width+rpm_sensor_h - 3.4 + 20])
       # Mezikus(draft=true);
    
    }
 // cross section for model construction
//    rotate([0,0,50]) translate([-100,0,-50])cube(200);
    
}