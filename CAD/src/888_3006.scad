// Drzak ocasni tyce pod podlozkou

include<../parameters.scad>
module 888_3006()
translate([0, 0, 1.5]) difference(){
    union(){
        cube([10, 30, 3], center=true);

        translate([0, 0, 5+3])
            rotate([0, 90, 0])
                cylinder(d=10+4, h=10, center = true, $fn=$preview?10:80);
        translate([0, 0, 15])
            cube([10, 6, 10], center=true);
    }

    translate([0, 0, 12])
        cube([11, 1, 18], center=true);

    translate([0, 0, 5+3])
        rotate([0, 90, 0])
            cylinder(d=10.2, h=10.2, center = true, $fn=$preview?10:80);

    for(y = [-10, 10]){
        translate([0, y, -3/2-.1])
            cylinder(d=M3_screw_diameter, h = 10.2, $fn=$preview?10:20);
        translate([0, y, -3/2-.1+2])
            cylinder(d=M3_nut_diameter, h = 10.2, $fn=6);
    }

    translate([0, 0, 16])rotate([90, 0, 0]){
        cylinder(d=M3_screw_diameter, h = 20, center = true, $fn=$preview?10:20);
        rotate(30) translate([0, 0, 2]) cylinder(d=M3_nut_diameter, h = 20, $fn=6);
        rotate(30) translate([0, 0, -2-20]) cylinder(d=M3_nut_diameter, h = 20, $fn=6);
    }
}

888_3006();
