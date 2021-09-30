//@set_slicing_config(../../slicing/default.ini)
include <../../parameters.scad>
use<../888_1018.scad>

18650_cell_diameter = 36.9/2; /// measured at two cells side by side
18650_cell_length = 65.4;
18650_cell_soldering_thickness = 1.5;

// MJ1 3600 mAh 2P
battery_width = 2* 18650_cell_diameter + 3*global_clearance;
battery_height = 2* 18650_cell_diameter + 3*global_clearance;
battery_length = 18650_cell_length*2 + 4*18650_cell_soldering_thickness + 2*global_clearance;
battery_capacity = 2*3600;
battery_cells = 8;

echo("pack dimensions:", battery_width, battery_height, battery_length);

888_1018(battery_width = battery_width, battery_height = battery_height, battery_length = battery_length, draft=false);
