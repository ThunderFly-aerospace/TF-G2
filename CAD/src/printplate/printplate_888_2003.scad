//@set_slicing_config(../../slicing/default.ini)

include <../../parameters.scad>
use <../888_2003.scad>

module 888_2003_doubled()
{    
    888_2003();
    translate([0,0,5])
        888_2003();
}

offset=28;
translate([offset,offset,0])
    888_2003_doubled();
translate([-offset,-offset,0])
    888_2003_doubled();
