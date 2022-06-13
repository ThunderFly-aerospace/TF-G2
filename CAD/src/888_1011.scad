//// ThunderFly - Rotor Head - Part 2

include <../parameters.scad>
use <888_1010.scad>

length = 888_1010_rotor_head_width()-2*0.5-0.15; // Length of the part
axis_diameter = M3_screw_diameter;
space = 2; // Axis hole distance
wall = 1;

roll_w=6;
roll_d=10;

hrazda_ww=15;
hrazda_a=1;
hrazda_w=hrazda_ww+hrazda_a;
hrazda_h=15;
hrazda_tw=3;

hrazda_angle=40;



add = hrazda_w+0.5+10; // prodlouzeni osy ve smeru roll osy

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
            #translate([0, axis_diameter + space, axis_diameter + 2*wall + add-hrazda_ww])
               cylinder(d = axis_diameter + 5*wall, h = hrazda_ww, $fn=25);
               
            translate([0, axis_diameter + space+hrazda_h, axis_diameter + 2*wall + add-roll_d/2])             
                rotate([0,90+hrazda_angle,0])
                    cylinder(d=roll_d,h=roll_w+hrazda_tw*2, $fn=100,center=true);               
            
        }
               
        }
        
    //vyýbrus hrazdy
    translate([0, axis_diameter + space+hrazda_h, axis_diameter + 2*wall + add-roll_d/2])
        rotate([0,90+hrazda_angle,0])
        {
            hull()
            rotate_extrude(convexity = 10,$fn = 100)
                translate([(roll_d+3)/2+1, 0, 0])
                    circle(r = (roll_w+0.5)/2, $fn = 100);            
        }
    
    //osička hrazdy
    translate([0, axis_diameter + space+hrazda_h, axis_diameter + 2*wall + add-roll_d/2])
        rotate([0,90+hrazda_angle,0])
            cylinder(d = M3_screw_diameter, h = roll_w+hrazda_tw*2+1, $fn=100,center=true);
    
    //matička hrazdy
    for(i=[-1,1])
    translate([0, axis_diameter + space+hrazda_h, axis_diameter + 2*wall + add-roll_d/2])
        rotate([0,hrazda_angle,0])
        translate([i*(roll_w/2+hrazda_tw+M3_nut_height/2-1),0,0])
        rotate([0,90,0])
            cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn=6,center=true);
    
    
        

    //matička roll
    translate([0, axis_diameter + space, axis_diameter + 2*wall+10 - M3_nut_height*1.5])
        cylinder(d = M3_nut_diameter, h = 10+add, $fn=6);
    
    //roll
    translate([0, axis_diameter + space, -0.2])
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

module 888_1011_roll()
{    
        difference()
        {
        translate([0,0,0])
            cylinder(r=roll_d/2,h=roll_w,center=true,$fn = 100);
        rotate_extrude(convexity = 10,$fn = 100)
            translate([roll_d/2, 0, 0])
                circle(r = roll_d/2-2.5, $fn = 100);

        cylinder(d=3.5,h=roll_w+1,center=true,$fn=50);
            
        }
}


//intersection()
{
union()
{
    888_1011();
    echo(axis_diameter + space+hrazda_h, axis_diameter + 2*wall + add-roll_d/2-wall-axis_diameter/2);
    translate([0, axis_diameter + space+hrazda_h, axis_diameter + 2*wall + add-roll_d/2-wall-axis_diameter/2])
        rotate([0,90+hrazda_angle,0])
            888_1011_roll();
}
//cube([50,50,50]);
}



