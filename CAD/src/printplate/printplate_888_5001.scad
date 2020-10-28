//@set_slicing_config(../../slicing/airspeed.ini)


//drzak zadniho kolecka
include <../../parameters.scad>

use <../888_5001.scad>

rotate([0, 90, 0])
{
    888_5001();
    //support_888_5001();
}
