include<../parameters.scad>

include<lib/stdlib/sweep.scad>

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

            translate([0, 0, -5-12])
                rotate([0, 90, 0])
                    cylinder(d = 10.4+2, h = 40);


            translate([60, 1, 0])
              translate([-35/2, -15/2, -below_height]) cube([23.5, 15, below_height/2]);
        }

        // kostky na pripevneni smerovky
            translate([-(15-0.5)/2 + 30, -(5-0.5)/2, 0]) cube([15-0.5, 5-0.5, 10-0.7]);
            translate([-(15-0.5)/2 + 30 + 80, -(5-0.5)/2, 0]) cube([15-0.5, 5-0.5, 10-0.7]);
        }

        // Otvor na podelnou tyc
        translate([-20, 0, -5-12])
            rotate([0, 90, 0])
                cylinder(d = 10.4, h = 62.6, $fn=50);

         translate([42 - 35, 0, -5-12])
            rotate([90, 0, 0]){
                cylinder(d = M3_screw_diameter, h = 62.6, $fn=50, center = true);
                translate([0, 0, 10/2+1]) cylinder(d = M3_nut_diameter, h = 10, $fn=6);
                translate([0, 0, -10-10/2-1]) cylinder(d = M3_nut_diameter, h = 10, $fn=12);
            }

        // Otvor na vyvod kabelu
        translate([42, 0, -5-12])
            rotate([0, 180, 0])
                cylinder(d = 10, h = 30, $fn=50);


        // vyrez na otocnou cast ostruhy
        difference(){
            translate([depth_max - rudder_depth -2, -10, -below_height])
                cube([depth_max, 20, below_height]);
            hull(){
            translate([5, -10, -below_height])
                cube([depth_max - rudder_depth - 10, 20, 10]);
            translate([depth_max - rudder_depth, 0, -below_height+10-50])
                cylinder(d = 6, h=50, $fn=50);
            }

        }

        // prostor pro otaceni smerovky
        translate([depth_max - rudder_depth, 0, -below_height+10])
            cylinder(d = 10, h=80, $fn=30);

        // Otvor pro svislou osu
        translate([depth_max - rudder_depth, 0, -below_height+2])
            cylinder(d = 2.5, h=60, $fn = 20);

        // krabice pro servo
        translate([60, 1, 0]) union(){
            //translate([-25/2, -11/2, -35]) cube([25, 11, 35]);
            translate([-23.5/2, -10.5/2, -40]) cube([23.5, 10.5, 35]);
            translate([-35/2, -10.5/2, -below_height+20+servo_z_shift]) cube([35, 10.5+5, 35]);
            translate([-23.5/2, -10.5/2, -20+3-42]) cube([23.5, 10.5, 35]);
            translate([-35/2, -1.7/2, -below_height-1]) cube([35, 1.7, 35]);
            translate([-35/2, -8/2, -below_height-1]) cube([20, 8, servo_z_shift+6]);

            for(i=[1, -1])
              translate([i*27.5/2, 0, -below_height+15+servo_z_shift])
                rotate([-90, 0, 0])
                {
                  cylinder(d=2, h=13, center = true, $fn = 20);
                  translate([0, 0, 6])
                    cylinder(d=4, h=10, $fn = 20);
                }
        }

        // kostky na pripevneni smerovky, otvory v nich na sroub a vystuzeni
        for(x = [80+30, 30]) translate([x, 0, 5]){
            rotate([90, 0, 0]) cylinder(d = M3_screw_diameter, h = 20, center = true, $fn = 30);
            translate([13/3, 0, 0]) cylinder(d=1.5, h=20, center=true);
            translate([-13/3, 0, 0]) cylinder(d=1.5, h=20, center=true);
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

module elevator(position = 0){
    translate([0, 0, -25]*position)
        rotate([90, -elevator_pitch, 0]*position)
    sweep(gen_dat(M=width/2, dz=1,N=N), showslices = false);

    // specific generator function
    function gen_dat(M=10,dz=0.1,N=10) = [for (i=[0:dz:M/2])
      let( L = extra_length_elevator(i))
      let( af = vec3D(
          airfoil_data([0,0,0.05+thickness_elevator(i)], L=extra_length_elevator(i), N = N)))
      T_(edge_shift_elevator(i), 0, (i)*2, af)];  // translate airfoil

    function edge_shift_elevator(i) = (i/55)^(11.5)+i*0.5;
    //function edge_shift(i) = (i/60)^(10)+i*0.75;
    function thickness_elevator(i) = 0.003;   //0.5*sin(i*i)+.1;
    function extra_length_elevator(i) = tail_horizontal_depth - edge_shift_elevator(i);
}



tail_center();

module 888_3001() tail_center();
