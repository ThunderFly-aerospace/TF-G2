//@set_slicing_config(slicing/default.ini)
//nastavovac uhlu pro pylon

include <../parameters.scad>

module 888_1017(){
  translate([0, 0, 0])
    difference(){

      // Zakladni tvar
      hull()
        for(x = [-pylon_base_length/2+5:10:pylon_base_length/2-5])
          translate([x, 0, 0])
              cylinder(d = M3_nut_diameter+2, h = 3, $fn = $preview?10:30);


      rotate([-90+pylon_angle, 0, 0])
        translate([0, 0, pylon_thickness*1])
          cube([70, 70, pylon_thickness], center = true);


  //  Otvory pro prisroubovani
      for(x = [-pylon_base_length/2+5:10:pylon_base_length/2-5])
        translate([x, 0, 0])
          rotate([-90+pylon_angle, 0, 0])
            cylinder(d = M3_screw_diameter+0.3, h = 20, center = true, $fn = $preview?10:30);

    }
}

888_1017();
