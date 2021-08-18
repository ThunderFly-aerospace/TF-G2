include <../parameters.scad>



// Krabicka na PCB

pcb_width = 15;
pcb_offset = 0;
pcb_length = 36;
pcb_sensor_from_top = 5;
pcb_thickness = 3.5;
pcb_thickness_sensor = 3.4;
pcb_thickness_conn = 6;

module 888_1014() {
    difference() {
        cube([10, pcb_width+12, 2]);
        
        translate([5, 3, -1])
        cylinder(d=3, h=4, $fn=30);
        
        translate([5, pcb_width+12-3, -1])
        cylinder(d=3, h=4, $fn=30);
    }
}

888_1014();