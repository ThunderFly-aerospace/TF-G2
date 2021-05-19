//@set_slicing_config(../../slicing/default.ini)

include <../../parameters.scad>
use <../888_2004.scad>

// FIXME two parts maybe are to far

// otoceni a kopie pro tisk
mirror_copy([1, 0, 0])
  rotate ([180,0,0])
    translate([-20,0,0])
      888_2004();
