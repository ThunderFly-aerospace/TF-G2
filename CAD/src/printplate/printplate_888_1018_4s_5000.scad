//@set_slicing_config(../../slicing/default.ini)
include <../../parameters.scad>
use <../888_1018.scad>

// ZIPPY 5000 mAh
battery_width = 48;
battery_height = 42;
battery_length = 165;
battery_capacity = 5000;
battery_cells = 4;

echo("pack dimensions:", battery_width, battery_height, battery_length);

888_1018(battery_width = battery_width, battery_height = battery_height, battery_length = battery_length, draft=false);
