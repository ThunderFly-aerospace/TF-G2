//// ThunderFly - Rotor Head - Vicko na TFASPDIMU

/// Main parameters

include <../parameters.scad>
use <./lib/TFSLOT01/CAD/src/tfslot_888_1001.scad>
use <888_1010.scad>

$fn = 100;


pcb_width = 15;
pcb_offset = 0;
pcb_length = 36;
pcb_sensor_from_top = 5;
pcb_thickness = 3.5;
pcb_thickness_sensor = 3.4;
pcb_thickness_conn = 6;



module 888_1013(draft = true){
    difference() {
       translate([12, 0, 0]) rotate([180, 0, 180]) tfslot_888_1002();


       //#TODO ... tohle vice zparametrizovat
        for(m = [1, 0]) mirror([0, m, 0]) {
            translate([-10 - 0.5, 14.3, 0]) translate([0, 0, 0]) cube([11, 2.7, 100]);
            translate([-30 - 0.5, 15.3, 0]) translate([0, 0, 0]) cube([30, 1.7, 100]);
        }
        
    }
}

module 888_1013_support(){

    #translate([12, 0, 0]) rotate([180, 0, 180]) tfslot_888_1002_support();
}

888_1013(draft=$preview);
888_1013_support();

//888_1010();