include<../parameters.scad>

include<lib/stdlib/sweep.scad>
use <888_3004.scad>


height = 150;
height_bottom_part = 130;
depth_max = 200;

below_height = 30;
rudder_depth = 60;

servo_z_shift = 2;

N = 80;




module tail_center(){
    difference(){

        union(){
        hull(){
            translate([0, 0, -below_height])
                sweep(gen_dat_2(M=below_height, dz=1,N=N), showslices = false);

            // tail pipe material
            translate([0, 0, -5-12])
                rotate([0, 90, 0])
                    cylinder(d = tail_pipe_d+3, h = 40);

            translate([60, 1, 0])
              translate([-35/2, -15/2, -below_height]) cube([23.5, 15, below_height/2]);
        }

        // kostky na pripevneni smerovky
            translate([-(15-0.5)/2 + 30, -(5-0.5)/2, 0]) cube([15-0.5, 5-0.5, 10-0.7]);
            translate([-(15-0.5)/2 + 30 + 80, -(5-0.5)/2, 0]) cube([15-0.5, 5-0.5, 10-0.7]);
        }

        // tail pipe hole
        translate([-20, 0, -5-12])
            rotate([0, 90, 0])
                cylinder(d = tail_pipe_d, h = 62.6, $fn=50);

        // tail pipe mount cut
        translate([-20, -tail_pipe_d/20, -below_height])
            cube([62.6, tail_pipe_d/10, tail_pipe_d ]);

        //tail mount screw
        translate([42/3, 0, -below_height +  0.6* M3_nut_diameter])
            rotate([90, 0, 0]){
                cylinder(d = M3_screw_diameter, h = 2*tail_pipe_d, $fn=50, center = true);
                translate([0, 0, tail_pipe_d/3])
                    cylinder(d = M3_nut_diameter, h = 10, $fn=6);
                translate([0, 0, -10-tail_pipe_d/3])
                    cylinder(d = M3_head_diameter_ISO7380, h = 10, $fn=60);
            }

        // Servo cable guide
        translate([42, 0, -below_height])
            cylinder(d = 10, h = below_height/3, $fn=50);

        translate([42, 0, -below_height + below_height/3])
                cylinder(d1 = 10, d2 = 0, h = 5, $fn=50);


        // beveled bottom bellow rudder
        translate([0, 0, -5*below_height])
           rotate([0, -35, 0])
                translate([depth_max - rudder_depth -2, -10, -below_height])
                    cube([depth_max, 20, 2*below_height]);


        // lightennig and crash absorption hole
        translate([0, 0, -below_height/2])
           rotate([90, 0, 0])
              hull(){
                hole1 = 15;
                hole2 = 15;
                hole3 = 22;
                    translate([depth_max - rudder_depth -14, 2, 0])
                        cylinder(d = hole1, h = rudder_depth, $fn=50, center = true);

                    translate([depth_max - rudder_depth -24, hole2/2 - hole3/2 + (hole1/2+2-hole3/2), 0])
                        cylinder(d = hole2, h = rudder_depth, $fn=50, center = true);


                    translate([depth_max - rudder_depth -50, hole1/2+2-hole3/2, 0])
                        cylinder(d = hole3, h = rudder_depth, $fn=50, center = true);
                }



        // Otvor pro svislou osu
        rotate([0, -rudder_inclination, 0])
            translate([depth_max - rudder_depth - 15, 0, -2.3*below_height])
                cylinder(d = 2.5, h = height_bottom_part, $fn = 20);

        // krabice pro servo
        translate([60, 1, 0]) union(){
            //translate([-25/2, -11/2, -35]) cube([25, 11, 35]);
            translate([-23.5/2, -10.5/2, -40]) cube([23.5, 10.5, 35]);
            translate([-35/2, -10.5/2, -below_height+20+servo_z_shift]) cube([35, 10.5+5, 35]);
            translate([-23.5/2, -10.5/2, -20+3-42]) cube([23.5, 10.5, 35]);
            translate([-35/2, -1.7/2, -below_height-1]) cube([35, 10.5/2 +1.7/2, 35]);
            translate([-35/2, -8/2, -below_height-1]) cube([20, 8, servo_z_shift+6]);

            for(i=[1, -1])
              translate([i*30/2, 0, -below_height+15+servo_z_shift])
                rotate([-90, 0, 0])
                {
                // mounting screw holes
                    cylinder(d=2, h=13, center = true, $fn = 20);
                    translate([0, 0, 6])
                        cylinder(d=2.5, h=13, center = true, $fn = 20);
                    translate([0, 0, 3])
                      cylinder(d=5.2, h=10, $fn = 20);
                }
        }

        // kostky na pripevneni smerovky, otvory v nich na sroub a vystuzeni
        for(x = [80+30, 30]) translate([x, 0, 5]){
            rotate([90, 0, 0]) cylinder(d = M3_screw_diameter, h = 20, center = true, $fn = 30);
            translate([13/3, 0, 0]) cylinder(d=1.5, h=20, center=true);
            translate([-13/3, 0, 0]) cylinder(d=1.5, h=20, center=true);
        }

        // generate correct shape for moving rudder part
        for(x = [-30:60:30]){
            translate([depth_max  + 15, 0, -1.3*height_bottom_part])
                rotate([0, -rudder_inclination, 0])
                    rotate([0, 0, x])
                        rotate([0, rudder_inclination, 0])
                            translate([-depth_max-15, 0, 1.3*height_bottom_part])
                                tail_rudder(servo_hand = false, axis = false);
        }
    }

    // specific generator function
    function gen_dat_2(M=10,dz=0.1,N=10) = [for (i=[0:dz:M/2])
      let( L = extra_length_2(i))
      let( af = vec3D(
          airfoil_data([0,0,0.0501+thickness_2(i)], L=extra_length_2(i), N = N)))
      T_(edge_shift_2(i), 0, (i)*2, af)];  // translate airfoil

    function edge_shift_2(i) = 0;
    //function thickness_2(i) = 0.03;   //0.5*sin(i*i)+.1;

    //function edge_shift(i) = (i/60)^(22)+i*0.75;
    function thickness_2(i) = (1-i/100)*0.001;   //0.5*sin(i*i)+.1;

    function extra_length_2(i) = depth_max;

}


width = 320;
tail_horizontal_depth = 130;

tail_center();


module 888_3001() tail_center();
