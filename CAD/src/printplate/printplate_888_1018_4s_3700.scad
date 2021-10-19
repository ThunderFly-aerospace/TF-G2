//@set_slicing_config(../../slicing/default.ini)
include <../../parameters.scad>
use <../888_1018.scad>

// ZIPPY 3700 mAh

	battery_width = 48;
	battery_height = 35;
	battery_length = 150;
	battery_capacity = 3700;
	battery_cells = 4;

	echo("pack dimensions:", battery_width, battery_height, battery_length);

	888_1018(battery_width = battery_width, battery_height = battery_height, battery_length = battery_length, draft=false);
