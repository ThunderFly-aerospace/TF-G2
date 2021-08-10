//Vyztuzovaci ramecek pylonu
include <../../../parameters.scad>
use <../../888_1009.scad>

    translate([160, 0, 55])
        //rotate([0, 0, 180])
    //        translate([0, 0, -pylon_thickness])
            888_1009_bottom();
