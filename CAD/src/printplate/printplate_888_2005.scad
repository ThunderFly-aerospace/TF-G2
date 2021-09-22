//@set_slicing_config(../../slicing/default.ini)

include <../../parameters.scad>
use <../888_2005.scad>

// otoceni a kopie pro tisk
rotate ([90,0,0])
  translate([-40,30,30])
    888_2005(draft=false);
