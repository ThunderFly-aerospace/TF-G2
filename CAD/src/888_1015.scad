//@set_slicing_config(slicing/default.ini)
//Policka na GPS

include <../parameters.scad>


gpsself_thickness = 2;
gpsself_rantl_thickness = 3;
gpsself_height = 5;
gpsself_length = 50;
TFGPS01_screw_distance = 40;


module 888_1015(){
translate([0, 0, -rantl_height/2-base_thickness])
    difference(){
            union(){
                //kvadr
                translate([0, -base_width/2, 0])
                    cube([gpsself_length, base_width, gpsself_thickness]);
                //+2 kvadriky
                for (i=[-base_width/2, base_width/2 - gpsself_rantl_thickness])
                    translate([0, i , 0])
                        cube([gpsself_length, gpsself_rantl_thickness, rantl_height + base_thickness]);
            }

            //Velke otvory ve spodni casti.
          /*difference(){
                for (i=[5.5:gpsself_length/3:gpsself_length], j=[-1, 1])
                    translate([i+3, j*(base_width/4), gpsself_thickness/2])
                        cube([gpsself_length/4-1, (base_width-5)/2-3, gpsself_thickness+2], center = true);

            }*/

            translate([gpsself_length/2, 10, gpsself_thickness/2])
              rotate([0,0,45])
                cube([gpsself_length - 20, gpsself_length - 20, gpsself_thickness+2], center = true);

            translate([gpsself_length/2, -10, gpsself_thickness/2])
              rotate([0,0,45])
                cube([gpsself_length - 20, gpsself_length - 20, gpsself_thickness+2], center = true);

            translate([gpsself_length/2,0, gpsself_thickness/2])
                cube([sqrt(pow(gpsself_length - 20,2) + pow(gpsself_length - 20,2)), 20, gpsself_thickness+2], center = true);



            //dirky v bocnich stenach
            for(x = [5:10:gpsself_length-5])
                rotate([90, 0, 0])
                    translate([x, base_thickness + rantl_height/2, 0]){
                        cylinder(d = M3_screw_diameter, h = base_width+1, center = true, $fn = 50);
                        cylinder(d = M3_nut_diameter, h = base_width-2, center = true, $fn = 6);
                    }

            for (i=[0:len(base_split_position)]) {
                s = base_split_position[i];
                e = base_split_position[i+1];
            }

            translate([(gpsself_length - TFGPS01_screw_distance)/2, TFGPS01_screw_distance/2, 0])
                cylinder(d = M3_screw_diameter, h = base_width+1, center = true, $fn = 50);
            translate([(gpsself_length - TFGPS01_screw_distance)/2, TFGPS01_screw_distance/2, gpsself_thickness - gpsself_thickness/3])
                cylinder(d = M3_nut_diameter, h = base_width+1, $fn = 6);

            translate([(gpsself_length - TFGPS01_screw_distance)/2, -TFGPS01_screw_distance/2, 0])
                cylinder(d = M3_screw_diameter, h = base_width+1, center = true, $fn = 50);
            translate([(gpsself_length - TFGPS01_screw_distance)/2, -TFGPS01_screw_distance/2, gpsself_thickness - gpsself_thickness/3])
                cylinder(d = M3_nut_diameter, h = base_width+1, $fn = 6);

            translate([(gpsself_length - TFGPS01_screw_distance)/2 + TFGPS01_screw_distance, TFGPS01_screw_distance/2, 0])
                cylinder(d = M3_screw_diameter, h = base_width+1, center = true, $fn = 50);
            translate([(gpsself_length - TFGPS01_screw_distance)/2 + TFGPS01_screw_distance, TFGPS01_screw_distance/2, gpsself_thickness - gpsself_thickness/3])
                cylinder(d = M3_nut_diameter, h = base_width+1, $fn = 6);

            translate([(gpsself_length - TFGPS01_screw_distance)/2 + TFGPS01_screw_distance, -TFGPS01_screw_distance/2, 0])
                cylinder(d = M3_screw_diameter, h = base_width+1, center = true, $fn = 50);
            translate([(gpsself_length - TFGPS01_screw_distance)/2 + TFGPS01_screw_distance, -TFGPS01_screw_distance/2, gpsself_thickness - gpsself_thickness/3])
                cylinder(d = M3_nut_diameter, h = base_width+1, $fn = 6);


    }
}

888_1015();
