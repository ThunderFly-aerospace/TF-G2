//// ThunderFly - TF-G2 - vypousteci zarizeni


include <../parameters.scad>
$fn = $preview? 10:50;


release_plate_thickness = 2;

release_cube_width = 20;
release_cube_length = 10;

module 888_1013(){

  difference(){
    union(){
      hull(){
        translate([20, 0, release_plate_thickness/2])
          cube([20, 15, release_plate_thickness], center = true);

        for(y=[base_patern, -base_patern])
          translate([20, y, -0])
            cylinder(d = M3_screw_diameter+6, h = release_plate_thickness);
          translate([20, 0, -0])
            cylinder(d = M3_screw_diameter+6, h = release_plate_thickness);
        translate([0, -release_cube_width/2, 0])
          cube([release_cube_length+20, release_cube_width, release_plate_thickness]);


      }
      hull(){
        translate([0, -release_cube_width/2, 0])
          cube([release_cube_length, release_cube_width, 14]);
        translate([0, -release_cube_width/2, 0])
          cube([release_cube_length+20, release_cube_width, release_plate_thickness]);

        translate([12, 0, 9])
          rotate([90, 0, 0])
            cylinder(d = M3_screw_diameter+6, h = release_cube_width, center = true);
      }
    }


    // otvory na srouby pro pripevneni k podlozce
    for(y=[base_patern, -base_patern]){
      translate([20, y, -0.1])
        cylinder(d = M3_screw_diameter, h = 10);
      translate([20, y, release_plate_thickness])
        cylinder(d = M3_nut_diameter, h = 20);
    }
    translate([10, 0, -0.1])
      cylinder(d = M3_screw_diameter, h = 10);
      translate([10, 0, 1])
        cylinder(d = M3_nut_diameter, h = 20);



    // vnitrek prostoru
    difference(){
      translate([3, -release_cube_width/2+4, release_plate_thickness])
        cube([50, release_cube_width-8, 30]);

      for(y=[base_patern, -base_patern])
        translate([0, y, release_plate_thickness])
          cylinder(d = M3_nut_diameter+6, h = 20);

      rotate([0, 45, 0])
        cube([15, 30, 15], center = true);

    }



    // otvor pro osu od serva
      hull()
        for(z = [7, 11])
          translate([0, 0, z])
            rotate([0, 90, 0])
              cylinder(d = 3, h = 10, center = true);

    // otvory pro pricny cep
    translate([12, 0, 9])
      rotate([90, 0, 0])
      {
        cylinder(d = M3_screw_diameter, h = 30, center = true);

        translate([0, 0, 17/2+15])
          cylinder(d = M3_nut_diameter, h = 30, center = true);

        translate([0, 0,-17/2-15])
          cylinder(d = M3_nut_diameter, h = 30, center = true, $fn=6);
      }


  }
}


888_1013();
