// Drzak virniku na TFAEROSCALE (1. dil ze dvou)
include <../parameters.scad>

tfmotorscale_height = 80;
tfmotorscale_holder_thickness = 5;
tfmotorscale_holder_width = 20;

lock_axis_diameter = 8; // prumer osy do zamku

module 888_9002(){
    translate([0, -base_width/2, 0])
        difference(){
            translate([0, -tfmotorscale_holder_thickness-5, 0])
                cube([tfmotorscale_holder_width, base_width+10+tfmotorscale_holder_thickness*2, tfmotorscale_height+tfmotorscale_holder_thickness+lock_axis_diameter*2]);
            translate([-1, 2.5-5, 2.5+tfmotorscale_holder_thickness])
                minkowski(){
                    cube([tfmotorscale_holder_width, base_width+10-5, tfmotorscale_height+tfmotorscale_holder_thickness+lock_axis_diameter*2-5]);
                    rotate([0, 90, 0]) cylinder(d=5, h=2, $fn=20);
                }
        }

}


888_9002();
