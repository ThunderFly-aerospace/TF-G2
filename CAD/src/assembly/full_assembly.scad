// This enable generation png from blender:
//@blender_template(../build_manual/blender/build_manual_template.blend)
//@blender_updater=../build_manual/update_render_src.py
//
// FIXME: this may fails in generation PNG from blender
//        due to parameter in translate
//        p3D do not understand remarks /* .. */
// # skip processing from blender
//@no_blend

//@set_slicing_config(../slicing/default.ini)
include <../../parameters.scad>

include <position/position_888_1001.scad>
include <position/position_888_1002.scad>
include <position/position_888_1006.scad>
include <position/position_888_1003.scad>
include <position/position_888_1007.scad>
include <position/position_888_1008.scad>
include <position/position_888_1009.scad>
include <position/position_888_1013.scad>
include <position/position_888_1018.scad>
include <position/position_rotor.scad>
include <position/position_888_2002.scad>
include <position/position_888_3000.scad>
include <position/position_888_3006.scad>
include <position/position_screw_01.scad>
include <position/position_screw_02.scad>
include <position/position_screw_03.scad>
include <position/position_motor.scad>
include <position/position_tailPipe.scad>
include <position/position_rotorhead.scad>
use <../888_1003.scad>
use <../888_1004.scad>
use <../888_1005.scad>


// include <position/position_888_1016_rear_difference.scad>

/*
for(x = [1, 0])
	mirror([0, x, 0])
		translate([0, -base_width/2, 0])
			rotate([90, 0, 0])
				888_1003(); */
/*

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
					888_2002(); */
