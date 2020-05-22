//// ThunderFly - TF-G2 - vypousteci zarizeni


include <../parameters.scad>
$fn = $preview? 30:80;


release_plate_thickness = 2;

release_cube_width = 20;
release_cube_length = 10;

top_inner_diameter = 15;
bottom_inner_diameter = 24;
thickness = 0.85;
sensor_cap_height = 19;

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
  translate([0, 0, 2.5])
    cylinder(d = inner_diameter, h = 50);


  for(r = [0, 90])
    rotate([0, 0, r])
      hull()
        for(z = [0, 2.5])
          translate([0, 0, z + sensor_cap_height - 4])
            rotate([90, 0, 0])
              cylinder(d = 3, h = 50, center = true, $fn = 5);

}

  difference(){
    cylinder(d = M3_screw_diameter+3, h = 3);
    translate([0, 0, -0.5]) cylinder(d = M3_screw_diameter, h = 4);
  }


}


888_1014();
