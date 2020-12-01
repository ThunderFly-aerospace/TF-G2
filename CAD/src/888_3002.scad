include<../parameters.scad>

include<lib/stdlib/sweep.scad>

height = 150;
height_bottom_part = 130;
depth_max = 200;

below_height = 30;
rudder_depth = 60;

N = 80;
rudder_radius = 6;

module tail_vertical(){

    sweep(gen_dat(M=height, dz=1,N=N), showslices = false);

    // specific generator function
    function gen_dat(M=10,dz=0.1,N=10) = [for (i=[0:dz:M/2])
      let( L = extra_length(i))
      let( af = vec3D(
          airfoil_data([0,0,0.05+thickness(i)], L=extra_length(i), N = N)))
      T_(edge_shift(i), 0, (i)*2, af)];  // translate airfoil

    function edge_shift(i) = (i/60)^(22)+i*0.75;
    function thickness(i) = 0.0001;   //0.5*sin(i*i)+.1;
    function extra_length(i) = depth_max - edge_shift(i);
}

module tail_vertical_bottom(){
    difference(){
        tail_vertical();

    // space for rudder
    difference (){
      union(){
        translate([depth_max - rudder_depth, -rudder_radius, 0])
            cube([depth_max, rudder_radius*2, height]);
        translate([depth_max - rudder_depth, 0, 0])
            cylinder(r = rudder_radius, h = height );
      }

      // beveled top of rudder
        translate([depth_max - rudder_depth - rudder_radius -5, 0, height_bottom_part - 10])
            cylinder(r1 = rudder_radius/2, r2 = 4*rudder_radius, h = height - height_bottom_part + 10 );
    }

    translate([depth_max - rudder_depth, 0, -0.5])
      cylinder(d = 2.5, h = height_bottom_part+10, $fn = 20);


    translate([30, 0, 0]) cube([15, 5, 20], center = true);
    translate([30+80, 0, 0]) cube([15, 5, 20], center = true);

    translate([30, 0, 5]) rotate([90, 0, 0]) cylinder(d=M3_screw_diameter, h=50, center=true, $fn = 60);
    translate([30+80, 0, 5]) rotate([90, 0, 0]) cylinder(d=M3_screw_diameter, h=50, center=true, $fn = 60);

    }
}

tail_vertical_bottom();
module 888_3002() tail_vertical_bottom();
