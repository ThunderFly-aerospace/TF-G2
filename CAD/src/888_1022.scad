//Spodni cast pylonu
include <../parameters.scad>
use <lib/stdlib/silentblock.scad>

pylon_bottom_wall = 5;


gps = 1;            // Vytvorit prostor pro GPS pod pylonem
gps_rtk = 0;        // 1 nebo 0 - pocet odkrytych LEDek
gps_pcb_width = 51;
gps_screw_dist = 40;

gps_conn_height = 6;
gps_pcb_height = 1.6;
gps_patch_height = 4.5;

module 888_1022(){

    box_height = 0.8+gps_conn_height+gps_pcb_height+gps_patch_height;
    box_width = gps_pcb_width+0.5+2;
    
    difference(){
        union(){
        
        translate([0, 0, box_height/2]) cube([box_width, box_width, box_height], center=true);
        
        }
        
        // Zkoseni 
        for(m=[-1, 1]) translate([0, box_width/2*m, 0]) rotate([45, 0, 0]) cube([60, 1, 1], center=true);
        for(m=[-1, 1]) translate([box_width/2*m, 0, 0]) rotate([0, 45, 0]) cube([1, 60, 1], center=true);
        for(x=[-1, 1], y=[-1, 1]) translate([box_width/2*x, box_width/2*y, 0]) rotate([0, 0, 45]) cube([1, 1, 30], center=true);
        
        translate([0, 0, box_height/2+0.8]) cube([gps_pcb_width+0.5, gps_pcb_width+0.5, box_height], center=true);
        
        for(r=[-1, 1]) translate([0, 0, -1]) rotate([0, 0 ,r*45]) {
            for(x=[-1, 1]) translate([x*sqrt(20*20*2), 0, 0]) cylinder(d=M3_screw_diameter, h=30, center=true, $fn=30);
            }
            
            
            // Konektory 
            
            
            translate([-25, -10.854, 0.8+6/2]) cube([10, 9.44+0.5, 6], center=true);
            translate([-25, 6.885, 0.8+6/2]) cube([10, 16.96+0.5, 6], center=true);
            translate([25, -8.229, 0.8+6/2]) cube([10, 11.96+0.5, 6], center=true);
            translate([25, 7.646, 0.8+6/2]) cube([10, 14.4+0.5, 6], center=true);
    }
    
    for(m=[-1, 1]) translate([(box_width/2-2.2)*m, 0, 1]) cube([4, box_width-1, 1], center=true);
        
    
    
    for(x=[-20, 20], y=[-20, 20]) translate([x, y, 0]) difference() {
        union(){
            cylinder(d1=7, d2=5, h=2, $fn=20);
            cylinder(d=5, h=0.8+gps_conn_height, $fn=20);
        }
        //cylinder(d=5, h=0.8+gps_conn_height-1);
        translate([0, 0, 1]) cylinder(d=2.2, h=0.8+gps_conn_height+1, $fn=30);
    }
}


//%pylon_pipes();
888_1022();
