//@set_type(solid)

include <../../../parameters.scad>
include <../../lib/NopSCAD/lib.scad>

for(p = [[25/2, 0], [-25/2, 0], [0, 9], [0, -9]])
    translate([base_patern*4, 0, motor_holder_motor_height] + [0, p[0], p[1]])
        rotate([0, 90, 0])
              washer(M3_washer) screw(M3_dome_screw, 6);
