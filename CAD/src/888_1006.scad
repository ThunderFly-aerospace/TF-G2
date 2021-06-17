//Policka na payload

include <../parameters.scad>

payloadself_thickness = 3;
payloadself_rantl_thickness = 3;
payloadself_height = 5;
payloadself_length = 130;

module 888_1006(){
translate([0, 0, -rantl_height/2-base_thickness])
    difference(){
            union(){
                //kvadr
                translate([0, -base_width/2, 0])
                    cube([payloadself_length, base_width, payloadself_thickness]);
                //+2 kvadriky
                for (i=[-base_width/2, base_width/2 - payloadself_rantl_thickness])
                    translate([0, i , 0])
                        cube([payloadself_length, payloadself_rantl_thickness, rantl_height + base_thickness]);
            }

            //Velke otvory ve spodni casti.
            difference(){
                for (i=[5:payloadself_length/6:payloadself_length], j=[-1, 1])
                    translate([i+5, j*(base_width/4), payloadself_thickness/2])
                        cube([payloadself_length/7-3, (base_width-5)/2-6, payloadself_thickness+2], center = true);

                for (i=[5:payloadself_length/6:payloadself_length], j=[-1, 1])
                translate([payloadself_length/2, base_width/2*j, 0])
                    cube([payloadself_length/3, 25, 10], center = true);
            }


            for (i=[5:payloadself_length/6:payloadself_length], j=[-1, 1])
                translate([payloadself_length/2, (base_width/2-8)*j, 0])
                    cube([24, 2, 10], center = true);
            //dirky v bocnich stenach

                for(x = [5:10:payloadself_length-5])
                    rotate([90, 0, 0])
                        translate([x, base_thickness + rantl_height/2, 0]){
                            cylinder(d = M3_screw_diameter, h = base_width+1, center = true, $fn = 50);
                            cylinder(d = M3_nut_diameter, h = base_width-2, center = true, $fn = 6);
                        }

            for (i=[0:len(base_split_position)]) {
                s = base_split_position[i];
                e = base_split_position[i+1];
            }

    }
}

888_1006();
