include <../parameters.scad>
include <lib/stdlib/polyScrewThread_r1.scad>

use <888_4008.scad>;


//  angle_between_blades = 360 / rotor_blades_count;

//    thickness = 2.3;
    top_thickness = 3;

    height_from_rotor_nut = 11.5 - 1.65 ;

//    starter_top_r=14;
    starter_top_h=M3_screw_head_height+3;
//    starter_pipe_d_top = 20;
    starter_pipe_d_middle = 27;
//    starter_pipe_d_bottom = 20;
//    starter_neck_r=10;
    starter_neck_h=1;
    starter_bottom_h=5;
    starter_rope_diameter=2;

    starter_rope_d = 27.0;

    sensor_cap_height=starter_top_h+starter_neck_h+starter_bottom_h;

    rpm_sensor_h = height_from_rotor_nut - starter_top_h;
    rpm_sensor_count=16;
    rpm_hole_h = 50;
   rpm_hole_width = 7;
   rpm_sensor_base_h= 2;

//    screws_head_d=7;
//    screws_h=14;
    
    Ribbon_width = 6;
    Ribbon_part_w = height_from_rotor_nut- (16.5 - 1.65) + Ribbon_width; // Auxiliary variable
    
    H_mill_disc = 1.6;
    D_mill_disc = 80;
    
    // Inner clif of 888_4008
       End_Wall_Thickness = 5;     
       Bwall = 1.6; // wall around bearing
    
             // Holes for self-cutting screws
       Self_screw_diameter = 2; 
       Depth_self_screw = 30;
       Number_of_holes = 4;
       
       D_mezikus = starter_pipe_d_middle+0.2-End_Wall_Thickness*2+34;
       
  

module mill_rot(draft = true){
    
    difference(){
    
    cylinder(h=H_mill_disc, d=D_mill_disc, $fn = draft?16:120);
        
        
       //  Central hole
             translate([0,0,-5])
       cylinder(h=sensor_cap_height*0.7+Ribbon_part_w+0.25, d = bearing_outer_diameter + Bwall*2+2.7, $fn = draft?16:120);   
        
      // Holes for self-cutting screws  - ENLARGED
       for (i = [1:Number_of_holes]){
          rotate([0, 0, i*360/Number_of_holes])
          translate([starter_pipe_d_middle/2-End_Wall_Thickness/2, 0, top_thickness + M3_nut_height + sensor_cap_height/2+Ribbon_width/2+0.15])
              cylinder(h = Depth_self_screw, d = Self_screw_diameter + 0.5, center = true, $fn=20);                                 }
                    
           Number_of_holes2 = 24;                
         // Holes for rotation speed measurement
      for (i = [1:Number_of_holes2]){
            R = starter_pipe_d_middle/2-End_Wall_Thickness/2+9.7;  // Vzdálenost bližších kruhů od středu  
            r = 1;
            vzd = 2*PI*R/48/2;
            s = 2;  // Vzdálenost děr stadionu
              
          rotate([0, 0, i*360/Number_of_holes2+360/Number_of_holes2/2])
            hull(){
                translate([R, -(vzd - r), -5])
              cylinder(h = Depth_self_screw, d = 2*r, center = true, $fn=20);
                translate([R, vzd - r, -5])
              cylinder(h = Depth_self_screw, d = 2*r, center = true, $fn=20);
                translate([R+s, -((vzd+s*vzd/(R-s))-r), -5])
              cylinder(h = Depth_self_screw, d = 2*r, center = true, $fn=20); 
                translate([R+s, ((vzd+s*vzd/(R-s))-r), -5])
              cylinder(h = Depth_self_screw, d = 2*r, center = true, $fn=20);   
                    }
                          } 
                                         
                            
            Number_of_holes3 = 2;                
         // Holes for zero postition sensor                            
      for (i = [1:Number_of_holes3]){
              R = starter_pipe_d_middle/2-End_Wall_Thickness/2+4.7;  // Vzdálenost bližších kruhů od středu
              r = 1;
              vzd = 2*PI*R/48/2;
              s = 2;  // Vzdálenost děr stadionu
              
          rotate([0, 0, i*360/Number_of_holes3+90])
            hull(){
                translate([R, -(vzd - r), -5])
              cylinder(h = Depth_self_screw, d = 2*r, center = true, $fn=20);
                translate([R, vzd - r, -5])
              cylinder(h = Depth_self_screw, d = 2*r, center = true, $fn=20);
                translate([R+s, -((vzd+s*vzd/(R-s))-r), -5])
              cylinder(h = Depth_self_screw, d = 2*r, center = true, $fn=20); 
                translate([R+s, ((vzd+s*vzd/(R-s))-r), -5])
              cylinder(h = Depth_self_screw, d = 2*r, center = true, $fn=20);   
                    }
                            } 
    /*                         
        // Otvory pro senzor
            Sirka_otvoru = 2;  // Šířka otvoru pro senzor ve směru od středu disku                
              translate([0,0,-2])
                intersection() {
                    difference(){
                    union(){  // sensor teeth outer rim
                      cylinder(d = starter_pipe_d_middle-5, h = rpm_hole_h/4, $fn = draft?rpm_sensor_count:120);
                      translate([0, 0, - M3_nut_height - sensor_cap_height + rpm_sensor_h + starter_top_h - starter_rope_diameter])
                        cylinder(d1 = starter_pipe_d_middle, d2 = starter_rope_d - starter_rope_diameter/2, h = starter_rope_diameter, $fn = draft?rpm_sensor_count:120);
                    }
                cylinder(d = bearing_outer_diameter + Bwall*2+11.7-Sirka_otvoru*2, h = rpm_hole_h/4);    
                    }

                    for (i=[0:rpm_sensor_count]) rotate([0, 0, (360/rpm_sensor_count)*i + (360/rpm_sensor_count)/2]){
                        linear_extrude(height = rpm_hole_h)
                        polygon(points=[[0,0],[starter_rope_d/2, ((starter_rope_d/2) * sin(360/rpm_sensor_count/2))/2], [starter_rope_d/2, -((starter_rope_d/2) * sin(360/rpm_sensor_count/2))/2]]);
                    }
                    cylinder(h=sensor_cap_height*0.7+Ribbon_part_w+0.25, d = starter_pipe_d_middle+0.2-End_Wall_Thickness*2);
                }
                */ 
                
            // Mill butterfly
 Mill_Butterfly_count = 2;
              translate([0,0,-2])
              minkowski(){
                intersection() {
                    
                    difference(){
                    union(){  // sensor teeth outer rim
                      cylinder(d = D_mill_disc-8, h = rpm_hole_h/4, $fn = draft?16:120);
                      translate([0, 0, - M3_nut_height - sensor_cap_height + rpm_sensor_h + starter_top_h - starter_rope_diameter])
                        cylinder(d1 = starter_pipe_d_middle, d2 = starter_rope_d - starter_rope_diameter/2, h = starter_rope_diameter, $fn = draft?16:120);
                    }
                    cylinder(d = D_mezikus+2*R_zaobleni, h = rpm_hole_h/4, $fn = draft?16:120);
                    }

                    for (i=[0:Mill_Butterfly_count]) rotate([0, 0, (360/Mill_Butterfly_count)*i + (360/Mill_Butterfly_count)/2]){
                        linear_extrude(height = rpm_hole_h)
                        polygon(points=[[0,0],[(D_mill_disc)/2, (((D_mill_disc)/2) * sin(360/Mill_Butterfly_count/2)- R_zaobleni)/1 ], [D_mill_disc/2, -(((D_mill_disc)/2) * sin(360/Mill_Butterfly_count/2)-R_zaobleni)/1]]);
                    }
                    
                    
                }
             R_zaobleni = 2;   
              cylinder(r=R_zaobleni, h= 20, , $fn = 30);
                } 
            }
    }
    
///////  
///////   
///////    
module mill_static(draft = true){
    difference(){
    
    cylinder(h=H_mill_disc, d=D_mill_disc, $fn = draft?16:120);
        
        
       //  Central hole
             translate([0,0,-5])
       cylinder(h=sensor_cap_height*0.7+Ribbon_part_w+0.25, d = bearing_outer_diameter + Bwall*2+2.7, $fn = draft?16:120);   
        
      // Holes for self-cutting screws
         PosunZsl = 7.0;
        PosunYsl = 13.9;
        PrumerDirySloupek = 1.5 + 1;
        
        translate([PosunYsl, PosunZsl, -2])
     cylinder(d = PrumerDirySloupek, h = 20, $fn = 20);   
        
           translate([-PosunYsl, PosunZsl, -2])
     cylinder(d = PrumerDirySloupek, h = 20, $fn = 20);
     
     translate([0, 22.6, -2])   
        cylinder(d = PrumerDirySloupek, h = 20, $fn = 20);
     } 
  }  

mill_rot();

//translate([0,0,H_mill_disc+2 ])   mill_static();
  
//translate([0, 0, -6]) Mezikus(draft=true);
 

    

