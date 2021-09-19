//@set_slicing_config(../../slicing/default.ini)
include <../../parameters.scad>
use <../888_1018.scad>

// ZIPPY 4500 mAh

	battery_width = 48;
	battery_height = 42;
	battery_length = 160;
	battery_capacity = 4500;
	battery_cells = 4;

	echo("pack dimensions:", battery_width, battery_height, battery_length);

	888_1018(battery_width = battery_width, battery_height = battery_height, battery_length = battery_length, draft=false);
