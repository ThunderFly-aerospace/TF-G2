//// ThunderFly - Rotor Head - motor_holder

/// Main parameters

include <../parameters.scad>
$fn = 100;

space = 1; // parametr z dilu 1002, rika tloustku steny

rotor_shaft_angle = 10;

rod_size = 8; // delka hrany sloupku
Bwall = 1.6; // wall around bearing

BaseThickness = 0;
BaseBoldDiameter = M3_screw_diameter;
BaseBoldHeadDiameter = M3_nut_diameter + 0.5;
BaseBoldHeadHeight = M3_nut_height;

bearing_inner_diameter = 7;

// nastaveni delek tahel
rod_x_dist = 30;

rod_y_distance = rod_x_dist*2 - 3*2; // 3 je delka kuloveho cepu
rod_x_distance = rod_x_dist - rod_size/2 - BaseThickness - M3_screw_diameter/2 - space;

TFPROBE01_PCB_thickness = 1.8;
TFPROBE01_PCB_width = 10.2;
TFPROBE01_sensor_height = 0.9;

starter_rope_diameter=4;
starter_rope_d = 39.2;


prerotator_outer_diameter = 45;
prerotator_thickness = 35;
prerotator_shaft_rantl_diameter = 16.5;
prerotator_shaft_diameter = 4;
prerotator_mount_holes_diameter = 2;
prerotator_mount_holes_distance = 22/2; // polomer kruznice, na ktere lezi 3 diry

prerotator_holder_width = 30;
prerotator_holder_height = 35;


module 888_1015(draft = true){

    difference(){
    union(){
        translate([-30, -prerotator_holder_width/2, -prerotator_holder_height+5]) cube([60, prerotator_holder_width, prerotator_holder_height]);
    }
    union(){
    translate([0, 0, -prerotator_thickness]) cylinder(d = prerotator_outer_diameter+5, h = prerotator_thickness);
    cylinder(d = prerotator_shaft_rantl_diameter, h =3);
    cylinder(d = prerotator_shaft_diameter+1, h =20);
    
    for(r = [0, 120, 240])
        rotate(r+30)
            translate([prerotator_mount_holes_distance, 0, 0])
                cylinder(d = 2, h = 10);
    }
}
}

888_1015(draft=true);
