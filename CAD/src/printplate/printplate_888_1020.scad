include <../../parameters.scad>

use <../lib/stdlib/hlava_na_sroub.scad>

for (i = [0, 24], j = [0, 24])
    translate([i, j, 0])
        hlava_na_sroub ();