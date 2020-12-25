include <../parameters.scad>
include <lib/stdlib/polyScrewThread_r1.scad>




module 888_4008(draft = true){



// TODO: Je potreba procistit parametry, po predelani na spulku zde urcite mnoho parametru je nevyuzitych. Pripadne je okomentovat. [Roman, 2020/11]

    angle_between_blades = 360 / rotor_blades_count;

    //shaft_diameter = 6.1;
    thickness = 2.3;
    top_thickness = 3;
    //blade_screws_distance = (16.47+11.86)/2;

    height_from_rotor_nut = 29.5;

    // %cylinder(d = 5, h = height_from_rotor_nut);

    rotor_center_r=12 + 1;
    edge_distance_from_center = 7.5;
    spacer_disc_diameter = 3 * M3_screw_diameter;
    spare_disc_height = 0.6;

    starter_top_r=14;
    starter_top_h=M3_screw_head_height+3;
    starter_pipe_d_top = 20;
    starter_pipe_d_middle = 35;
    starter_pipe_d_bottom = 20;
    starter_neck_r=10;
    starter_neck_h=1;
    starter_bottom_h=5;
    starter_rope_diameter=2;

    starter_rope_d = 38;

    sensor_cap_height=starter_top_h+starter_neck_h+starter_bottom_h;

    rpm_sensor_inner_r=12.5;
    rpm_sensor_thickness = 1.3;
    rpm_sensor_h = height_from_rotor_nut - starter_top_h;
    rpm_sensor_base_h= 2;
    rpm_sensor_count=16;
    rpm_hole_h = 50;
    //rpm_hole_width = 7;

    screws_head_d=7;
    screws_h=14;



    translate([0,0,-top_thickness])
        rotate([0,0, rotor_delta_angle]) {
            difference() {
                union(){
                    difference()
                    {
                            union()
                            {
                              translate([0,0,0])
                                  cylinder(r1 = rotor_center_r, d2=starter_rope_d, h = top_thickness+starter_top_h, $fn = draft?rpm_sensor_count:120);

                                translate([0,0, top_thickness + starter_top_h])
                                    cylinder(h=rpm_sensor_h, d=starter_rope_d, $fn=draft?rpm_sensor_count:120);
                            }

                          translate([0,0,top_thickness + M3_nut_height])
                                cylinder(h=sensor_cap_height/2, d1=starter_pipe_d_top, d2 = starter_pipe_d_middle, $fn=draft?rpm_sensor_count:120);
                          translate([0,0,top_thickness + M3_nut_height + sensor_cap_height/2])
                                cylinder(h=sensor_cap_height, d1=starter_pipe_d_middle, d2 = starter_pipe_d_middle, $fn=draft?rpm_sensor_count:120);
                          translate([0,0,top_thickness + M3_nut_height + 1.5*sensor_cap_height])
                                cylinder(h=sensor_cap_height, d1=starter_pipe_d_middle, d2 = starter_pipe_d_bottom, $fn=draft?rpm_sensor_count:120);
                    }
                }

              //hex_screw(15,4,55,30,1.5,2,24,8,0,0);
              // Zavit pro namotani provazku
              translate([0, 0, starter_top_h+3]) difference(){
                cylinder(d = starter_rope_d+10, h = 19-0.1);
                screw_thread(starter_rope_d, 3, 50, 22, 2, 0);
              }

              // Otvor na zastrceni provazku
              translate([0, 0, starter_top_h+top_thickness + 19 ])
                  rotate([-90, 0, -rotor_delta_angle])
                    cylinder(d = starter_rope_diameter, h = 50, center = false, $fn = 10);

              // Cut for rope fix before start
              rotate([0, 0, 180])
                 translate([-starter_pipe_d_middle/2, starter_pipe_d_top/2 + (starter_pipe_d_middle/2 - starter_pipe_d_top/2)/2, starter_top_h - starter_top_h/3])
                    rotate([30, 3, 0])
                      cube([starter_pipe_d_middle, starter_pipe_d_middle, starter_rope_diameter]);


              // Otvory pro senzor
              translate([0,0,top_thickness + M3_nut_height + sensor_cap_height])
                intersection() {
                    cylinder(d = starter_pipe_d_middle, h = rpm_hole_h, $fn = draft?rpm_sensor_count:120);

                    for (i=[0:rpm_sensor_count]) rotate([0, 0, (360/rpm_sensor_count)*i]){
                        linear_extrude(height = rpm_hole_h)
                        polygon(points=[[0,0],[starter_rope_d/2, ((starter_rope_d/2) * sin(360/rpm_sensor_count/2))/2], [starter_rope_d/2, -((starter_rope_d/2) * sin(360/rpm_sensor_count/2))/2]]);
                    }
                }

              // rotor axis
              cylinder(d = M3_screw_diameter+0.1, h = 3* thickness+starter_top_h, center = true, $fn = 20);

              // Rotor nut
              translate([0,0,top_thickness - 0.5 * M3_nut_height])
                  cylinder(d = M3_nut_diameter + global_clearance, h = M3_nut_height+5, $fn = 6);

              translate([0, 0, thickness/2])
              for (i = [1:rotor_blades_count]){
                  rotate([0, 0, i*angle_between_blades + angle_between_blades/2 + 180])
                      translate([0, edge_distance_from_center+15/2, -10/2+thickness/2])
                      {
                          cube([30, 15, 10], center = true);
                          translate([0,-7.5,5])
                              rotate([atan2(starter_top_h,(16-edge_distance_from_center)),0,0])
                                  translate([-15,0,-10])
                                      cube([30,15,10]);
                      }
                  angle=(rotor_blades_count/2 == round(rotor_blades_count/2))? (i*angle_between_blades):i*angle_between_blades - angle_between_blades/2;
                  rotate([0,0, angle])
                  {
                          translate([0, 3 + 4.5 + blade_mount_screw/2, 0])
                              cylinder(d = blade_mount_screw, h = 2* (thickness+sensor_cap_height), center = true, $fn = 20);
                  }

                  hull(){rotate([0,0, angle])
                    {
                          translate([0, 3 + 4.5 + blade_mount_screw/2, screws_h/2+thickness/2])
                              cylinder(d = screws_head_d, h = screws_h, center = true, $fn = 20);
                    }
                          translate([0, 0, screws_h/2+thickness/2])
                    cylinder(d = 5, h = screws_h*2.5);
                  }

              }
              // cross section for model construction
              //cube(100);

            }
        }
}


888_4008();
