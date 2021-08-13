// Drzak ocasni tyce pod podlozkou

include<../parameters.scad>
module 888_3006(){
holder_wall_thickness = 2;

    translate([0, 0, 1.5]) difference(){
        union(){
            cube([10, 30, 3], center=true);

            translate([0, 0, 5+3])
                rotate([0, 90, 0])
                    cylinder(d=tail_pipe_d + 2*holder_wall_thickness, h=10, center = true, $fn=$preview?15:80);
            translate([0, 0, tail_pipe_d + tail_pipe_d/2 ])
                cube([10, 6, tail_pipe_d/2 + holder_wall_thickness], center=true);
        }

        translate([0, 0, tail_pipe_d + tail_pipe_d/2])
            cube([11, 1, tail_pipe_d], center=true);

        translate([0, 0, 5+3])
            rotate([0, 90, 0])
                cylinder(d=tail_pipe_d, h=10.2, center = true, $fn=$preview?15:80);

        for(y = [-10, 10]){
            translate([0, y, -3/2-.1])
                cylinder(d=M3_screw_diameter, h = 2*holder_wall_thickness, $fn=$preview?10:20);
        }

        translate([0, 0, tail_pipe_d + tail_pipe_d/2])
            rotate([90, 0, 0]){
                cylinder(d=M3_screw_diameter, h = 20, center = true, $fn=$preview?10:20);
                rotate(30) translate([0, 0, 2]) cylinder(d=M3_nut_diameter, h = 20, $fn=6);
            }
    }
}

888_3006();
