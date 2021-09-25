// Vicko na TFGPS
//@set_slicing_config(../../slicing/default.ini)

include <../../parameters.scad>


use <../lib/TFGPS01/hw/cad/src/tfgps01_1001.scad>

rotate([180, 0, 0]) gps_vicko();
