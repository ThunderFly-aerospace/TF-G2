include <../../../parameters.scad>
use <../../888_1013.scad>

    translate([base_patern*4, 0, -base_thickness -rantl_height/2])
    rotate([180, 0, 180])
            888_1013();
