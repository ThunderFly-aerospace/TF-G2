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
  translate([-135 + 155 + 45, 0, 0]) cube([135*2, 100, 200], center = true);
  //translate([135+40+1, base_width/2-4.5, 0]) cube([80, 4, 200], center = true);
  //translate([135+40+1, -base_width/2+4.5, 0]) cube([80, 4, 200], center = true);

}
// modul pro orez blender modelu
module 888_1016_front_crop(){
  translate([150+150, 0, 0]) cube([300, 100, 200], center = true);
  translate([135+40+1, base_width/2-4.5, 0]) cube([60, 5, 200], center = true);
  translate([135+40+1, -base_width/2+4.5, 0]) cube([60, 5, 200], center = true);
}



module 888_1016_rear_holes(){

  for(x = cover_holes)
    translate([x, 0, 0])
        rotate([90, 0, 0])
          cylinder(d = M3_screw_diameter, h = 200, center = true, $fn=30);

}

888_1016();

#888_1016_rear_crop();
