include <../parameters.scad>


suspension_holder_length = 20;
suspension_holder_height = 20;
suspension_holder_thickness = 4;



module 888_1004(){

    translate([-suspension_holder_length/2, -base_width/2, -suspension_holder_thickness])
        cube([suspension_holder_length, base_width, suspension_holder_thickness]);

    translate([-suspension_holder_length/2, -base_width/2, -suspension_holder_height])
        cube([suspension_holder_length, suspension_holder_thickness, suspension_holder_height]);

    translate([-suspension_holder_length/2, base_width/2 -suspension_holder_thickness, -suspension_holder_height])
        cube([suspension_holder_length, suspension_holder_thickness, suspension_holder_height]);


    hull(){
        translate([-suspension_holder_length/2, -base_width/2, -suspension_holder_height])
            cube([suspension_holder_thickness, suspension_holder_thickness, suspension_holder_height]);
        translate([-suspension_holder_length/2, -base_width/2, -suspension_holder_thickness])
            cube([suspension_holder_thickness, suspension_holder_height, suspension_holder_thickness]);
        }

    hull(){
        translate([-suspension_holder_length/2, base_width/2 - suspension_holder_thickness, -suspension_holder_height])
            cube([suspension_holder_thickness, suspension_holder_thickness, suspension_holder_height]);
        translate([-suspension_holder_length/2, base_width/2 - suspension_holder_height, -suspension_holder_thickness])
            cube([suspension_holder_thickness, suspension_holder_height, suspension_holder_thickness]);
        }

}

888_1004();
