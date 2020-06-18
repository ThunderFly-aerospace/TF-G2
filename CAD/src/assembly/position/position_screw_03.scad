//@set_type(solid)

include <../../../parameters.scad>
include <../../lib/NopSCAD/lib.scad>


 translate([base_patern*3, base_width/2 + 1.5, base_patern*2.5])
    rotate([-90, 0, 0])
      screw(M3_dome_screw, 10);
