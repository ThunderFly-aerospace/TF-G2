
include <../../../parameters.scad>
use<../../lib/stdlib/motors.scad>

translate([base_patern*4-4, 0, motor_holder_side_mount_height])
rotate([0, -90, 0]) motor_c3548_900();
