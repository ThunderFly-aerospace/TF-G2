//@set_slicing_config(slicing/default.ini)
// Trhaci predel rotorove hlavy

include <../parameters.scad>
use <888_1007.scad>
use <888_1010.scad>

pylon_silentblocks_base_distance = 58;


module clamp(){
  difference(){
    union(){
      cylinder(d = 5+4, h = 10);
      translate([0, -2.5, 0]) cube([9, 5, 10]);

    }
    translate([0, -0.5, 0]) cube([10, 1, 11]);
    cylinder(d = 5, h = 11);

    translate([6, 0, 6]) rotate([90, 0, 0]){
        cylinder(d=M3_screw_diameter, h = 10, center=true, $fn=10);
        translate([0, 0, 1.5]) rotate(30) cylinder(d=M3_nut_diameter, h = 10, $fn=6);
    }

  }
}


module 888_1009_bottom() {
  difference(){
union(){
  for(x = [-0.5, 0.5], y=[-0.5, 0.5])
    translate([(pylon_silentblocks_base_distance)*x, (pylon_silentblocks_base_distance)*y, 0])
      cylinder(d=10, h = 2, $fn=30);

  for(y = [-0.5, 0.5])
    hull()
      for(x = [-0.5, 0.5])
        translate([(pylon_silentblocks_base_distance)*x, (pylon_silentblocks_base_distance)*y, 0])
          cylinder(d=8, h = 2);
  for(x = [-0.5, 0.5])
    hull()
      for(y = [-0.5, 0.5])
        translate([(pylon_silentblocks_base_distance)*x, (pylon_silentblocks_base_distance)*y, 0])
        cylinder(d=8, h = 2);
}

  for(x = [-0.5, 0.5], y=[-0.5, 0.5])
    translate([(pylon_silentblocks_base_distance)*x, (pylon_silentblocks_base_distance)*y, -0.5])
      cylinder(d=M3_screw_diameter, h = 3, $fn=15);
}

    //predni svorky
    for(y=[-1, 0])
      mirror([0, y, 0])
        translate([pylon_silentblocks_base_distance*0.5, 0.5*(pylon_silentblocks_base_distance-15), 0])
          rotate([0, 0, 180])
            clamp();

    //zadni svorky
    for(y=[-1, 0])
      mirror([0, y, 0])
        translate([-pylon_silentblocks_base_distance*0.5+15/2, 0.5*(pylon_silentblocks_base_distance), 0])
          clamp();

}



pylon_adapter_top_width = 35-4;


top_break_roof = 1;
top_break_side = 2;

module 888_1009_top(){

  difference(){
    cube([30, pylon_adapter_top_width, 10], center = true);
    translate([0, 0, top_break_roof])
      cube([31, pylon_adapter_top_width-top_break_side*3, 10], center = true);

    for(x = [-15/2, 15/2], y = [-pylon_adapter_top_width/2+2, pylon_adapter_top_width/2-2]) 
      translate([x, y, 0])
        rotate([-90, 0, 0])
        {
          cylinder(d = M3_screw_diameter, h = 10, center = true, $fn = 20);
          cylinder(d = M3_nut_diameter, h = 2, center = true, $fn = 6);
        }
  }
}



module pylon_pipes(d = pylon_pipe_d, below = 10, above = 10){
    x_front_bottom = pylon_silentblocks_base_distance/2;
    x_rear_bottom = pylon_silentblocks_base_distance/2-15/2;
    y_rear_bottom = pylon_silentblocks_base_distance/2;
    y_front_bottom = pylon_silentblocks_base_distance/2-15/2;

    x_pos_bottom = base_width/2 - 5;
    y_pos_bottom = base_width/2 - 5;

    x_pos_top = pylon_pipe_top_dist/2;
    y_pos_top = pylon_pipe_top_dist/2;

    length = sqrt( sqrt((x_pos_bottom-x_pos_top)^2 + (y_pos_bottom-y_pos_top)^2 )^2 + pylon_suspension_height^2);
    echo("delka tycek:", length);

    // predni prava
    translate([x_front_bottom, y_front_bottom, 0])
        rotate([atan2((x_pos_bottom-x_pos_top), pylon_suspension_height), 0, 0])
            translate([0, 0, -below]) cylinder(d = d, h = length+below+above, $fn=20);

    translate([-x_rear_bottom, y_rear_bottom, 0])
        rotate([atan2((x_pos_bottom-x_pos_top), pylon_suspension_height), atan2((y_pos_bottom-y_pos_top), pylon_suspension_height), 0])
            translate([0, 0, -below]) cylinder(d = d, h = length+below+above, $fn=20);

    // predni leva
    translate([x_front_bottom, -y_front_bottom, 0])
        rotate([-atan2((x_pos_bottom-x_pos_top), pylon_suspension_height), 0, 0])
            translate([0, 0, -below]) cylinder(d = d, h = length+below+above, $fn=20);
    translate([-x_rear_bottom, -y_rear_bottom, 0])
        rotate([-atan2((x_pos_bottom-x_pos_top), pylon_suspension_height), atan2((y_pos_bottom-y_pos_top), pylon_suspension_height), 0])
            translate([0, 0, -below]) cylinder(d = d, h = length+below+above, $fn=20);
}
pylon_pipes(below=0);

888_1009_bottom();
translate([0, 0, 150]) 888_1009_top();
%translate([0, 0, -8]) 888_1007();
%rotate([0, 0, 180]) translate([7.5, 0, -13.5+180]) 888_1010();
%translate([0, 0, -8]) pylon_silentblocks();
