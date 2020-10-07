include <../../parameters.scad>

use <../888_4001.scad>

projection(cut = false)
translate([0, 20, 0])
rotate([-90,0,0])
  888_4001_doc();
