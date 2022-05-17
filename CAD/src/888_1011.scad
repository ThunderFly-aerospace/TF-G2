//// ThunderFly - Rotor Head - Part 2

include <../parameters.scad>
use <888_1010.scad>

length = 888_1010_rotor_head_width()-2*0.5-0.15-0.55*2; // Length of the part
axis_diameter = M3_screw_diameter;
space = 2; // Axis hole distance
wall = 1;

hrazda_w=10;
hrazda_h=10;
hrazda_t=3;
hrazda_tw=10;

add = hrazda_w+0.5+8; // prodlouzeni osy ve smeru roll osy

$fn = 100;

module 888_1011(){
  translate([0, 0, -wall-axis_diameter/2])
    difference(){
    union(){
        hull(){
            translate([-length/2, -(axis_diameter + 2*wall)/2, 0])
                cube([length, axis_diameter + 2*wall, axis_diameter + 2*wall]);
            translate([0, axis_diameter + space, 0])
                cylinder(d = axis_diameter + 5*wall, h = axis_diameter + 2*wall + add, $fn=25);
        }
        
        //noha hrazdy
        hull(){
            translate([0, axis_diameter + space, axis_diameter + 2*wall + add-hrazda_w])
               cylinder(d = axis_diameter + 5*wall, h = hrazda_w, $fn=25);
               
            translate([hrazda_tw/2-hrazda_t/2, axis_diameter + space+hrazda_h, axis_diameter + 2*wall + add-hrazda_t/2])
                sphere(hrazda_t/2,$fn = 100);
            translate([-(hrazda_tw/2-hrazda_t/2), axis_diameter + space+hrazda_h, axis_diameter + 2*wall + add-hrazda_t/2])
                sphere(hrazda_t/2,$fn = 100);                
        }
        //vršek hrazdy
        hull(){
            translate([hrazda_tw/2-hrazda_t/2, axis_diameter + space+hrazda_h, axis_diameter + 2*wall + add-hrazda_t/2])
                sphere(hrazda_t/2,$fn = 100);
            translate([-(hrazda_tw/2-hrazda_t/2), axis_diameter + space+hrazda_h, axis_diameter + 2*wall + add-hrazda_t/2])
                sphere(hrazda_t/2,$fn = 100);
              
            translate([hrazda_tw/2-hrazda_t/2, axis_diameter + space+hrazda_h+hrazda_tw/2, axis_diameter + 2*wall + add-hrazda_t/2])
                sphere(hrazda_t/2,$fn = 100);
            translate([-(hrazda_tw/2-hrazda_t/2), axis_diameter + space+hrazda_h+hrazda_tw/2, axis_diameter + 2*wall + add-hrazda_t/2])
                sphere(hrazda_t/2,$fn = 100);   
        }
        
        
        }
        
    //vyýbrus hrazdy
    translate([0, axis_diameter + space+hrazda_h+hrazda_tw/2, axis_diameter + 2*wall + add-hrazda_t/2])
        difference()
        {
        translate([0,0,0])
            cylinder(r=(hrazda_tw-hrazda_t)/2,h=hrazda_t+2,center=true);
        rotate_extrude(convexity = 10,$fn = 100)
            translate([hrazda_tw/2-hrazda_t/2, 0, 0])
                circle(r = hrazda_t/2, $fn = 100);                
            
        }
        

    translate([0, axis_diameter + space, axis_diameter + 2*wall + add - M3_nut_height*1.5])
        cylinder(d = M3_nut_diameter, h = 10, $fn=6);
    
    //roll
    translate([0, axis_diameter + space, -0.1])
         cylinder(d = axis_diameter, h = axis_diameter + 2*wall + add - M3_nut_height*1.5, $fn=25);
         
    translate([0, axis_diameter + space, axis_diameter + 2*wall + add - M3_nut_height*1.5])
         cylinder(d = axis_diameter, h = 100, $fn=25);
    
    //pitch
    rotate([0, 90, 0])
        translate([-(axis_diameter + 2*wall)/2, 0, -50])
            cylinder(h = 100, d = axis_diameter, $fn=25);
    }

    //rotate([0, 90, 0]) if($preview) $cylinder(d = M3_screw_diameter, h = 35, center = true);

 translate([0, 5.2, -9.5]) rotate([0, 0, rotor_head_roll]) rotate([0, 180, 0]) rotate([0, 0, 90]) children(0);
}


888_1011();

