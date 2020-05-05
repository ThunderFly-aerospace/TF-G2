
//@set_slicing_config(../slicing/default.ini)
include <../../parameters.scad>

include <position/position_888_1001.scad>
include <position/position_888_1002.scad>
include <position/position_888_1006.scad>
include <position/position_888_1003.scad>
include <position/position_888_1007.scad>
include <position/position_888_1008.scad>
include <position/position_888_1009.scad>
include <position/position_888_3000.scad>
include <position/position_888_3006.scad>
include <position/position_motor.scad>
include <position/position_tailPipe.scad>
use <rotor_assembly.scad>
use <../888_1003.scad>
use <../888_1004.scad>
use <../888_1005.scad>
use <../888_1005.scad>

use <888_2002.scad>


/*
for(x = [1, 0])
	mirror([0, x, 0])
		translate([0, -base_width/2, 0])
			rotate([90, 0, 0])
				888_1003(); */

translate([250, 0, -base_thickness*2])
	888_1004();


translate([250, 0, 0])
	translate([0, 30, 0])
		rotate([90, 0, 90])
			translate([0, 0, -18/2])
				888_2002();

translate([250, 0, 0])
	rotate([0, 0, 180])
		translate([0, 30, 0])
			rotate([90, 0, 90])
				translate([0, 0, -18/2])
					888_2002();

translate([153, 0, 250])
	rotor_head();

//888_1005();
