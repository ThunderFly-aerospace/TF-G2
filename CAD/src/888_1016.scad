//@set_slicing_config(slicing/default.ini)
//Priprava na okrytovani

include <../parameters.scad>


module cover_hole(){
  difference(){
    square(5, center = true);
    circle(d=M3_screw_diameter, $fn = 20);
  }
}

module 888_1016(){

  for(x = cover_holes)
    translate([x, 0, 0])
      difference(){
        cube([10, base_width+10, 10], center = true);
        rotate([90, 0, 0])
          cylinder(d = M3_screw_diameter, h = 200, center = true);
        }
}


// modul pro orez blender modelu
module 888_1016_rear_crop(){
  cube([135*2, 100, 200], center = true);
  translate([80, base_width/2-4.5, 0]) cube([135*2, 5, 200], center = true);
  translate([80, -base_width/2+4.5, 0]) cube([135*2, 5, 200], center = true);

}

888_1016();

#888_1016_rear_crop();
