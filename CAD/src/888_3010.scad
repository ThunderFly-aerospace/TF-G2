include<../parameters.scad>
include<lib/stdlib/sweep.scad>
use <888_3004.scad>


N = 100;
height = 100;
depth_max = 100;


module 888_3010(){



    function edge_shift(i) = -14;
    function thickness(i) = 0.12;
    function extra_length(i) = sin(i*3.6)*40+80;

    // specific generator function
    function gen_dat(M=10,dz=0.1,N=10) = [for (i=[0:dz:M/2])
      let( L = extra_length(i))
      let( af = vec3D(
          airfoil_data([0,0,0.05+thickness(i)], L=extra_length(i), N = N)))
      T_(edge_shift(i), 0, (i)*2, af)];  // translate airfoil


  difference(){
    sweep(gen_dat(M=height, dz=1,N=N));
    cylinder(d = pylon_pipe_d+0.2, h = height*3, center=true, $fn=50);
    translate([20, 0, 0])
      hull(){
          translate([-8, 0, 0]) cylinder(d = 12.5, h = height*3, center=true, $fn=50);
          translate([5, 0, 0]) cylinder(d = 11, h = height*3, center=true, $fn=50);
      }
  }

}



888_3010();
