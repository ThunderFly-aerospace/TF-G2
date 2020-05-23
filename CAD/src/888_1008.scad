//@set_slicing_config(slicing/default.ini)
//Spodni cast pylonu

include <../parameters.scad>


module 888_1008(){
    translate([0, 0, pylon_thickness/2])
    difference(){
        union(){
            hull(){
                cube([pylon_ring_length, 10, pylon_thickness], center = true);
                translate([0, pylon_height - pilot_height_separation, 0])
                    cube([pylon_top_length, 10, pylon_thickness], center = true);
                translate([0, pylon_height - pilot_height_separation + 15, 0])
                    cylinder(d = 10, h=pylon_thickness, center = true);
            }
            /* hull(){
                cube([pylon_ring_length, 10, pylon_thickness], center = true);
                translate([0, 0, pylon_thickness/2])
                    rotate([90-pylon_angle, 0, 0])
                        cube([pylon_ring_length, 10, 0.1], center = true);
            }
    translate([0, pilot_height_separation, 0])
            hull(){
                cube([pylon_base_length/4, 10, pylon_thickness], center = true);
                translate([0, 0, pylon_thickness/2])
                    rotate([90-pylon_angle, 0, 0])
                        cube([pylon_base_length/2, 10, 0.1], center = true);
            } */
        }
        translate([0, pylon_height - pilot_height_separation + 15, 0])
            cylinder(d = M3_screw_diameter, h=pylon_thickness+1, center = true, $fn = 50);


        difference(){
            hull(){
                translate([0, 10/2, 0])
                    cube([pylon_ring_length-20, 0.1, pylon_thickness+1], center = true);
                    translate([0, pylon_height - pilot_height_separation - 10/2, 0])
                        cube([pylon_top_length-10, 0.1, pylon_thickness+1], center = true);
            }
                difference(){
                    union(){
                        translate([0, pilot_height_separation/2 - 8/2 + 0.4, 0])
                            cube([pylon_base_length/2, 8, pylon_thickness+1], center = true);

                        translate([0, pilot_height_separation/2 - 8*1.5 - 23 - 0.4, 0])
                            cube([pylon_base_length/2, 8, pylon_thickness+1], center = true);
                    }
                    translate([0, pilot_height_separation/2 - 8 + 3, 0])
                        cylinder(d = M2_screw_diameter, h = 10, $fn = 50, center = true);
                    translate([0, pilot_height_separation/2 - 8 - 23 - 3, 0])
                        cylinder(d = M2_screw_diameter, h = 10, $fn = 50, center = true);

                }
        }


// Odlehceny a zpevneni nosnych casti
        for(i=[0, 1]) mirror([i, 0, 0])
        difference(){
          hull(){
            translate([pylon_ring_length/2 - 5, 6, -2])
              cylinder(d = 1.5, h = pylon_thickness+1);

            translate([pylon_top_length/2 - 2, pylon_height - pilot_height_separation - 6, -2])
              cylinder(d = 1.5, h = pylon_thickness+1);
          }

          for(y = [0:10])
            translate([0, y*15, 0])
              cube([100, 3, pylon_thickness*2+2], center = true);
        }


    for(x = [-pylon_ring_length/2+5:10:pylon_ring_length/2-5])
    translate([x, 0, 0])
            cylinder(d = M3_screw_diameter, h = 20, center = true, $fn = $preview?10:30);

    for(x = [-pylon_top_length/2+5:10:pylon_top_length/2-5])
    translate([x, pylon_height - pilot_height_separation, 0])
            cylinder(d = M3_screw_diameter, h = 20, center = true, $fn = $preview?10:30);
    }
}

888_1008();
