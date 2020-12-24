//@set_slicing_config(slicing/default.ini)
//Spodni cast pylonu

include <../parameters.scad>
use <lib/stdlib/silentblock.scad>

pylon_bottom_wall = 5;

module pylon_silentblocks(){
for(x = [-0.5, 0.5], y=[-0.5, 0.5])
  translate([(pylon_silentblocks_base_distance)*x, (pylon_silentblocks_base_distance)*y, 4])
    silentblock(do=8, l=8, dt=3, l1=6, l2=-3);
}
pylon_silentblocks();



pylon_silentblocks_base_distance = 58;


module 888_1007(){

    difference(){

        minkowski(){
          cube([base_width-3, base_width-3, 10-1], center = true);
          cylinder(d = 3, h=1, $fn=15);
        }

        minkowski(){
          difference(){
            cube([base_width - pylon_bottom_wall*2 - 6,
                base_width - pylon_bottom_wall*2 - 6, 11], center = true);

            for(x = [-0.5, 0.5], y=[-0.5, 0.5])
              translate([(pylon_silentblocks_base_distance)*x, (pylon_silentblocks_base_distance)*y, 0])
                cylinder(d = 20, h = 20, center=true);
            }
            cylinder(d=6.3, h=1, $fn=20);
        }

        for(x = [-0.5, 0.5], y=[-0.5, 0.5])
          translate([(pylon_silentblocks_base_distance)*x, (pylon_silentblocks_base_distance)*y, 0]){
            cylinder(d = 10, h = 20);
            translate([0, 0, -5-0.1]) cylinder(d = M3_nut_diameter, h = 2.5, $fn=6);
            translate([0, 0, -5+2.5+0.1]) cylinder(d = M3_screw_diameter, h = 10, $fn=15);
          }


        //pylon_pipes(pylon_pipe_d, 10, 0);

        for(x = [-10, 0, 10, -20, 20])
            translate([x, 0, 0])
                rotate([90, 0, 0]){
                    cylinder(d = M3_screw_diameter, h = base_width+1, center=true, $fn = 12);
                    cylinder(d = M3_nut_diameter, h = base_width-4*2, center=true, $fn = 6);
                }
    }
}


//%pylon_pipes();
888_1007();
