//// ThunderFly - TF-G2 - vypousteci zarizeni


include <../parameters.scad>
$fn = $preview? 30:80;


release_cube_width = 20;
release_cube_length = 10;

top_inner_diameter = 13;
bottom_inner_diameter = 24+1;
thickness = 1.3;
sensor_cap_height = 16;

module 888_1014(){

  difference(){
  union(){
      cylinder(d1 = top_inner_diameter+thickness*2, d2 = bottom_inner_diameter+thickness*2, h = sensor_cap_height - 5);
      translate([0, 0, sensor_cap_height-5])
        cylinder(d = bottom_inner_diameter+thickness*2, h = 6);
  }

    hull(){
      translate([0, 0, 2.5])
        cylinder(d1 = top_inner_diameter, d2 = bottom_inner_diameter, h = sensor_cap_height - 5-2.5);
      translate([0, 0, sensor_cap_height-5])
        cylinder(d = bottom_inner_diameter, h = 7);
    }

  translate([0, 0, -0.1])
    cylinder(d = M3_screw_diameter, h=50);

  for(r = [0: 360/(16): 180])
    rotate([0, 0, r])
      translate([0, 0, sensor_cap_height])
        cube([50, 2, 10], center = true);

    translate([0, 0, -0.1]) cylinder(d = M3_nut_diameter, h = M3_nut_height-1, $fn=6);

}

  difference(){
    cylinder(d = 7, h = M3_nut_height -2 + 2);
    translate([0, 0, M3_nut_height - 2.2+0.15]) cylinder(d = M3_screw_diameter, h = 10);
    translate([0, 0, -0.1]) cylinder(d = M3_nut_diameter, h = M3_nut_height-2, $fn=6);
  }


}


888_1014();
