//@set_slicing_config(slicing/default.ini)
//nastavovac uhlu pro pylon

include <../parameters.scad>

module 888_1018(){

  difference(){
    union(){
      translate([0, 0, -(battery_height+battery_case_wall)/2])
        cube([battery_length + 2* battery_case_wall, battery_width+2*battery_case_wall, battery_height + battery_case_wall], center = true);

        for(x = [-60:40:60])  difference(){
          hull(){
            translate([-5+x, -base_width/2, -10])
              cube([10, base_width, 10]);
            translate([-5+x, -battery_width/2, -battery_height-battery_case_wall])
              cube([10, battery_width, 1]);
          }
            translate([x, 0, -3.5]) rotate([90, 0, 0]) cylinder(d = M3_screw_diameter, h = 100, $fn = 20, center = true);
            for(y = [base_width/2-3, -(base_width/2-3)])hull(){
              translate([x, y, -3.5]) rotate([90, 0, 0]) cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6, center = true);
              translate([x, y, 3.5]) rotate([90, 0, 0]) cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6, center = true);

          }
        }
    }


  for (x = [-battery_length/2+20, 0, battery_length/2-20], y=[-battery_width/2+2, battery_width/2-2])
    translate([x, y, -battery_case_height-1])
      hull(){
        translate([-1.5, 0, 0]) cylinder(d = 3, h = 10, $fn=15);
        translate([1.5, 0, 0]) cylinder(d = 3, h = 10, $fn=15);
      }

  translate([0, 0, -(battery_height)/2])
    cube([battery_length, battery_width, battery_height+0.1], center = true);


  }

}

888_1018();
