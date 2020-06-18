//@set_type(solid)

include <../../../parameters.scad>
include <../../lib/NopSCAD/lib.scad>


for (x = [2, 9, 11, 20, 21, 29])
  translate([base_patern*x, base_width/2 + 1.5, 0])
    rotate([-90, 0, 0]) {
      screw(M3_dome_screw, 10);
    }
