//@set_slicing_config(../../slicing/default.ini)

include <../../parameters.scad>
use <../888_2101.scad>


module mirror_copy(v=[1,0,0])
{
    children();
    mirror(v) children();
}

// otoceni a kopie pro tisk
mirror_copy([1, 0, 0])
  rotate ([0,0,0])
    translate([-20,0,0])
      888_2101(draft=false);
