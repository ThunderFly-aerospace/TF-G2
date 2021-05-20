//@set_slicing_config(../../slicing/default.ini)

include <../../parameters.scad>
use <../888_2004.scad>

// otoceni a kopie pro tisk
mirror_copy([1, 0, 0])
translate([-25,0,0])
rotate ([180,0,0])
888_2004();
