//// Protective circle for laser sensors

include <../parameters.scad>
include <lib/stdlib/polyScrewThread_r1.scad>

use <888_4045.scad>;


H_protect = 1;  // Výška senzoru je 0.8 mm


/// Parameters from different models
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
   
    Ribbon_width = 6;
    Ribbon_part_w = height_from_rotor_nut- (16.5 - 1.65) + Ribbon_width; // Auxiliary variable
    Bwall = 1.6; // wall around bearing
    End_Wall_Thickness = 5;
    D_mezikus = starter_pipe_d_middle+0.2-End_Wall_Thickness*2+34;
    
    Tloustka_placky = 0.4;
    
Pin_length_disc = 5.4;
Pin_slot_width = 1.55;
Pin_D_disc = 5;
Pin_D_cylinder = 4;
pcb_inner_diameter = bearing_outer_diameter + Bwall*2+2.7;
echo("PCB INNER DIAMETER", pcb_inner_diameter);

module Protective_cylinder(draft = true){
    difference(){
        cylinder(h=H_protect, d=D_mezikus+2, $fn = draft?16:120);
        
         translate([0,0,Tloustka_placky]) cylinder(h=H_protect, d=D_mezikus, $fn = draft?16:120);
      
      //  Central hole  
        translate([0,0,-5])
       cylinder(h=sensor_cap_height*0.7+Ribbon_part_w+0.25, d = bearing_outer_diameter + Bwall*2+2.7, $fn = draft?16:120);
        
         // Holes for self-cutting screws
         PosunZsl = 7.0;
        PosunYsl = 13.9;
        PrumerDirySloupek = 4.15;
       rotate([0, 0, 90])  {
        translate([PosunYsl, PosunZsl, 0])
     cylinder(d1 = PrumerDirySloupek,d2 = PrumerDirySloupek+0.5, h = Tloustka_placky, $fn = 20);

           translate([-PosunYsl, PosunZsl, 0])
     cylinder(d1 = PrumerDirySloupek,d2 = PrumerDirySloupek+0.5, h = Tloustka_placky, $fn = 20);

     translate([0, 22.6, 0])
        cylinder(d1 = PrumerDirySloupek,d2 = PrumerDirySloupek+0.5, h = Tloustka_placky, $fn = 20);
       }
       
       // Holes for sensors
        Zero_dist = starter_pipe_d_middle/2-End_Wall_Thickness/2+4.7 +1;  // Distance of zero position sensor from the center
    RotSpeed_dist = starter_pipe_d_middle/2-End_Wall_Thickness/2+9.7 +1;  // Distance of rotation speed sensor from the center
    Zero_angle = 20; // Angle of zero position sensor from y axis
       R = RotSpeed_dist;
       tfprobe_lenght = 14;
    tfprobe_width = 10;
    tfprobe_thickness = 1.5; // Not sure

       rotate(180+52)
         translate([R-1.94,-tfprobe_width/2+2.05,-0.1]){
       translate([1.94-1,3.05-1,-0.1])
          minkowski(){
            cube([2,2,1.7]);
              cylinder(h = 7, r = 1, $fn = draft?5:30);
        }
         }
         rotate(-90+20)
         translate([Zero_dist-1.94,-tfprobe_width/2+2.05,-0.1]){
       translate([1.94-1,3.05-1,-0.1])
          minkowski(){
            cube([2,2,1.7]);
             cylinder(h = 7, r = 1,$fn = draft?5:30);
        }
         }
    
    // Hole for pin to bearings
    rotate([0, 0, 180])
        translate([pcb_inner_diameter/2,0,-5])
            minkowski(){
                union(){
                    translate([-1, -Pin_slot_width/2, 0])
                        cube([1+ Pin_length_disc, Pin_slot_width, 10]);
                    translate([Pin_length_disc-1, 0, 0])
                        hull(){
                            translate([0, 1, 0])
                                cylinder(d=2.1, h=10, $fn=20);
                            translate([0, -1, 0])
                                cylinder(d=2.1, h=10, $fn=20);
                        }
                    //translate([-Pin_length_disc/2+0.8,0,0])
                    //    cube([2,Pin_D_disc - 2,10]);
                  }
                R_zaobleni = 1;
                cylinder(r=R_zaobleni, h= 5, $fn = draft?5:30);
                    
        }     
         
         
         
        }
    
    }




Protective_cylinder(draft = false);



//translate([0,0,-1.6])   mill_static(draft = true);

