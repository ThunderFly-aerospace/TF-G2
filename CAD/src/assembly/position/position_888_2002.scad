//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni tazneho motoru
include <../../../parameters.scad>
use <../../888_2002.scad>
use <../../888_2003.scad>


translate([30+10, 9, -100])
	translate([0, 75/2, 0])
		rotate([0, 90, 180])
			//translate([0, 0, -18/2])
                888_2002();


translate([30+10, -9, -100])
	translate([0, -75/2, 0])
		rotate([0, 90, 0])
			//translate([0, 0, -18/2])
                888_2002();
