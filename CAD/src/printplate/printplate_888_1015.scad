//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni motoru prerotatoru
include <../../parameters.scad>
use <../888_1015.scad>

$fn=50;
    rotate([180, 0, 0]) 888_1015();
