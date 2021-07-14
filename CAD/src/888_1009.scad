
include <../parameters.scad>
use <888_1007.scad>
use <888_1010.scad>



module 888_1009_bottom() {
 translate([-pylon_silentblocks_base_distance/2, 0, 0]) rotate([0, 0, 180]) linear_extrude(2+0.5) text(">", halign="center", valign="center");
 translate([pylon_silentblocks_base_distance/2, 0, 0]) rotate([0, 0, 90]) linear_extrude(2+0.5) text(week, halign="center", valign="center", size=4);
  difference(){
union(){


    translate([-40*0.3, 0, 0])
        airfoil(naca = 0035, L = 40, N = 50, h= 20+3, open = false);


  for(x = [-0.5, 0.5], y=[-0.5, 0.5])
    translate([(pylon_silentblocks_base_distance)*x, (pylon_silentblocks_base_distance)*y, 0])
      {
          cylinder(d=10, h = 2, $fn=30);
          translate([0, 0, 2])
            cylinder(d1=10, d2=M3_nut_diameter, h = 2, $fn=30);
      }

  for(y = [-0.5, 0.5])
    {
      hull()
        for(x = [-0.5, 0.5])
          translate([(pylon_silentblocks_base_distance)*x, (pylon_silentblocks_base_distance)*y, 0])
            cylinder(d=8, h = 2);
      translate([0, pylon_silentblocks_base_distance*y, 2])
          cube([pylon_silentblocks_base_distance, 2, 2], center=true);
    }
  for(x = [-0.5, 0.5])
    hull()
      for(y = [-0.5, 0.5])
        translate([(pylon_silentblocks_base_distance)*x, (pylon_silentblocks_base_distance)*y, 0])
            cylinder(d=8, h = 2);

    for(r=[0,1,2,3])
        rotate([0,0,90*r]){
            hull(){
                cylinder(d=M3_nut_diameter, h=10);
                translate([pylon_silentblocks_base_distance*0.5, pylon_silentblocks_base_distance*0.5, 0])
                    cylinder(d=M3_screw_diameter, h=3);
            }
            hull(){
                cylinder(d=M3_nut_diameter, h=2);
                translate([pylon_silentblocks_base_distance*0.5, pylon_silentblocks_base_distance*0.5, 0])
                    cylinder(d=M3_nut_diameter, h=2);
            }
        }

}

    translate([0, 0, 2])
        cylinder(d= pylon_pipe_d, h = 50, $fn=30);
    translate([0, 0, -2])
        cylinder(d= pylon_pipe_d-2, h = 50, $fn=30);
    hull(){
        translate([15, 0, -2])
            cylinder(d= 8, h = 50, $fn=30);
        translate([21, 0, -2])
            cylinder(d= 4, h = 50, $fn=30);
    }
    translate([0, -1, 2])
        cube([20, 2, 50]);
    translate([pylon_pipe_d/2+2, 0, 16])
        rotate([-90, 0, 0]){
            cylinder(d=M3_screw_diameter, h=20, center=true, $fn=30);
            translate([0, 0, -10-3])
                cylinder(d=M3_nut_diameter, h=20, center=true, $n=30);
            translate([0, 0, 10+3])
                cylinder(d=M3_nut_diameter, h=20, center=true, $fn=6);
        }


        translate([-40*0.3, 0, 20])
            hollow_airfoil(naca = 0035, L = 40, N = 50, h= 22, open = true, wall_thickness=0.6);

  // otvory pro prisroubovani silentbloku
  for(x = [-0.5, 0.5], y=[-0.5, 0.5])
    translate([(pylon_silentblocks_base_distance)*x, (pylon_silentblocks_base_distance)*y, -0.5])
      cylinder(d=M3_screw_diameter, h = 10, $fn=30);
}


}



pylon_adapter_top_width = 31;


top_break_roof = 3;
top_break_side = 2;




module pylon_pipes(d = pylon_pipe_d, below = 10, above = 10, shift=2){

    // zadni prava
    translate([0, 0, 0])
        translate([0, 0, -below + shift])
            cylinder(d = d, h = 150+below+above, $fn=20);
}

color("gray") pylon_pipes(below=0, above=0);

888_1009_bottom();
%translate([0, 0, -8]) 888_1007();
%rotate([0, 0, 180]) translate([7.5, 0, -13.5+180+3]) 888_1010();
%translate([0, 0, -8]) pylon_silentblocks();



module 888_1009_drill(){

  difference(){
    translate([-15/2, -5, -1])
        cube([15, 15, 150+1+5]);
    cylinder(d=4.3, h=170, $fn=30);
    translate([-0.5, 0, -2])
        cube([1, 10, 180]);
    translate([-7, -2, 150])
        cube([14, 20, 1.5]);

    for(z = [5, 150-5]){
      translate([0, M3_screw_diameter/2+pylon_pipe_d/(2*3), z]) {
        rotate([0, 90, 0])
          cylinder(d=3.1, h=20, center=true, $fn=20);
      }
    }
    for(z = [5+10, 150-5-10]){
      translate([0, 5, z])
        rotate([0, 90, 0]) {
            cylinder(d=M3_screw_diameter, h=20, center=true, $fn=20);
            translate([0, 0, 3])
                cylinder(d=M3_nut_diameter, h=20, $fn=6);
            translate([0, 0, -3-20])
                cylinder(d=M3_nut_diameter, h=20, $fn=6);
      }
    }
  }
}


module pylon_assembly(){
    888_1009_bottom();
}
