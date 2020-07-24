include <../parameters.scad>

module 888_4008(){

    angle_between_blades = 360 / rotor_blades_count;

    //shaft_diameter = 6.1;
    thickness = 2.3;
    //blade_screws_distance = (16.47+11.86)/2;
    
    rotor_center_r=12 + 1;
    edge_distance_from_center = 7.5;
    spacer_disc_diameter = 3 * M3_screw_diameter;
    spare_disc_height = 0.6;   
    
    starter_top_r=14;
    starter_top_h=M3_screw_head_height+3;
    starter_pipe_r=8;
    starter_neck_r=10;
    starter_neck_h=1; 
    starter_bottom_h=4;
    
    sensor_cap_height=starter_top_h+starter_neck_h+starter_bottom_h;
  
    rpm_sensor_inner_r=12.5;
    rpm_sensor_thickness = 1.4;
    rpm_sensor_h=6;
    rpm_sensor_count=16;
    
    screws_head_d=7;
    screws_h=14;

 

    translate([0,0,thickness/2])
        rotate([0,0, rotor_delta_angle]) {
            difference() {
                union(){                    
                    difference()
                    {    
                            union()
                            {
                                translate([0,0,starter_top_h/2])
                                    cylinder(r1 = rotor_center_r, r2=starter_top_r, h = thickness+starter_top_h, center = true, $fn = 100);
                                translate([0,0,thickness/2+starter_top_h+starter_neck_h/2])
                                    cylinder(h=starter_neck_h+0.3,r=starter_neck_r,center=true, $fn=40);
                                
                                translate([0,0,thickness/2+starter_top_h+starter_neck_h+starter_bottom_h/2])
                                    cylinder(h=starter_bottom_h,r1=starter_neck_r,r2=rpm_sensor_inner_r+rpm_sensor_thickness,center=true,$fn=100);
                                
                                translate([0,0,thickness/2+sensor_cap_height+rpm_sensor_h/2])
                                    cylinder(h=rpm_sensor_h,r=rpm_sensor_inner_r+rpm_sensor_thickness,center=true,$fn=100);
                                    
                            }
                            
                            union()
                            {
                                translate([0,0,thickness/2+sensor_cap_height+1])                                
                                    cylinder(h=2*sensor_cap_height,r=starter_pipe_r,center=true, $fn=40);
                                
                                translate([0,0,thickness/2+starter_top_h+starter_bottom_h+starter_neck_h+rpm_sensor_h])                                
                                    cylinder(h=2*rpm_sensor_h,r=rpm_sensor_inner_r,center=true, $fn=40);
                                
                                  for(r = [0: 360/(rpm_sensor_count): 180])
                                        rotate([0, 0, r])
                                          translate([0, 0, thickness/2+sensor_cap_height+5])
                                            cube([50, 2.5, 10], center = true);
                            }
                            
                            
                            
                    }
                    translate([0,0,-thickness/2])
                        cylinder(d = spacer_disc_diameter, h = thickness + spare_disc_height, $fn = 100);
                }

                cylinder(d = M3_screw_diameter, h = 3* thickness+starter_top_h, center = true, $fn = 20);
                translate([0,0,thickness - M3_nut_height/4])
                    cylinder(d = M3_nut_diameter+0.15, h = M3_nut_height, center = true, $fn = 6);

                for (i = [1:rotor_blades_count]){
                    rotate([0, 0, i*angle_between_blades + angle_between_blades/2 + 180])
                        translate([0, edge_distance_from_center+15/2, -10/2+thickness/2])
                        {
                            cube([30, 15, 10], center = true);  
                            translate([0,-7.5,5])
                                rotate([atan2(starter_top_h,(starter_top_r-edge_distance_from_center)),0,0])
                                    translate([-15,0,-10])
                                        cube([30,15,10]);
                        }             
                    angle=(rotor_blades_count/2 == round(rotor_blades_count/2))? (i*angle_between_blades):i*angle_between_blades - angle_between_blades/2;    
                    rotate([0,0, angle])
                    {
                            translate([0, 3 + 4.5 + blade_mount_screw/2, 0])
                                cylinder(d = blade_mount_screw, h = 2* (thickness+sensor_cap_height), center = true, $fn = 20);
                            translate([0, 3 + 4.5 + blade_mount_screw/2, screws_h/2+thickness/2])    
                                cylinder(d = screws_head_d, h = screws_h, center = true, $fn = 20);    
                    }
                    
                }
            }
            
            
        }
}

888_4008();