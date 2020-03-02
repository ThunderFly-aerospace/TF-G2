
include <../parameters.scad>

use <888_1001.scad>
use <888_1002.scad>
use <888_1003.scad>
use <888_1004.scad>
use <888_1005.scad>


use <888_2002.scad>


888_1001();


888_1002();

for(x = [1, 0])
	mirror([0, x, 0])
		translate([0, -base_width/2, 0])
			rotate([90, 0, 0])
				888_1003();

translate([250, 0, -base_thickness*2])
888_1004();


translate([250, 0, 0])
translate([0, 30, 0])
rotate([90, 0, 90])
translate([0, -100, -7.5])
	888_2002();


//888_1005();
