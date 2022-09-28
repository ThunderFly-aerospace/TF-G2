// Sloupek na osu sroubu do smerovky
include <../parameters.scad>
$fn = 100;


module 888_1014(draft = true){
    difference(){
        union(){
            cylinder(d=6+5, h=1);
            cylinder(d=6, h=10);
        }
        cylinder(d=2.3, h=11);
        translate([0, 0, 8]) cylinder(d=5, h=9);
    }
}

888_1014(draft=$preview);

