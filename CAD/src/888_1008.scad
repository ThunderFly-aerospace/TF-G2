//@set_slicing_config(slicing/default.ini)
//Spodni cast pylonu

include <../parameters.scad>
include <lib/Round-Anything/polyround.scad>
include <lib/Round-Anything/roundAnythingExamples.scad>


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

            // kostky pro pripevneni serva
            translate([-13.75, 35, pylon_thickness/2])
                rotate([0, 0, -7.2])
                    difference(){
                        intersection(){
                            extrudeWithRadius(10, -5, 0, 70)
                                square([5, 33], center = true);
                            cube([5, 50, 22], center=true);
                        }
                        cube([6, 24, 22], center = true);
                        for(y=[-28/2, 28/2])
                            translate([0, y, 5])
                                rotate([0, 90, 0])
                                    cylinder(h=30, d=1.7, center=true, $fn=20);
                    }

            // Material pro matky, k rámečku pylonu
            hull()
              for(x = [-pylon_ring_length/2+5:10:pylon_ring_length/2-5])
                  translate([x, 0, 0])
                    cylinder(d = M3_nut_diameter+2, h = 3, $fn = $preview?10:30);

        }
        
        translate([0, pylon_height - pilot_height_separation + 15, 0])
            cylinder(d = M3_screw_diameter, h=pylon_thickness+1, center = true, $fn = 50);


        
        // Stredni odlehceni pylonu
        difference(){
            hull(){
                translate([0, 10/2, 0])
                    cube([pylon_ring_length-20, 0.1, pylon_thickness+1], center = true);
                    translate([0, pylon_height - pilot_height_separation - 10/2, 0])
                        cube([pylon_top_length-10, 0.1, pylon_thickness+1], center = true);
            }
            
            // Pricky pro pripevneni serva
            difference(){
                union(){
                    translate([0, pilot_height_separation/2 - 8/2 + 0.2, 0])
                        cube([pylon_base_length/2, 4, pylon_thickness+1], center = true);

                    translate([0, pilot_height_separation/2 - 8*1.5 - 23 - 0.2, 0])
                        cube([pylon_base_length/2, 4, pylon_thickness+1], center = true);
                }
                
                // Otvory v prickach
                //translate([0, pilot_height_separation/2 - 8 + 3, 0])
                //    cylinder(d = M2_screw_diameter, h = 10, $fn = 50, center = true);
                //translate([0, pilot_height_separation/2 - 8 - 23 - 3, 0])
                //    cylinder(d = M2_screw_diameter, h = 10, $fn = 50, center = true);


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
        translate([x, 0, 0]){
            cylinder(d = M3_screw_diameter, h = 20, center = true, $fn = $preview?10:30);
        translate([0, 0, pylon_thickness-2])
            cylinder(d = M3_nut_diameter, h = 20, $fn = 6);
      }

    //for(x = [-pylon_top_length/2+5:10:pylon_top_length/2-5])
    for(x = [pylon_top_length/2-5])
        translate([x, pylon_height - pilot_height_separation, 0])
            cylinder(d = M3_screw_diameter, h = 20, center = true, $fn = $preview?10:30);
    }
}

    888_1008();


module 888_5002(){
    difference(){
        union(){
            hull(){
                translate([0, -10, 0])
                    cube([40, 20, 3]);

                translate([10, 0, 5])
                    rotate([90, 0, 0])
                        cylinder(d = 10, h=20, center=true);

            }
        }
        for(y = [-8, 8])
            translate([15, y, 0])
                cylinder(d=M3_screw_diameter, h=10, center=true, $fn=30);

        translate([10, 0, 5])
            rotate([90, 0, 0])
                cylinder(d = M3_screw_diameter, h=21, center=true, $fn=30);
    }
}


// 888_5002();


translate([-10, 80, pylon_thickness + 10])
    rotate([-90, 0, 0])
        888_5002();

