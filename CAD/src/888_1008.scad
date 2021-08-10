//@set_slicing_config(slicing/default.ini)
//Spodni cast pylonu

include <../parameters.scad>
include <lib/Round-Anything/polyround.scad>
use <lib/Round-Anything/roundAnythingExamples.scad>

use<888_1007.scad>


module 888_1008(){

    difference(){
        
        translate([0, 0, -8/2])
            union(){
                minkowski(){
                    translate([0, 0, -2]) cylinder(d = 45, h=8-2-4, $fn=8, center = true);
                    cylinder(d=8, h=2, $fn=20, center=true);
                }

                // sloupky pro hlubsi zapusteni tyckys
                for(x=[-0.5, 0.5], y=[-0.5, 0.5])
                        translate([x*30, y*30, 0])
                            cylinder(d=10, h=8-2, center = true);
            }

        // Odecet vnitrni casti    
        minkowski(){
            difference(){
                cylinder(d=30, h=15, $fn=8, center=true);
                for(r=[1,2,3,4])
                    rotate([0, 0, 45+r*90])
                        translate([20, 0, 0])
                            cylinder(d=16, h=15, center=true);
            }
            cylinder(d = 8, h=2, $fn=20, center=true);
        }

        
        // srouby pro pripevneni trhaci podlozky
        for(r=[1, 2, 3, 4])
            rotate([0, 0, r*90])
                translate([45/2, 0, -8]){
                    translate([0, 0, -0.1]) rotate([0, 0, 30]) cylinder(d = M3_nut_diameter, h = M3_nut_height*0.7, $fn =6);
                    translate([0, 0, M3_nut_height*0.7+0.2]) cylinder(d = M3_screw_diameter, h = 10);
                }

        translate([0, 0, -pylon_suspension_height])
            pylon_pipes(pylon_pipe_d, 0, -2.5);
    }


}


%translate([0, 0, -pylon_suspension_height]){
    888_1007();
    pylon_pipes(pylon_pipe_d, 0, -2);
    pylon_silentblocks();
}
888_1008();


// translate([-10, 80, pylon_thickness + 10])
//    rotate([-90, 0, 0])
        //888_5002();

