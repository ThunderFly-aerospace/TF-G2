include<../parameters.scad>
include<lib/stdlib/sweep.scad>
use <888_3004.scad>


N = 100;
height = 120;
depth_max = 100;


function edge_shift(i) = -14;
function thickness(i) = 0.08;
function extra_length(i) = sin(i*3)*40+120;

// specific generator function
function gen_dat(M=10,dz=0.1,N=10) = [
      for (i=[0:dz:M/2])
            let( L = extra_length(i))
      let( af = vec3D(
            airfoil_data([0,0,0.05+thickness(i)],
            L=extra_length(i),
            N = N)))
      T_(edge_shift(i), 0, (i)*2, af)
  ];  // translate airfoil



module wing_holes(){
    
        cylinder(d = pylon_pipe_d+0.2, h = height*3, center=true, $fn=50);
    translate([20, 0, 0])
      hull(){
          translate([-7.5, 0, 0]) cylinder(d = 12.5, h = height*3, center=true, $fn=50);
          translate([4.5, 0, 0]) cylinder(d = 12.5, h = height*3, center=true, $fn=50);
      }
      
      hull(){
          translate([50-15, 0, -0.1])
                cylinder(d=6.5, h=10+0.1, $fn=40);
          translate([50+10, 0, -0.1])
                cylinder(d=6.5, h=10+0.1, $fn=40);
      }
      
  }


module 888_3010(){



  difference(){
        union(){
            sweep(gen_dat(M=height, dz=1,N=N));
            hull(){
               // translate([20, 0, 0]) scale([4,2,3]) sphere(d=20);
            }
        }
        wing_holes();
  }

}


module 888_3010_skirt() rotate([180, 0, 0]) {difference() {
    intersection(){
    hull(){
        
            difference(){
                translate([0, 0, 0]) sweep(gen_dat(M=1, dz=1,N=N));
                //translate([30, -10, 0]) cube([200, 20, 30]);
            }
            translate([-4, 0, 15-1]) cylinder(d = 20, h = 1);
            //translate([15, -5, 15]) cylinder(d = 20, h = 0.1);
            //translate([15, 5, 15]) cylinder(d = 20, h = 0.1);
            translate([17, -8, 10]) cylinder(d = 21, h =5);
            translate([17, 8, 10]) cylinder(d = 21, h = 5);
    }
            cylinder(h=30, r = 26, $fn=80);
    }
    
    intersection(){
        translate([0, 0, -5]) wing_holes();
            cylinder(h=30, r = 26-0.5, $fn=80);
    
    }
}
    intersection(){
        difference(){
            cylinder(d = 15, h=5, $fn=80, $fn=50);
            cylinder(d=pylon_pipe_d+0.2, h=10, $fn=50);
        }
        cube([10, 50, 20], center=true);
    }
}


//888_3010();


888_3010_skirt();
