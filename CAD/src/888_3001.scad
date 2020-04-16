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

module tail_vertical_bottom(){
    difference(){
        tail_vertical();

    // space for rudder
        translate([0, -10, height_bottom_part])
            cube([depth_max, 20, height_bottom_part]);
        translate([depth_max - rudder_depth, -10, 0])
            cube([depth_max, 20, height_bottom_part+1]);
        translate([depth_max - rudder_depth, 0, 0])
            cylinder(d = 12, h = 200);

    translate([30, 0, 0]) cube([15, 5, 20], center = true);
    translate([30+80, 0, 0]) cube([15, 5, 20], center = true);

    translate([30, 0, 5]) rotate([90, 0, 0]) cylinder(d=M3_screw_diameter, h=50, center=true, $fn = 60);
    translate([30+80, 0, 5]) rotate([90, 0, 0]) cylinder(d=M3_screw_diameter, h=50, center=true, $fn = 60);

    }
}

tail_vertical_bottom();


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



module tail_vertical_top(){
    difference(){
        tail_vertical();

        translate([0, -10, 0])
            cube([depth_max, 20, height_bottom_part]);
        translate([depth_max-2, -10, 0])
            cube([depth_max, 20, height]);

        translate([depth_max - rudder_depth, 0, -0.5])
            cylinder(d = 2.5, h = height_bottom_part+10, $fn = 20);
    }
}
tail_vertical_top();

module tail_center(){
difference(){

    hull(){
        translate([0, 0, -below_height])
            sweep(gen_dat_2(M=below_height, dz=1,N=N), showslices = false);
        intersection(){
            union(){
                elevator(position = 1);
                mirror([0, 1, 0])
                    elevator(position = 1);
            }
            cube([500, 20, 100], center=true);
        }

        translate([0, 0, -5-2])
            rotate([0, 90, 0])
                cylinder(d = 10.4+2, h = 40);
    }

    // Otvor na podelnou tyc
    translate([-20, 0, -5-2])
        rotate([0, 90, 0])
            cylinder(d = 10.4, h = 80, $fn=50);

    // Otvory na tycky pro privpevneni vyskovky
    translate([0, 0, -25])
        rotate([90, -elevator_pitch, 0])
            union(){
                translate([20, 0, 0])
                    cylinder(d = 2.5, h = 100, center = true, $fn = 20);
                translate([20+60, 0, 0])
                    cylinder(d = 2.5, h = 100, center = true, $fn = 20);
            }

    difference(){
        translate([depth_max - rudder_depth - 5, -10, -below_height])
            cube([depth_max, 20, below_height]);
        hull(){
        translate([5, -10, -below_height])
            cube([depth_max - rudder_depth - 10, 20, 10]);
        translate([depth_max - rudder_depth, 0, -below_height+10-50])
            cylinder(d = 12, h=50, $fn=50);
        }

    }
    translate([depth_max - rudder_depth, 0, -below_height+10])
        cylinder(d = 12, h=80);

    // Otvor pro svislou osu
    translate([depth_max - rudder_depth, 0, -below_height+2])
        cylinder(d = 2.5, h=60, $fn = 20);

    translate([70, 0, 0]) union(){
        translate([-25/2, -13/2, -35]) cube([25, 13, 35]);
        translate([-35/2, -13/2, -20]) cube([35, 13, 35]);
        translate([-35/2, -13/2, -20+10]) cube([35, 13+5, 35]);
        hull(){
            translate([-25/2, -13/2, -20-2]) cube([25, 13, 1]);
            translate([-35/2, -13/2, -35]) cube([35, 13, 1]);
        }
        translate([-28/2, 0, -20+10]) cylinder(d=2, h=100, center = true, $fn = 20);
        translate([+28/2, 0, -20+10]) cylinder(d=2, h=100, center = true, $fn = 20);

    }
}

// specific generator function
function gen_dat_2(M=10,dz=0.1,N=10) = [for (i=[0:dz:M/2])
  let( L = extra_length_2(i))
  let( af = vec3D(
      airfoil_data([0,0,0.05+thickness_2(i)], L=extra_length_2(i), N = N)))
  T_(edge_shift_2(i), 0, (i)*2, af)];  // translate airfoil

function edge_shift_2(i) = 0;
function thickness_2(i) = 0.03;   //0.5*sin(i*i)+.1;
function extra_length_2(i) = depth_max;

}

tail_center();

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
            }
}

tail_horizontal();
//mirror([0, 1, 0])
//    tail_horizontal();


module 888_3001() tail_center();
