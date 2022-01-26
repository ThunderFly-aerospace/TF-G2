//@set_slicing_config(../../slicing/default.ini)
include <../../parameters.scad>
use <../888_2006.scad>

module mirror_copy(v=[1,0,0])
{
    children();
    mirror(v) children();
}

// otoceni a kopie pro tisk
mirror_copy([1, 0, 0])
  rotate ([180,0,0])
    translate([-250,0,0])
      888_2006(draft=false);
