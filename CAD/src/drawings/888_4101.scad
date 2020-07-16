include <../../parameters.scad>
use <../888_4001.scad>
use <../888_4004.scad>
use <../888_4005.scad>
use <../888_4006.scad>
use <../888_4003.scad>
use <../888_4002.scad>


module 888_4101(){
    888_4002();

    translate([0, 0, 3])
        rotate([0, 0, 90])
            888_4003();

    translate([0, 0, -3])
        rotate([0, 180, 90+24])
            888_4005();

    for(i = [0:360/rotor_blades_count:360]) {
        rotate([0, 0, i])
            translate([7, 35, -5])
                rotate([0, 180, 90])
                    888_4006();

        rotate([0, 0, i])
            translate([-7, 35, 5])
                rotate([0, 0, -90])
                    888_4004();

        rotate([0, rotor_blade_AOA, i])
            translate([rotor_blade_depth/4, rotor_blade_length+50, 0])
                rotate([90, 180, 0])
                    888_4001();
    }
}


888_4101();
