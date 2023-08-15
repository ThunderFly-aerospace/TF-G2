//Spodni cast pylonu
include <../parameters.scad>
use <lib/stdlib/silentblock.scad>

pylon_bottom_wall = 5;

//
//  TODO! Tyto parametry pochazi z 888_1023, nacitat je odtud

gps = 1;            // Vytvorit prostor pro GPS pod pylonem
gps_rtk = 0;        // 1 nebo 0 - pocet odkrytych LEDek
gps_pcb_width = 51;
gps_screw_dist = 40;

gps_conn_height = 6;
gps_pcb_height = 1.6;
gps_patch_height = 4.5;

rantl = 0.5;
rantl_height = 2;
screw_column = 4.3;

module 888_1023(){

    box_height = 0.8+gps_conn_height+gps_pcb_height+gps_patch_height;
    box_width = gps_pcb_width+0.5+2;

    difference(){
        union(){
            translate([0, 0, rantl_height/2])
                cube([box_width+rantl*2+0.5, box_width+rantl*2+0.5, rantl_height], center=true);
        }
        
        translate([0, 0, box_height/2+0.4])
            cube([box_width+rantl*2, box_width+rantl*2, box_height], center=true);
        translate([0, 0, box_height/2-0.1])
            cube([36, 46, box_height], center=true);
            
    for(x=[0.5, -0.5], y=[0.5, -0.5])translate([40*x, 40*y, 0]) difference(){
     //       cylinder(d=7, h=screw_column, $fn=30);
            cylinder(d=2.5, h=screw_column+0.1, $fn=30);
    }
    }
    
    for(x=[0.5, -0.5], y=[0.5, -0.5])translate([40*x, 40*y, 0]) difference(){
            cylinder(d=5, h=screw_column+0.4, $fn=30);
            cylinder(d=2.5, h=screw_column+0.4+0.1, $fn=30);
    }
}



888_1023();
