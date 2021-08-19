//@set_slicing_config(../../slicing/default.ini)

//drzak zadniho kolecka
include <../../parameters.scad>

use <../888_4045.scad>
use <../888_4008.scad>

translate([0,0,3])  //  3 = top_thickness
    888_4008(draft=false);

translate([35,35,0])
    Mezikus(draft=false);

translate([-40,-40,0])
    mill_rot(draft=false);
