
//@set_slicing_config(../slicing/default.ini)
include <../../parameters.scad>

// include <yasim.scad>

//include <position/position_888_1001.scad> // podlozka
//include <position/position_888_1002.scad> // Motorova pricka
//include <position/position_888_1003.scad> // Bocnice
//include <position/position_888_1006.scad> // Policka na payload
include <position/position_888_1007.scad> // spodni pricka pylonu
include <position/position_888_1007_silentblocks.scad> // spodni pricka pylonu
include <position/position_888_1009.scad>
//include <position/position_888_1010.scad> //TFSLOT
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
include <position/position_rotorhead.scad>
//use <../888_1003.scad>
//use <../888_1004.scad>
//use <../888_1005.scad>
//use <../888_1005.scad>


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
