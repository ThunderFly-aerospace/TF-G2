//@set_slicing_config(slicing/default.ini)
// Trhaci predel rotorove hlavy

include <../parameters.scad>
use <888_1007.scad>
use <888_1010.scad>

pylon_silentblocks_base_distance = 58;
pylon_pipe_top_y_dist = 20;
pylon_pipe_top_x_dist = 30;


// Vypocet uhlu tycek
    x_front_bottom = pylon_silentblocks_base_distance/2-15/2;
    x_rear_bottom = pylon_silentblocks_base_distance/2;
    y_rear_bottom = pylon_silentblocks_base_distance/2-15/2;
    y_front_bottom = pylon_silentblocks_base_distance/2;

    x_pos_bottom = base_width/2 - 5;
    y_pos_bottom = base_width/2 - 5;

    x_pos_top = pylon_pipe_top_x_dist/2;
    y_pos_top = pylon_pipe_top_y_dist/2;

    length = sqrt( sqrt((x_pos_bottom-x_pos_top)^2 + (y_pos_bottom-y_pos_top)^2 )^2 + pylon_suspension_height^2);
    echo("delka tycek:", length);

    // zadni prava
    
    rot_rr_x = atan2(pylon_suspension_height, (x_rear_bottom-pylon_pipe_top_x_dist/2))-90;
    rot_rr_y = 90-atan2(pylon_suspension_height, (y_rear_bottom-pylon_pipe_top_y_dist/2));
    
    rot_fr_x = atan2(pylon_suspension_height, -(x_front_bottom-pylon_pipe_top_x_dist/2))-90;
    rot_fr_y = 90-atan2(pylon_suspension_height, (y_front_bottom-pylon_pipe_top_y_dist/2));
    
    rot_rl_x = atan2(pylon_suspension_height, (x_rear_bottom-pylon_pipe_top_x_dist/2))-90;
    rot_rl_y = 90-atan2(pylon_suspension_height, -(y_rear_bottom-pylon_pipe_top_y_dist/2));
    
    rot_fl_x = atan2(pylon_suspension_height, -(x_front_bottom-pylon_pipe_top_x_dist/2))-90;
    rot_fl_y = 90-atan2(pylon_suspension_height, -(y_front_bottom-pylon_pipe_top_y_dist/2));
    
    
    

module clamp(){
  difference(){
    union(){
      translate([0, 0, -2]) cylinder(d = 5+4, h = 13+2, $fn=30);
      translate([0, -2.5, 0]) cube([9, 5, 12]);

    }
    translate([2, -0.5, 0]) cube([10, 1, 15]);
    translate([0, 0, 3]) cylinder(d = 5, h = 16, $fn=30);

    translate([6, 0, 8.5]) rotate([90, 0, 0]){
        cylinder(d=M3_screw_diameter, h = 10, center=true, $fn=20);
        translate([0, 0, 1.5]) rotate(30) cylinder(d=M3_nut_diameter, h = 10, $fn=6);
        translate([0, 0, -1.5-10]) rotate(30) cylinder(d=M3_nut_diameter, h = 10, $fn=6);
    }

  }
}


module 888_1009_bottom() {
  difference(){
union(){
  for(x = [-0.5, 0.5], y=[-0.5, 0.5])
    translate([(pylon_silentblocks_base_distance)*x, (pylon_silentblocks_base_distance)*y, 0])
      {
          cylinder(d=10, h = 2, $fn=30);
          translate([0, 0, 2])cylinder(d1=10, d2=M3_nut_diameter, h = 2, $fn=30);
      }

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
      cylinder(d=M3_screw_diameter, h = 10, $fn=30);
}

    difference(){   
        union(){
            //zadni  svorky    
            for(y=[-1, 0])
              mirror([0, y, 0])
                translate([pylon_silentblocks_base_distance*0.5, 0.5*(pylon_silentblocks_base_distance-15), 0])
                  rotate([0, 0, 180]) rotate([0, -rot_rl_x, 0]) rotate([rot_rl_y, 0, 0])
                    clamp();

            //predni svorky
            for(y=[-1, 0])
              mirror([0, y, 0])
                translate([-pylon_silentblocks_base_distance*0.5+15/2, 0.5*(pylon_silentblocks_base_distance), 0])
                    rotate([0, rot_fl_x, 0]) rotate([-rot_fl_y, 0, 0])
                        clamp();
        }
        translate([0, 0, -5]) cube([100, 100, 10], center=true);
}
}



pylon_adapter_top_width = 31;


top_break_roof = 3;
top_break_side = 2;

echo("PYLON");
echo(pylon_pipe_top_dist);

module 888_1009_top(){

  difference(){
    
    cube([38, pylon_adapter_top_width, 10], center = true);
    translate([0, 0, top_break_roof])
      cube([40, pylon_adapter_top_width-11, 10], center = true);
    translate([0, 0, top_break_roof])
      cube([7, pylon_adapter_top_width-3, 10], center = true);

    // Otvory pro sesroubovani s pylonem
    translate([pylon_pipe_top_x_dist/2, pylon_pipe_top_y_dist/2, -5])
        rotate([0, rot_rr_x, 0]) rotate([rot_rr_y, 0, 0])
            {
                cylinder(d=5, h=25, center=true, $fn=24);
                translate([0, 0, 5]) rotate([90, 0, 0]) cylinder(d=2, h = 15, center=true, $fn=30);
            }
    translate([-pylon_pipe_top_x_dist/2, pylon_pipe_top_y_dist/2, -5])
        rotate([0, rot_fr_x, 0]) rotate([rot_fr_y, 0, 0])
            cylinder(d=5, h=25, center=true, $fn=24);
      
    translate([pylon_pipe_top_x_dist/2, -pylon_pipe_top_y_dist/2, -5])
        rotate([0, rot_rl_x, 0]) rotate([rot_rl_y, 0, 0])
            cylinder(d=5, h=25, center=true, $fn=24);
   
    translate([-pylon_pipe_top_x_dist/2, -pylon_pipe_top_y_dist/2, -5])
        rotate([0, rot_fl_x, 0]) rotate([rot_fl_y, 0, 0])
            cylinder(d=5, h=25, center=true, $fn=24);
    
    // Otvory pro sesroubovani s rotorovou hlavou
    for(x = [-15/2, 15/2], y = [-pylon_adapter_top_width/2+3, pylon_adapter_top_width/2-3]) 
      translate([x, y, 0])
        rotate([-90, 0, 0])
        {
            cylinder(d = M3_screw_diameter, h = 10, center = true, $fn = 20);
            hull(){
                cylinder(d = M3_nut_diameter, h = M3_nut_height, center = true, $fn = 6);
                translate([0, -10, 0])
                    cylinder(d = M3_nut_diameter, h = M3_nut_height, center = true, $fn = 6);
            }
        }
  }
}



module pylon_pipes(d = pylon_pipe_d, below = 10, above = 10){
    
    // zadni prava
    translate([x_rear_bottom, y_rear_bottom, 0])
        rotate([0, rot_rr_x, 0]) rotate([rot_rr_y, 0, 0])
            translate([0, 0, -below])
                cylinder(d = d, h = length+below+above, $fn=20);
                
    // predni prava
    translate([-x_front_bottom, y_front_bottom, 0])
        rotate([0, rot_fr_x, 0]) rotate([rot_fr_y, 0, 0])
            translate([0, 0, -below])
                cylinder(d = d, h = length+below+above, $fn=20);

    // zadni leva
    translate([x_rear_bottom, -y_rear_bottom, 0])
        rotate([0, rot_rl_x, 0]) rotate([rot_rl_y, 0, 0])
            translate([0, 0, -below])
                cylinder(d = d, h = length+below+above, $fn=20);

    // predni leva
    translate([-x_front_bottom, -y_front_bottom, 0])
        rotate([0, rot_fl_x, 0]) rotate([rot_fl_y, 0, 0])
            translate([0, 0, -below])
                cylinder(d = d, h = length+below+above, $fn=20);
            
}

pylon_pipes(below=-3, above=3);

888_1009_bottom();
translate([0, 0, 150]) 888_1009_top();
%translate([0, 0, -8]) 888_1007();
%rotate([0, 0, 180]) translate([7.5, 0, -13.5+180]) 888_1010();
%translate([0, 0, -8]) pylon_silentblocks();
