//Vyztuzovaci ramecek pylonu
include <../../../parameters.scad>
use <../../888_1011.scad>

    rotate([0, 0, 0])
    	translate([176+7.5+16+5, 0, -13.5+180+5.75+51.7]+[-47, 0, 30])
    		rotate([-90, 180, 90]) 888_1011();
