//@set_slicing_config(../../slicing/default.ini)

//autopilot and tail tube mount
include <../../parameters.scad>
use <../888_1021.scad>

translate([ -base_length, 0, 0]) 888_1021();
