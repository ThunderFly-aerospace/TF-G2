//Vyztuzovaci ramecek pylonu
include <../../../parameters.scad>
use <../../888_1009.scad>

    //translate([145+30, 0, pylon_holder_side_mount_height + pilot_height_separation])
    translate([160, 0, 55])
        pylon_pipes(below = -3, above=-5);
