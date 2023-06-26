//@set_slicing_config(../../slicing/default.ini)

//dil pro pripevneni zadniho podvozku
include <../../../parameters.scad>
//use <../../888_2002.scad>
use <../../888_2006.scad>



for(x = [1, 0])
	mirror([0, x, 0])
		translate([0, -base_width/2, 0])
			rotate([90, 0, 0])
			{
		    888_2006();
			}
