//@set_slicing_config(../../slicing/default.ini)
include <../../parameters.scad>
use<../888_1018.scad>

// MJ1 10500 mAh
battery_width = 57.5;
battery_height = 37+0.5;
battery_length = 65*2+3+2;
battery_capacity = 10500;
battery_cells = 12;


echo("pack dimensions:", battery_width, battery_height, battery_length);

888_1018(battery_width = battery_width, battery_height = battery_height, battery_length = battery_length, draft=false);
