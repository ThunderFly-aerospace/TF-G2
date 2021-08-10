
include <../../../parameters.scad>
use<../../lib/stdlib/motors.scad>

translate([base_patern*3, 0, motor_holder_side_mount_height])
translate([0, 0, 4])
rotate([0, -90-5, 0]) motor_c3548_900();
