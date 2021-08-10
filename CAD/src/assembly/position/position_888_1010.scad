//Vyztuzovaci ramecek pylonu
include <../../../parameters.scad>
use <../../888_1010.scad>

    rotate([0, 0, 180])
    	translate([7.5+16-176, 0, -13.5+180+5.75+51.7])
    		888_1010();
