//Vyztuzovaci ramecek pylonu
include <../../../parameters.scad>
use <../../888_1012.scad>

    rotate([0, 0, 180])
    	translate([7.5+16-176-5-0.5, 0, -13.5+180+5.75+51.7]+[-9.5, 0, 35])
    	rotate([0, -90, 0])
        {
    		888_1012();
            translate([0,0,-6.7])
                888_1012_bearing_house();
        }
