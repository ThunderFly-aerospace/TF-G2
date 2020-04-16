include<../parameters.scad>

include<lib/stdlib/sweep.scad>

height = 150;
height_bottom_part = 130;
depth_max = 200;

below_height = 30;
rudder_depth = 60;

N = 80;

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


rudder_below = 10;
module tail_rudder() translate([0, 0, -rudder_below]){
    difference(){
        intersection(){
            tail_vertical();

        // space for rudder
            hull(){
                translate([depth_max - rudder_depth+10, -10, 0])
                    cube([rudder_depth - 10-3, 20, height_bottom_part+rudder_below-.5]);
                translate([depth_max - rudder_depth, 0, 0])
                    cylinder(d = 12-2, h = height_bottom_part+rudder_below-0.5, $fn=60);
            }
        }
        translate([depth_max - rudder_depth, 0, -0.5])
            cylinder(d = 2.5, h = height_bottom_part+rudder_below+1, $fn = 60);
    }

    translate([depth_max - rudder_depth, 0, 0]) difference(){
        hull(){
            translate([10, 0, 1]) cube([10, 2, 2], center = true);
            translate([0, 20, 0]) cylinder(d = 7, h=2, $fn=40);
        }
        translate([0, 20, 0]) cylinder(d = 2.6, h=2, $fn=40);
    }
    /* difference(){
        union(){
            translate([30, 0, 5-0.5])
                cube([15-1, 5-1, 10], center=true);
            translate([30+80, 0, 5-0.5])
                cube([15-1, 5-1, 10], center=true);
        }
        translate([30, 0, 5])
            rotate([90, 0, 0])
                cylinder(d=M3_screw_diameter, h=50, center=true, $fn = 30);
        translate([30+80, 0, 5])
            rotate([90, 0, 0])
                cylinder(d=M3_screw_diameter, h=50, center=true, $fn = 30);
    } */
}
tail_rudder();

module 888_3004 tail_rudder();
