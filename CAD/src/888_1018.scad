//Pouozdro na akumulator

include <../parameters.scad>

module mirror_copy(v=[1,0,0])
{
    children();
    mirror(v) children();
}

module 888_1018(battery_case_height = 0, battery_case_start_x = 25, battery_width = 48, battery_case_wall = 0.4*3, battery_height = 42, battery_length = 165, balancer_clip = true, draft=true)
{
    translate([battery_length/2-10, 0, -battery_height])
        rotate([0, 0, -90])
            linear_extrude(battery_case_wall)
              text(str(week, " ^"), halign="center", valign="center", size=4);
    battery_case_holes = true;
    battery_case_wire_holes = true;
    battery_balancer_connector_width = 4;

    difference(){
      union(){
            minkowski(){
              translate([-(battery_length + 2* battery_case_wall - 3*battery_case_wall)/2, -(battery_width+2*battery_case_wall - 3*battery_case_wall)/2, -battery_height-0.5])
                cube([battery_length + 2* battery_case_wall - 3*battery_case_wall, battery_width+2*battery_case_wall - 3*battery_case_wall, battery_height - battery_case_wall]);
              cylinder(d1 = battery_case_wall, d2=3*battery_case_wall, h=2*battery_case_wall, $fn=30);
            }

          // pripevnovaci kostky
          for(x = [-60:40:60])
          difference(){
            hull(){
              translate([-5+x, -base_width/2, -7.25])
                cube([10, base_width, 8]);
              translate([-5+x, -(battery_width+2*battery_case_wall)/2, -battery_height+2*battery_case_wall-0.5])
                cube([10, battery_width+2*battery_case_wall, battery_case_wall]);
            }
            translate([x, 0, -3])
                rotate([90, 0, 0])
                    cylinder(d = M3_screw_diameter, h = 100, $fn = 20, center = true);
            for(y = [base_width/2-3, -(base_width/2-3)])
              hull(){
                translate([x, y, -3]) rotate([90, 30, 0]) cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6, center = true);
                translate([x, y, 3]) rotate([90, 30, 0]) cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6, center = true);
              }
          }
      }

      // prostor na akumulator
      minkowski(){
        translate([-(battery_length-4*battery_case_wall)/2, -(battery_width-4*battery_case_wall)/2, -battery_height+ battery_case_wall - 0.5])
            cube([battery_length-4*battery_case_wall, battery_width-4*battery_case_wall, battery_height-2*battery_case_wall+global_clearance]);
        cylinder(d1=0, d2=4*battery_case_wall, h=2*battery_case_wall, $fn=30);
      }

      if(battery_case_wire_holes){
        for(y=[-1, 1])
          translate([0, y*battery_width/4, -battery_height/2])
            hull(){
              translate([0, 0, (battery_height/2-8) ]) rotate([0, 90, 0]) scale([1, 1.2, 1]) cylinder(d = 10, h =battery_length+10, center = true, $fn=30);
              translate([0, 0, -(battery_height/2-8)]) rotate([0, 90, 0]) scale([1, 1.2, 1]) cylinder(d = 10, h =battery_length+10, center = true, $fn=30);
            }
      }

      if(battery_case_holes){
        for(x=[0, -40, 40])
          translate([x, 0, -battery_height/2])
            hull(){
              translate([0, 0, battery_height/2-(15/2+3)]) rotate([90, 0, 0]) cylinder(d = 15, h=battery_width+10, center = true, $fn=6);
              translate([0, 0, -battery_height/2+(15/2+3)]) rotate([90, 0, 0]) cylinder(d = 15, h=battery_width+10, center = true, $fn=6);
            }

        for(x=[-battery_length/2+battery_width/2:battery_width/3*2:battery_length/2-battery_width/2]){
          translate([x, 0, -battery_height/2])
            hull(){
              minkowski(){
                rotate([0, 0, 30]) cylinder(d = battery_width/3*2-4, h=battery_width+10, center = true, $fn=6);
                cylinder(d=4, h=1, $fn=30);
              }
            }
          }
      }

      for (x = [-battery_length/2+20, 0, battery_length/2-20], y=[-battery_width/2+2, battery_width/2-2])
        translate([x, y, -battery_height-5])
          hull(){
            translate([-1.5, 0, 0]) cylinder(d = 3, h = 30, $fn=15, center = true);
            translate([ 1.5, 0, 0]) cylinder(d = 3, h = 30, $fn=15, center = true);
          }

    mirror_copy([0, 1, 0])
      hull(){
        translate([-battery_length/2,(base_width-6.5*battery_case_wall)/2-battery_balancer_connector_width/2, - 11])
            rotate([0,90,0])
                cylinder(d=battery_balancer_connector_width*1.8, h=battery_length, $fn=30);
        translate([-battery_length/2, (base_width-9*battery_case_wall)/2-battery_balancer_connector_width/2, -battery_height/2])
            rotate([0,90,0])
                cylinder(d=battery_balancer_connector_width, h=battery_length, $fn=30);
      }
    }

    // dummy accumulator model
    //%translate([0, 0, -battery_height/2 + 0.75])
    //    cube([battery_length, battery_width, battery_height], center = true);
}
888_1018();
