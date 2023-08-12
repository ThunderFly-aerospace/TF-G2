//Spodni cast pylonu
include <../parameters.scad>
use <lib/stdlib/silentblock.scad>

pylon_bottom_wall = 5;


gps = 1;            // Vytvorit prostor pro GPS pod pylonem
gps_rtk = 0;        // 1 nebo 0 - pocet odkrytych LEDek
gps_pcb_width = 51;
gps_screw_dist = 40;


module pylon_silentblocks(){
for(x = [-0.5, 0.5], y=[-0.5, 0.5])
  translate([(pylon_silentblocks_base_distance)*x, (pylon_silentblocks_base_distance)*y, 4])
    silentblock(do=8, l=8, dt=3, l1=5, l2=5);
}
//pylon_silentblocks();


module 888_1007(){

 translate([base_width/2, 0, 1]) rotate([0, -90, 180]) linear_extrude(1) text(">", halign="center", valign="center", size=5);
 translate([-base_width/2-0.5, 0, 1]) rotate([90, 0, 90]) linear_extrude(1) text(week, halign="center", valign="center", size=5);

    difference(){

        minkowski(){
          cube([base_width-11, base_width-11, 6-1], center = true);
          union(){
              cylinder(d1=9, d2 = 11, h=1, $fn=25);
              translate([0, 0, 1]) cylinder(d2=9, d1 = 11, h=1, $fn=25);
          }
        }

        minkowski(){
          difference(){
            cube([base_width - pylon_bottom_wall*2 - 5,
                base_width - pylon_bottom_wall*2 - 7, 11], center = true);

            for(x = [-0.5, 0.5], y=[-0.5, 0.5])
              translate([(pylon_silentblocks_base_distance)*x, (pylon_silentblocks_base_distance)*y, 0])
                cylinder(d = 20, h = 20, center=true);
            }
            cylinder(d=6.3, h=1, $fn=25);
        }

        for(x = [-0.5, 0.5], y=[-0.5, 0.5])
          translate([(pylon_silentblocks_base_distance)*x, (pylon_silentblocks_base_distance)*y, 0]){
            cylinder(d = 10, h = 20, $fn=25);
            //translate([0, 0, -5-0.1]) cylinder(d = M3_nut_diameter, h = 2.5, $fn=6);
            translate([0, 0, -5+2.5+0.1-5]) cylinder(d = M3_screw_diameter, h = 10, $fn=15);
          }


        for(x = [0,-20, 20])
            translate([x, 0, 1])
                rotate([90, 0, 0])
                    cylinder(d = plastic_screw_diameter, h = base_width+1, center=true, $fn = 24);

    }
    
    difference(){
        union(){
        for(r=[-1, 1]) translate([0, 0, -1.5]) rotate([0, 0 ,r*45]) {
            cube([sqrt(pylon_silentblocks_base_distance*pylon_silentblocks_base_distance*2)-10, 3, 2], center=true);
            for(x=[-1, 1]) translate([x*sqrt(20*20*2), 0, 0]) cylinder(d=7, h=2, center=true, $fn=30);
            }
        translate([0, 0, -2.1]) cube([55, 55, 0.8], center=true);
        
        translate([0, 0, -1.5]) cube([7, 7, 1], center=true);
        }
        
        //  Montazni otvory pro GPS krabicku
        for(r=[-1, 1]) translate([0, 0, -1]) rotate([0, 0 ,r*45]) {
            for(x=[-1, 1]) translate([x*sqrt(20*20*2), 0, 0]) cylinder(d=2.6, h=5, center=true, $fn=30);
        }
            
           
        // Otvory na LEDky 
        translate([0, 0, -1]) {
            for(x=[0:gps_rtk?3:1]) translate([-20+7.27+3.746*x, 20+0.84, 0]) cylinder(d=3, h=3, center=true, $fn=30);
            }
        translate([0, 0, -1]) {
            translate([-20+16.845, -20-1.475, 0]) cylinder(d=3, h=3, center=true, $fn=30);
            }
    }
}


//%pylon_pipes();
888_1007();
