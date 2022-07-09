//@set_slicing_config(../../slicing/freeflap.ini)

include <../../parameters.scad>
use <../888_4009_4_blades.scad>
use <../888_4010.scad>

translate([0,0,free_flap_desk_add])
    888_4009_4_blades();
