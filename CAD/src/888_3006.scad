// Drzak ocasni tyce pod podlozkou

include<../parameters.scad>
module 888_3006(){
    holder_wall_thickness = 2;
    offset=tail_pipe_d/2+holder_wall_thickness+1.45;
    mount_h=9;
 
    difference(){
        union(){
            cube([10, 30, 3], center=true);

            translate([0, 0, offset])
                rotate([0, 90, 0])
                    cylinder(d=tail_pipe_d + 2*holder_wall_thickness, h=10, center = true, $fn=$preview?80:150);
            translate([0, 0, tail_pipe_d/2 +mount_h/2+offset ])
                cube([10, 4*holder_wall_thickness, mount_h], center=true);
        }

        translate([0, 0, tail_pipe_d/2 +mount_h/2+offset ])
            cube([11, 2, tail_pipe_d], center=true);

        translate([0, 0, offset])
            rotate([0, 90, 0])
                cylinder(d=tail_pipe_d, h=10.2, center = true, $fn=$preview?80:150);

        for(y = [-10, 10]){
            translate([0, y, -3/2-.1])
                cylinder(d=M3_screw_diameter, h = 2*holder_wall_thickness, $fn=$preview?80:150);
        }

        translate([0, 0, tail_pipe_d/2+offset+mount_h/2])
            rotate([90, 0, 0]){
                cylinder(d=M3_screw_diameter, h = 20, center = true, $fn=$preview?80:150);
                rotate(30)
                    translate([0, 0, 2*holder_wall_thickness - M3_nut_height/2 ])
                        cylinder(d=M3_nut_diameter, h = 20, $fn=6);
        }
    }
}

888_3006();
