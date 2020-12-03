//@set_slicing_config(slicing/default.ini)
//Spodni cast pylonu

include <../parameters.scad>

pylon_bottom_wall = 5;


module pylon_pipes(d = pylon_pipe_d, below = 10, above = 10){
    x_pos_bottom = base_width/2 - 5;
    y_pos_bottom = base_width/2 - 5;

    x_pos_top = pylon_pipe_top_dist/2;
    y_pos_top = pylon_pipe_top_dist/2;


    length = sqrt( sqrt((x_pos_bottom-x_pos_top)^2 + (y_pos_bottom-y_pos_top)^2 )^2 + pylon_suspension_height^2);
    echo("delka tycek:", length);


    translate([x_pos_bottom, y_pos_bottom, 0])
        rotate([atan2((x_pos_bottom-x_pos_top), pylon_suspension_height), -atan2((y_pos_bottom-y_pos_top), pylon_suspension_height), 0])
            translate([0, 0, -below]) cylinder(d = d, h = length+below+above, $fn=20);
    translate([-x_pos_bottom, y_pos_bottom, 0])
        rotate([atan2((x_pos_bottom-x_pos_top), pylon_suspension_height), atan2((y_pos_bottom-y_pos_top), pylon_suspension_height), 0])
            translate([0, 0, -below]) cylinder(d = d, h = length+below+above, $fn=20);

    translate([x_pos_bottom, -y_pos_bottom, 0])
        rotate([-atan2((x_pos_bottom-x_pos_top), pylon_suspension_height), -atan2((y_pos_bottom-y_pos_top), pylon_suspension_height), 0])
            translate([0, 0, -below]) cylinder(d = d, h = length+below+above, $fn=20);
    translate([-x_pos_bottom, -y_pos_bottom, 0])
        rotate([-atan2((x_pos_bottom-x_pos_top), pylon_suspension_height), atan2((y_pos_bottom-y_pos_top), pylon_suspension_height), 0])
            translate([0, 0, -below]) cylinder(d = d, h = length+below+above, $fn=20);
}

module silentblock(){
    union(){
        translate([0, 0, -6]) cylinder(d = M3_screw_diameter, h = 8+12);
        cylinder(d = 8, h = 8);
    }
}

module pylon_silentblocks(){
    for(x=[0.5, -0.5]){
        translate([45*x, 0, pylon_suspension_height-4]) silentblock();
        translate([0, 45*x, pylon_suspension_height-4]) silentblock();
    }
}

module 888_1007(){

    difference(){

        cube([base_width, base_width, 10], center = true);

        minkowski(){
            difference(){
                cube([base_width - pylon_bottom_wall*2 - 6,
                    base_width - pylon_bottom_wall*2 - 6, 11], center = true);
                for(x = [-0.5, 0.5], y=[-0.5, 0.5])
                    translate([(base_width-pylon_bottom_wall*2)*x, (base_width-pylon_bottom_wall*2)*y, 0])
                        cylinder(d = 20, h = 20, center=true);
            }
        cylinder(d=6.3, h=1, $fn=20);
        }

        pylon_pipes(pylon_pipe_d, 10, 0);

        for(x = [-10, 0, 10, -20, 20])
            translate([x, 0, 0])
                rotate([90, 0, 0]){
                    cylinder(d = M3_screw_diameter, h = base_width+1, center=true, $fn = 12);
                    cylinder(d = M3_nut_diameter, h = base_width-4*2, center=true, $fn = 6);
                }
    }
}


//%pylon_pipes();
888_1007();
