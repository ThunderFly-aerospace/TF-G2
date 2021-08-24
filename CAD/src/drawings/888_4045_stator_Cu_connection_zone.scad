include <../../parameters.scad>

use <../888_4045.scad>
$fn=80;
projection() Cu_butterfly_wire(draft = false);
rotate([0, 0, 180]) projection() Cu_butterfly_wire(draft = false);
//projection() Cu_inv_butterfly();

//translate([0, 0, -6]) Mezikus(draft=true);
