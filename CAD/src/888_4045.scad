include <../parameters.scad>
include <lib/stdlib/polyScrewThread_r1.scad>

use <888_4008.scad>;


//  angle_between_blades = 360 / rotor_blades_count;

//    thickness = 2.3;
    top_thickness = 3;

    height_from_rotor_nut = 11.5 - 1.65 ;

//    starter_top_r=14;
    starter_top_h=M3_screw_head_height+3;
//    starter_pipe_d_top = 20;
    starter_pipe_d_middle = 27;
//    starter_pipe_d_bottom = 20;
//    starter_neck_r=10;
    starter_neck_h=1;
    starter_bottom_h=5;
    starter_rope_diameter=2;

    starter_rope_d = 27.0;

    sensor_cap_height=starter_top_h+starter_neck_h+starter_bottom_h;

    rpm_sensor_h = height_from_rotor_nut - starter_top_h;
    rpm_sensor_count=16;
    rpm_hole_h = 50;
   rpm_hole_width = 7;
   rpm_sensor_base_h= 2;

//    screws_head_d=7;
//    screws_h=14;

    Ribbon_width = 6;
    Ribbon_part_w = height_from_rotor_nut- (16.5 - 1.65) + Ribbon_width; // Auxiliary variable

    H_mill_disc = 1.6;
    D_mill_disc = 80;

    // Inner clif of 888_4008
       End_Wall_Thickness = 5;
       Bwall = 1.6; // wall around bearing

             // Holes for self-cutting screws
       Self_screw_diameter = 2;
       Depth_self_screw = 30;
       Number_of_holes = 3;

       D_mezikus = starter_pipe_d_middle+0.2-End_Wall_Thickness*2+34;


  // Parameters of holes for sensors
    Zero_dist = starter_pipe_d_middle/2-End_Wall_Thickness/2+4.7 +1;  // Distance of zero position sensor from the center
    RotSpeed_dist = starter_pipe_d_middle/2-End_Wall_Thickness/2+9.7 +1;  // Distance of rotation speed sensor from the center
    Zero_angle = 20; // Angle of zero position sensor from y axis



module mill_rot(draft = true){
    rotate([0,0, rotor_delta_angle])
    difference(){

    cylinder(h=H_mill_disc, d=D_mill_disc, $fn = draft?16:120);


       //  Central hole
             translate([0,0,-5])
       cylinder(h=sensor_cap_height*0.7+Ribbon_part_w+0.25, d = bearing_outer_diameter + Bwall*2+2.7, $fn = draft?16:120);

      // Holes for self-cutting screws  - ENLARGED
       for (i = [1:Number_of_holes]){
          rotate([0, 0, i*360/Number_of_holes])
          translate([starter_pipe_d_middle/2-End_Wall_Thickness/2, 0, top_thickness + M3_nut_height + sensor_cap_height/2+Ribbon_width/2+0.15])
              cylinder(h = Depth_self_screw, d = Self_screw_diameter + 0.5, center = true, $fn=20);
                                }

                                for (i = [1:4]){
          rotate([0, 0, i*360/4])
          translate([starter_pipe_d_middle/2-End_Wall_Thickness/2, 0, top_thickness + M3_nut_height + sensor_cap_height/2+Ribbon_width/2+0.15])
              cylinder(h = Depth_self_screw, d = Self_screw_diameter + 0.5, center = true, $fn=20);
                                }

           Number_of_holes2 = 24;
         // Holes for rotation speed measurement
      for (i = [1:Number_of_holes2]){
            s = 2;  // Vzdálenost děr stadionu
            R = RotSpeed_dist-s/2;  // Vzdálenost bližších kruhů od středu
            r = 1;
            vzd = 2*PI*R/48/2;


          rotate([0, 0, i*360/Number_of_holes2+360/Number_of_holes2/2])
            hull(){
                translate([R, -(vzd - r), -5])
              cylinder(h = Depth_self_screw, d = 2*r, center = true, $fn=draft?6:20);
                translate([R, vzd - r, -5])
              cylinder(h = Depth_self_screw, d = 2*r, center = true, $fn=draft?6:20);
                translate([R+s, -((vzd+s*vzd/(R-s))-r), -5])
              cylinder(h = Depth_self_screw, d = 2*r, center = true, $fn=draft?6:20);
                translate([R+s, ((vzd+s*vzd/(R-s))-r), -5])
              cylinder(h = Depth_self_screw, d = 2*r, center = true, $fn=draft?6:20);
                    }
                          }


            Number_of_holes3 = 2;
         // Holes for zero postition sensor
      for (i = [1:Number_of_holes3]){
              s = 2;  // Vzdálenost děr stadionu
              R = Zero_dist - s/2;  // Vzdálenost bližších kruhů od středu
              r = 1;
              vzd = 2*PI*R/48/2;


          rotate([0, 0, i*360/Number_of_holes3+90+Zero_angle])
            hull(){
                translate([R, -(vzd - r), -5])
              cylinder(h = Depth_self_screw, d = 2*r, center = true, $fn=draft?6:20);
                translate([R, vzd - r, -5])
              cylinder(h = Depth_self_screw, d = 2*r, center = true, $fn=draft?6:20);
                translate([R+s, -((vzd+s*vzd/(R-s))-r), -5])
              cylinder(h = Depth_self_screw, d = 2*r, center = true, $fn=draft?6:20);
                translate([R+s, ((vzd+s*vzd/(R-s))-r), -5])
              cylinder(h = Depth_self_screw, d = 2*r, center = true, $fn=draft?6:20);
                    }
                            }
    /*
        // Otvory pro senzor
            Sirka_otvoru = 2;  // Šířka otvoru pro senzor ve směru od středu disku
              translate([0,0,-2])
                intersection() {
                    difference(){
                    union(){  // sensor teeth outer rim
                      cylinder(d = starter_pipe_d_middle-5, h = rpm_hole_h/4, $fn = draft?rpm_sensor_count:120);
                      translate([0, 0, - M3_nut_height - sensor_cap_height + rpm_sensor_h + starter_top_h - starter_rope_diameter])
                        cylinder(d1 = starter_pipe_d_middle, d2 = starter_rope_d - starter_rope_diameter/2, h = starter_rope_diameter, $fn = draft?rpm_sensor_count:120);
                    }
                cylinder(d = bearing_outer_diameter + Bwall*2+11.7-Sirka_otvoru*2, h = rpm_hole_h/4);
                    }

                    for (i=[0:rpm_sensor_count]) rotate([0, 0, (360/rpm_sensor_count)*i + (360/rpm_sensor_count)/2]){
                        linear_extrude(height = rpm_hole_h)
                        polygon(points=[[0,0],[starter_rope_d/2, ((starter_rope_d/2) * sin(360/rpm_sensor_count/2))/2], [starter_rope_d/2, -((starter_rope_d/2) * sin(360/rpm_sensor_count/2))/2]]);
                    }
                    cylinder(h=sensor_cap_height*0.7+Ribbon_part_w+0.25, d = starter_pipe_d_middle+0.2-End_Wall_Thickness*2);
                }
                */

           // Cylindrical holes for the right compilation with bell part 2
         rotate([0, 0, 35-rotor_delta_angle])
       translate([starter_pipe_d_middle/2-End_Wall_Thickness/2, 0, -5])
        cylinder(h = 10, d = 3.2, $fn = 20);
        rotate([0, 0, 180+35-rotor_delta_angle])
       translate([starter_pipe_d_middle/2-End_Wall_Thickness/2, 0, -5])
        cylinder(h = 10, d = 3.2, $fn = 20);

            // Mill butterfly
            Mill_butterfly(draft);
            }
    }

    // Mill butterfly
module Mill_butterfly(draft){

    Mill_Butterfly_count = 2;
          translate([0,0,-2])
          minkowski(){
            intersection() {

                difference(){
                union(){  // sensor teeth outer rim
                  cylinder(d = D_mill_disc-8, h = rpm_hole_h/4, $fn = draft?16:120);
                  translate([0, 0, - M3_nut_height - sensor_cap_height + rpm_sensor_h + starter_top_h - starter_rope_diameter])
                    cylinder(d1 = starter_pipe_d_middle, d2 = starter_rope_d - starter_rope_diameter/2, h = starter_rope_diameter, $fn = draft?16:120);
                }
                cylinder(d = D_mezikus+2*R_zaobleni, h = rpm_hole_h/4, $fn = draft?16:120);
                }

                for (i=[0:Mill_Butterfly_count]) rotate([0, 0, (360/Mill_Butterfly_count)*i + (360/Mill_Butterfly_count)/2]){
                    linear_extrude(height = rpm_hole_h)
                    polygon(points=[[0,0],[(D_mill_disc)/2, (((D_mill_disc)/2) * sin(360/Mill_Butterfly_count/2)- R_zaobleni)/1 ], [D_mill_disc/2, -(((D_mill_disc)/2) * sin(360/Mill_Butterfly_count/2)-R_zaobleni)/1]]);
                }


            }
         R_zaobleni = 2;
          cylinder(r=R_zaobleni, h= 20, , $fn = draft?6:30);
            }
}

///////
///////
///////
Pin_length_disc = 5.4;
Pin_slot_width = 1.55;
Pin_D_disc = 5;
Pin_D_cylinder = 4;
pcb_inner_diameter = bearing_outer_diameter + Bwall*2+2.7;
echo("PCB INNER DIAMETER", pcb_inner_diameter);

module mill_static(draft = true){
    difference(){

    cylinder(h=H_mill_disc, d=D_mill_disc, $fn = draft?16:120);


       //  Central hole
    translate([0,0,-5])
        cylinder(h=sensor_cap_height*0.7+Ribbon_part_w+0.25, d = pcb_inner_diameter, $fn = draft?16:120);

    // Hole for pin to bearings
    rotate([0, 0, 180])
        translate([pcb_inner_diameter/2,0,-5])
            //minkowski(){
                union(){
                    translate([-1, -Pin_slot_width/2, 0])
                        cube([1+ Pin_length_disc, Pin_slot_width, 10]);
                    translate([Pin_length_disc-1, 0, 0])
                        hull(){
                            translate([0, 1, 0])
                                cylinder(d=2.1, h=10, $fn=20);
                            translate([0, -1, 0])
                                cylinder(d=2.1, h=10, $fn=20);
                        }
                    //translate([-Pin_length_disc/2+0.8,0,0])
                    //    cube([2,Pin_D_disc - 2,10]);
                //}
                //R_zaobleni = 1;
                //cylinder(r=R_zaobleni, h= 5, , $fn = draft?5:30);
        }

      // Holes for self-cutting screws
         PosunZsl = 7.0;
        PosunYsl = 13.9;
        PrumerDirySloupek = 1.5 + 1;
       rotate([0, 0, 90])  {
        translate([PosunYsl, PosunZsl, -2])
     cylinder(d = PrumerDirySloupek, h = 20, $fn = 20);

           translate([-PosunYsl, PosunZsl, -2])
     cylinder(d = PrumerDirySloupek, h = 20, $fn = 20);

     translate([0, 22.6, -2])
        cylinder(d = PrumerDirySloupek, h = 20, $fn = 20);

   /*     // Hole for TFPROBE
        R = RotSpeed_dist;  // Vzdálenost otvorů pro senzor od středu
        rotate(52)
         translate([R-1.94,-tfprobe_width/2+2.05,-0.1])
         minkowski(){
        TFPROBE();
        cylinder(h = 7, r = 0.2);
        }  */
       }
     }
  }


tfprobe_lenght = 14;
tfprobe_width = 10;
tfprobe_thickness = 1.5; // Not sure
module TFPROBE(){
    difference(){
    cube([tfprobe_lenght,tfprobe_width,tfprobe_thickness + 5]);

//        translate([1.94-1,3.05-1,-0.1])
//        cube([2,2,1.7]);

    }
    }



//// Copper on the static plate - part 1

R_zaobleni = 0.3;
butteryfly_interconnection_thickness = 0.5 - R_zaobleni; // tloustka cesticky mezi elektrodami
butteryfly_interconnection_offset = 18; // Jak moc hluboko (oproti vnitrni hrane elektrod) ma byt veden propoj

 module Cu_butterfly(draft = true){

     intersection(){
          mill_static(draft);

            union(){
               Mill_butterfly(draft);

                Mill_Butterfly_count = 1;
                translate([0,0,-2])
                    minkowski(){
                        union(){
                            // Two distance cubes
                            rotate([0, 0, 45])
                                translate([0,D_mezikus/2-0.3,5])
                                    cube([0.1,butteryfly_interconnection_offset-0.5,10], center = true);
                            rotate([0, 0, 90+45])
                                translate([0,D_mezikus/2,5])
                                    cube([0.1,butteryfly_interconnection_offset-0.5,10], center = true);


                            // Connection of electrodes

                            intersection() {
                                difference(){
                                    cylinder(d = D_mezikus-butteryfly_interconnection_offset, h = rpm_hole_h/4, $fn = draft?16:120);
                                    cylinder(d = D_mezikus-butteryfly_interconnection_offset-butteryfly_interconnection_thickness, h = rpm_hole_h/4, $fn = draft?16:120);
                                }

                                for (i=[0:Mill_Butterfly_count]) rotate([0, 0, (360/Mill_Butterfly_count)*i + (360/Mill_Butterfly_count)/2]){
                                    linear_extrude(height = rpm_hole_h)
                                    polygon(points=[[0,0],[(D_mill_disc)/2, (((D_mill_disc)/2) * sin(90)+0.16) ], [D_mill_disc/2, -(((D_mill_disc)/2) * sin(90)+0.16)]]);
                                }
                            }
                        }
                        cylinder(r=R_zaobleni, h= 5, , $fn = draft?20:30);
                    }


           }
     }
}

 module Cu_inv_butterfly(draft){
     difference(){
         mill_static(draft);

         minkowski(){
             union(){
                 Cu_butterfly(draft);

                  rotate([0, 0, Zero_angle])
                 translate([0,Zero_dist,0])
                 cube([3,3,10],center = true);
                  rotate([0, 0, Zero_angle])
                 translate([0,RotSpeed_dist,0])
                 cube([3,3,10],center = true);
             }
             R_zaobleni = 1;
             cylinder(r=R_zaobleni, h= 20, , $fn = draft?5:30);
         }
         }

     }

module Cu_unmasked(draft = true){

     intersection(){
          mill_static(draft);

           minkowski(){
               Mill_butterfly(draft);

              R_zaobleni = 0.5;
             cylinder(r=R_zaobleni, h= 20, , $fn = draft?5:30);


           }
     }
}
//
translate([0,-80,5]) mill_rot(draft = true);

translate([0,80,-5])   mill_static(draft = true);
//translate([0, 0, -5]){projection() translate([0,0,0 ])   mill_static(draft = true);
//translate([0, 0, 0.1]) color("yellow") projection() Cu_butterfly(draft = true);
projection() Cu_inv_butterfly(draft=true);

//#translate([0, 0, -6]) Mezikus(draft=true);
echo(Zero_dist);
echo(RotSpeed_dist);
echo(Zero_angle);
