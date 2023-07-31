//@set_type(solid)
include <../../../parameters.scad>
//@blender_template(../../build_manual/blender/build_manual_template.blend)
//@blender_updater=../../build_manual/update_render_src.py
$fn=10;
// TODO: render viewport to position of camera
//       e.g. see ../../build_manual/src/buildmanual_0001_c.json
//# @blender_config(../../build_manual/src/buildmanual_0001_c.json)
//$vpt=[-400,-500,300];
//$vpr=[70,0,-45];

// include <yasim.scad>

////import_stl("stl/buildmanual_motor.stl", convexity = 5);
//import("../build_manual/stl/buildmanual_motor.stl");

//include <../position/position_888_1001.scad> // podlozka
//include <position/position_888_1002.scad> // Motorova pricka
//include <position/position_888_1003.scad> // Bocnice
include <../position/position_888_1006.scad> // Policka na payload
include <../position/position_888_1007.scad> // spodni pricka pylonu
//include <position/position_888_1008.scad> // horni pricka pylonu
//include <position/position_888_1009.scad> // 
//include <position/position_888_1010.scad> // TFSLOT
//include <position/position_888_1011.scad>
//include <position/position_888_1012.scad>
//include <position/position_888_1009.scad>
//include <position/position_888_1013.scad>
//include <position/position_888_1018.scad>
//include <position/position_rotor.scad>
//include <../888_1016.scad>
// include <position/position_888_2002.scad> // podvozek
//include <position/position_888_3000.scad>
//include <position/position_888_3006.scad>
//include <position/position_screw_01.scad>
//include <position/position_screw_02.scad>
//include <position/position_screw_03.scad>
//include <position/position_motor.scad>
//include <position/position_tailPipe.scad>
//include <position/position_rotorhead.scad>

use <../../888_1004.scad>
color([0.3,0.3,0.3])
rotate([0, 45, 0])
// FIXME: cannot use parametr
// @blender-skip translate([0, -base_width/2, 0])
rotate([0, -90, 0]) // @blender-skip basic rotation from stl of module
  888_1004();
//use <../888_1004.scad>
//use <../888_1005.scad>

//use <../../888_1007.scad>
//888_1007();

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
