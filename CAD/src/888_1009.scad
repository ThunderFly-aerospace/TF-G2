
include <../parameters.scad>
use <888_1007.scad>
use <888_1010.scad>


servo_width = 10.5;
servo_length = 24;
servo_length_flange = 33;
servo_screw_distance = 28;
servo_height = 20;

module 888_1009_bottom() {
    translate([-pylon_silentblocks_base_distance/2, 0, 0])
        rotate([0, 0, 180])
            linear_extrude(2+0.5)
                text(">", halign="center", valign="center");
    translate([pylon_silentblocks_base_distance/2, 0, 0])
        rotate([0, 0, 90])
            linear_extrude(2+0.5)
                text(week, halign="center", valign="center", size=4);
    
    difference(){
        union(){
            difference(){
                union(){
                    translate([-40*0.3, 0, 0])
                        airfoil(naca = 0035, L = 40, N = 50, h= pylon_pipe_counterbore_bottom+3, open = false);
                    //aditional material for servo mount 
                    hull(){
                        translate([0, -servo_width/2-1.5, 0])
                            cube([28, servo_width+3, servo_height+3]);
                        translate([0, -servo_width/2-1.5, 0])
                            cube([54, servo_width+3, servo_height-10]);
                    }
                }
                // detach pylon profile from the outer rectangle
                rotate([0,0,-90])
                  translate([0, pylon_silentblocks_base_distance/2, - pylon_silentblocks_base_distance/15])
                    rotate([45,0,0])
                      cube(pylon_silentblocks_base_distance/4+2, center = true);
                
                // servo mount volume
                translate([40, 0, 4])
                    translate() {
                        translate([-servo_length/2, -servo_width/2, 0])
                            cube([servo_length, servo_width, servo_height]);
                        translate([-servo_length_flange/2, -1, 10])
                            cube([servo_length_flange, 2, 10]); // placka pro srouby
                        for(screw_offest = [servo_screw_distance/2, -servo_screw_distance/2])
                            translate([screw_offest, 0, 16])
                                rotate([90, 0, 0]){
                                    cylinder(d = 2, h = 30, center=true, $fn=30);
                                    translate([0, 0, 4]) cylinder(d = 4, h = 30, $fn=30);
                                }
                        translate([-servo_length/2-15, -7/2, -10])
                            cube([15.1, 7, 6+13]);
                    }
            }


            for(x = [-0.5, 0.5], y=[-0.5, 0.5])
              translate([(pylon_silentblocks_base_distance)*x, (pylon_silentblocks_base_distance)*y, 0])
                {
                    cylinder(d=10, h = 2, $fn=30);
                    translate([0, 0, 2])
                      cylinder(d1=10, d2=M3_nut_diameter, h = 2, $fn=30);
                }

            for(y = [-0.5, 0.5]){
                hull()
                  for(x = [-0.5, 0.5])
                    translate([(pylon_silentblocks_base_distance)*x, (pylon_silentblocks_base_distance)*y, 0])
                      cylinder(d=8, h = 2);
            }

            for(x = [-0.5, 0.5])
              hull()
                for(y = [-0.5, 0.5])
                  translate([(pylon_silentblocks_base_distance)*x, (pylon_silentblocks_base_distance)*y, 0])
                      cylinder(d=8, h = 2);

            for(r=[0,1,2,3])
                rotate([0,0,90*r]){
                    hull(){
                        cylinder(d=M3_nut_diameter, h=10);
                        translate([pylon_silentblocks_base_distance*0.5, pylon_silentblocks_base_distance*0.5, 0])
                            cylinder(d=M3_screw_diameter, h=3);
                    }
                }

            // cable harness
            translate([-pylon_silentblocks_base_distance/2,-3-global_clearance, 0])  // (40*0.35) is NACA profile width
                cube([pylon_silentblocks_base_distance/2,3,layer_thickness]);

            translate([-pylon_silentblocks_base_distance/2, global_clearance, 0])  // (40*0.35) is NACA profile width
                cube([pylon_silentblocks_base_distance/2,3,layer_thickness]);


        }

        //strenght decreasing scratches
        zero_scratch_shift = sqrt((pylon_silentblocks_base_distance/4)^2 + (pylon_silentblocks_base_distance/4)^2)/2; // distance of shifting scratching cubes to get exacly zero depth of scratch.
        for(r=[0,1,2,3])
            rotate([0,0,90*r])
              rotate([0,0,45])
                translate([0, pylon_silentblocks_base_distance/3, (zero_scratch_shift - pylon_silentblocks_base_distance/8)/2 - zero_scratch_shift ])
                  rotate([45,0,0])
                    cube(pylon_silentblocks_base_distance/4, center = true);

        // Main pylon hole
        translate([0, 0, 2])
            cylinder(d= pylon_pipe_d, h = 50, $fn=30);
        // bottom of pylon hole
        translate([0, 0, -2])
            cylinder(d= pylon_pipe_d-2, h = 50, $fn=30);

        // cable shaft
        hull() for(sy=[-2.5, 2.5]){
            translate([10, sy, -2])
                cylinder(d= 5, h = 50, $fn=30);
            translate([21, sy, -2])
                cylinder(d= 5, h = 50, $fn=30);
        }

        translate([0, -1, 0])
            cube([20, 2, 50]);
        translate([pylon_pipe_d/2, 0, 3 + pylon_pipe_screw_distance_from_bottom_end])
            rotate([-90, 30, 0]){
                cylinder(d=M3_screw_diameter, h=20, center=true, $fn=60);
                translate([0, 0, -10-5])
                    cylinder(d=M3_head_diameter_ISO7380, h=20, center=true, $fn=60);
                translate([0, 0, 10+5])
                    cylinder(d=M3_nut_diameter, h=20, center=true, $fn=6);
            }


           //translate([-40*0.3, 0, 3 + pylon_pipe_counterbore_bottom - pylon_airfoil_shell_overlap])
            //    hollow_airfoil(naca = 0035, L = 40, N = 50, h= 22, open = true, wall_thickness=0.8);

        // otvory pro prisroubovani silentbloku
        for(x = [-0.5, 0.5], y=[-0.5, 0.5])
            translate([(pylon_silentblocks_base_distance)*x, (pylon_silentblocks_base_distance)*y, -0.5])
                cylinder(d=M3_screw_diameter, h = 10, $fn=30);
    }
}



pylon_adapter_top_width = 31;

top_break_roof = 3;
top_break_side = 2;


module pylon_pipes(d = pylon_pipe_d, below = 10, above = 10, shift=2){

    // zadni prava
    translate([0, 0, 0])
        translate([0, 0, -below + shift])
            cylinder(d = d, h = 163+below+above, $fn=20);
}

color("gray") pylon_pipes(below=0, above=0);

888_1009_bottom();
%translate([0, 0, -8]) 888_1007();
%rotate([0, 0, 180]) translate([0, 0, -13.5+180+3]) 888_1010();
%translate([0, 0, -8]) pylon_silentblocks();


module 888_1009_drill(){

  difference(){
    translate([-20/2, -7, -1])
        cube([20, 18, 40]);
    cylinder(d=pylon_pipe_d, h=170, $fn=30);
    /* translate([-0.5, 0, -2])
        cube([1, 10, 180]);
    translate([-7, -2, 150])
        cube([14, 20, 1.5]); */

    for(z = [pylon_pipe_screw_distance_from_top_end]){
      translate([0, pylon_pipe_d/2, z]) {
        rotate([0, 90, 0])
          cylinder(d=3.1, h=20, center=true, $fn=20);
      }
    }
    /* for(z = [5+10, 150-5-10]){
      translate([0, 5, z])
        rotate([0, 90, 0]) {
            cylinder(d=M3_screw_diameter, h=20, center=true, $fn=20);
            translate([0, 0, 3])
                cylinder(d=M3_nut_diameter, h=20, $fn=6);
            translate([0, 0, -3-20])
                cylinder(d=M3_nut_diameter, h=20, $fn=6);
      }
    } */
  }






  translate([22, 0, 0]){


  difference(){
    translate([-20/2, -7, -1])
        cube([20, 18, 40]);
    cylinder(d=pylon_pipe_d, h=170, $fn=30);
    /* translate([-0.5, 0, -2])
        cube([1, 10, 180]);
    translate([-7, -2, 150])
        cube([14, 20, 1.5]); */

    for(z = [pylon_pipe_screw_distance_from_bottom_end]){
      translate([0, pylon_pipe_d/2, z]) {
        rotate([0, 90, 0])
          cylinder(d=3.1, h=20, center=true, $fn=20);
      }
    }
    /* for(z = [5+10, 150-5-10]){
      translate([0, 5, z])
        rotate([0, 90, 0]) {
            cylinder(d=M3_screw_diameter, h=20, center=true, $fn=20);
            translate([0, 0, 3])
                cylinder(d=M3_nut_diameter, h=20, $fn=6);
            translate([0, 0, -3-20])
                cylinder(d=M3_nut_diameter, h=20, $fn=6);
      }
    } */
  }

  }
}


module pylon_assembly(){
    888_1009_bottom();
}
