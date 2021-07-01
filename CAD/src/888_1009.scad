
include <../parameters.scad>
use <888_1007.scad>
use <888_1010.scad>


// Vypocet uhlu tycek
    x_front_bottom = pylon_silentblocks_base_distance/2-15/2;
    y_front_bottom = pylon_silentblocks_base_distance/2;
    x_rear_bottom = pylon_silentblocks_base_distance/2;
    y_rear_bottom = pylon_silentblocks_base_distance/2-15/2;

    x_pos_top = pylon_pipe_top_x_dist/2;
    y_pos_top = pylon_pipe_top_y_dist/2;

    length_front = sqrt( sqrt((x_front_bottom-x_pos_top)^2 + (y_front_bottom-y_pos_top)^2 )^2 + pylon_suspension_height^2);
    length_rear = sqrt( sqrt((x_rear_bottom-x_pos_top)^2 + (y_rear_bottom-y_pos_top)^2 )^2 + pylon_suspension_height^2);
    length = length_front;
    echo("delka tycek (predni):", length_front);
    echo("delka tycek (zadni):", length_rear);

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
      translate([0, 0, -2]) cylinder(d = pylon_pipe_d+4, h = 13+2, $fn=30);
      translate([0, -3.5, 0]) cube([7.5, 7, 12]);

    }
    translate([2, -0.5, 0]) cube([10, 1, 15]);
    translate([1.5, -4, 3]) cube([10, 8, 0.4]);
    translate([0, 0, 3]) cylinder(d = pylon_pipe_d, h = 16, $fn=30);

    translate([M3_screw_diameter/2+pylon_pipe_d/(2*3), 0, 8]) rotate([90, 0, 0]){
        cylinder(d=M3_screw_diameter, h = 10, center=true, $fn=20);
        translate([0, 0, 2.6]) rotate(30) cylinder(d=M3_nut_diameter, h = 10, $fn=6);
        translate([0, 0, -2.6-10]) rotate(30) cylinder(d=M3_nut_diameter, h = 10, $fn=6);
    }

  }
}


module 888_1009_bottom() {
 translate([-pylon_silentblocks_base_distance/2, 0, 0]) rotate([0, 0, 180]) linear_extrude(2+0.5) text(">", halign="center", valign="center");
 translate([pylon_silentblocks_base_distance/2, 0, 0]) rotate([0, 0, 90]) linear_extrude(2+0.5) text(week, halign="center", valign="center", size=4);
  difference(){
union(){
  for(x = [-0.5, 0.5], y=[-0.5, 0.5])
    translate([(pylon_silentblocks_base_distance)*x, (pylon_silentblocks_base_distance)*y, 0])
      {
          cylinder(d=10, h = 2, $fn=30);
          translate([0, 0, 2])cylinder(d1=10, d2=M3_nut_diameter, h = 2, $fn=30);
      }

  for(y = [-0.5, 0.5])
    {
      hull()
        for(x = [-0.5, 0.5])
          translate([(pylon_silentblocks_base_distance)*x, (pylon_silentblocks_base_distance)*y, 0])
            cylinder(d=8, h = 2);
      translate([0, pylon_silentblocks_base_distance*y, 2])
          cube([pylon_silentblocks_base_distance, 2, 2], center=true);
    }
  for(x = [-0.5, 0.5])
    hull()
      for(y = [-0.5, 0.5])
        translate([(pylon_silentblocks_base_distance)*x, (pylon_silentblocks_base_distance)*y, 0])
        cylinder(d=8, h = 2);
}

  // otvory pro prisroubovani silentbloku
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


module 888_1009_top(){


pole = [
[
        [pylon_pipe_top_x_dist/2, pylon_pipe_top_y_dist/2, 0],
        [pylon_screw_top_x_dist/2, pylon_screw_top_y_dist/2, 0],
        [rot_rr_x, rot_rr_y],
        [1, 1]
],
[
        [-pylon_pipe_top_x_dist/2, pylon_pipe_top_y_dist/2, 0],
        [-pylon_screw_top_x_dist/2, pylon_screw_top_y_dist/2, 0],
        [rot_fr_x, rot_fr_y],
        [-1, 1]
],
[
        [pylon_pipe_top_x_dist/2, -pylon_pipe_top_y_dist/2, 0],
        [pylon_screw_top_x_dist/2, -pylon_screw_top_y_dist/2, 0],
        [rot_rl_x, rot_rl_y],
        [1, -1]
],
[
        [-pylon_pipe_top_x_dist/2, -pylon_pipe_top_y_dist/2, 0],
        [-pylon_screw_top_x_dist/2, -pylon_screw_top_y_dist/2, 0],
        [rot_fl_x, rot_fl_y],
        [-1, -1]
]

];


for( i = [0, 1, 2, 3] ){
    param = pole[i];

    difference(){
      union(){

        // sloupek pro tycku
        intersection(){
              translate(param[0])
                cube([10, 10, 10], center=true);
            translate(param[0])
                rotate([0, param[2][0], 0]) rotate([param[2][1], 0, 0])
                  union(){
                   cylinder(d=pylon_pipe_d+2.5, h=25, center=true, $fn=48);
                   translate([-5*param[3][0], 0, 0]) cube([10, 6, 20], center=true);
                 }
        }

        // spodni nozicka pro prisroubovani
        hull(){
            intersection(){
                translate(param[0]+[0, 0, +5-1])
                    cube([15, 15, 2], center=true);
                translate(param[0])
                    rotate([0, param[2][0], 0]) rotate([param[2][1], 0, 0])
                        cylinder(d=8, h=25, center=true, $fn=48);
            }
            translate(param[1]+[0, 0, +5-1.5])
                cylinder(d2=M3_nut_diameter+1, d1=M3_nut_diameter, h=3, center=true, $fn=48);
       }

       hull(){
          intersection(){
              translate(param[0])
                  cube([10, 10, 5], center=true);
              translate(param[0])
                  rotate([0, param[2][0], 0]) rotate([param[2][1], 0, 0])
                     cylinder(d=pylon_pipe_d+2.5, h=25, center=true, $fn=48);
          }
          intersection(){
              translate(param[0]+[0, 0, +5-1])
                  cube([15, 15, 2], center=true);
              translate(param[0])
                  rotate([0, param[2][0], 0]) rotate([param[2][1], 0, 0])
                      cylinder(d=8, h=25, center=true, $fn=48);
          }
       }
    }




    translate(param[1]+[0, 0, -2.5])
      cylinder(d1=M3_head_diameter-1.5, d2=M3_head_diameter+1.5, h=6, $fn=48);


    intersection(){
        translate(param[0]+[0, 0, -1])
            cube([10, 10, 10], center=true);
        translate(param[0]+[0, 0, 0])
            rotate([0, param[2][0], 0]) rotate([param[2][1], 0, 0])
                cylinder(d=pylon_pipe_d, h=25, center=true, $fn=24);
    }

    translate(param[0] + [-(M3_screw_diameter/2+pylon_pipe_d/(2*3))*param[3][0], 0, -2]) rotate([90, 0, 0]){
        cylinder(d=M3_screw_diameter, h = 10, center=true, $fn=20);
        translate([0, 0, 2.4]) rotate(30) cylinder(d=M3_nut_diameter, h = 10, $fn=6);
        translate([0, 0, -2.5-10]) rotate(30) cylinder(d=M3_nut_diameter, h = 10, $fn=6);

        translate([-3*param[3][0], -5, 0]) cube([10, 20, 1], center=true);
    }

    translate(param[1])
        //rotate([0, param[2][0], 0]) rotate([param[2][1], 0, 0])
            cylinder(d=M3_screw_diameter, h=25, center=true, $fn=24);



    }
  }
}



module pylon_pipes(d = pylon_pipe_d, below = 10, above = 10, shift=2){

    // zadni prava
    translate([x_rear_bottom, y_rear_bottom, 0])
        rotate([0, rot_rr_x, 0]) rotate([rot_rr_y, 0, 0])
            translate([0, 0, -below + shift])
                cylinder(d = d, h = length_rear+below+above, $fn=20);

    // predni prava
    translate([-x_front_bottom, y_front_bottom, 0])
        rotate([0, rot_fr_x, 0]) rotate([rot_fr_y, 0, 0])
            translate([0, 0, -below + shift])
                cylinder(d = d, h = length_front+below+above, $fn=20);

    // zadni leva
    translate([x_rear_bottom, -y_rear_bottom, 0])
        rotate([0, rot_rl_x, 0]) rotate([rot_rl_y, 0, 0])
            translate([0, 0, -below + shift])
                cylinder(d = d, h = length_rear+below+above, $fn=20);

    // predni leva
    translate([-x_front_bottom, -y_front_bottom, 0])
        rotate([0, rot_fl_x, 0]) rotate([rot_fl_y, 0, 0])
            translate([0, 0, -below + shift])
                cylinder(d = d, h = length_front+below+above, $fn=20);

}

color("gray") pylon_pipes(below=0, above=0);

888_1009_bottom();
translate([0, 0, 150]) 888_1009_top();
%translate([0, 0, -8]) 888_1007();
%rotate([0, 0, 180]) translate([7.5, 0, -13.5+180+3]) 888_1010();
%translate([0, 0, -8]) pylon_silentblocks();



module 888_1009_drill(){

  difference(){
  translate([-15/2, -5, -1]) cube([15, 15, 150+1+5]);
    cylinder(d=4.3, h=170, $fn=30);
    translate([-0.5, 0, -2]) cube([1, 10, 180]);
    translate([-7, -2, 150]) cube([14, 20, 1.5]);

    for(z = [5, 150-5]){
      translate([0, M3_screw_diameter/2+pylon_pipe_d/(2*3), z]) {
        rotate([0, 90, 0])
          cylinder(d=3.1, h=20, center=true, $fn=20);
      }
    }
    for(z = [5+10, 150-5-10]){
      translate([0, 5, z])
        rotate([0, 90, 0]) {
          cylinder(d=M3_screw_diameter, h=20, center=true, $fn=20);
          translate([0, 0, 3]) cylinder(d=M3_nut_diameter, h=20, $fn=6);
          translate([0, 0, -3-20]) cylinder(d=M3_nut_diameter, h=20, $fn=6);
      }
    }
  }
}


module pylon_assembly(){
    888_1009_bottom();
    translate([0, 0, 150]) 888_1009_top();
}
