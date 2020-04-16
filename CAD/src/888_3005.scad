include<../parameters.scad>

include<lib/stdlib/sweep.scad>

height = 150;
height_bottom_part = 130;
depth_max = 200;

below_height = 30;
rudder_depth = 60;

N = 80;


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

module tail_horizontal(){
    translate([0, 0, -25])
        rotate([0, -elevator_pitch, 0])
            difference(){
                rotate([90, 0, 0]) elevator();
                cube([500, 20, 100], center=true);
                translate([10 + tail_horizontal_depth - 4, 0, 0]) cube([20, 500, 10], center=true);
                //translate([0, 0, -25])
                    rotate([90, 0, 0])
                        union(){
                            translate([20, 0, 0])
                                cylinder(d = 2.6, h = 120, center = true, $fn = 20);
                            translate([20+60, 0, 0])
                                cylinder(d = 2.6, h = 280, center = true, $fn = 20);
                        }
            }
}

tail_horizontal();
mirror([0, 1, 0])
    tail_horizontal();

module 888_3005() tail_horizontal();
