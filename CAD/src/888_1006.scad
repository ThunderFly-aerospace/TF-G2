//@set_slicing_config(slicing/default.ini)
//Policka na baterii

include <../parameters.scad>

////Simoniny parametry pro nosník
//base_length = 145; //delka podlozky
//base_width = 55; //sirka podlozky
//base_height = 10; //vyska podlozky
//rantl_thickness = 4; //sirka steny podlozky
//niy=13; //pocet der podelne
//nix=6; //pocet der pricne
//M3_screw_diameter = 3.2;

batteryself_thickness = 3;
batteryself_rantl_thickness = 3;
batteryself_height = 5;
batteryself_length = 130;


module 888_1006(){
translate([0, 0, -rantl_height/2-base_thickness])
    difference(){
            union(){
                //kvadr
                translate([0, -base_width/2, 0])
                    cube([batteryself_length, base_width, batteryself_thickness]);
                //+2 kvadriky
                for (i=[-base_width/2, base_width/2 - batteryself_rantl_thickness])
                    translate([0, i , 0])
                        cube([batteryself_length, batteryself_rantl_thickness, rantl_height + base_thickness]);
            }

            //Velke otvory ve spodni casti.
            difference(){
                for (i=[5:batteryself_length/6:batteryself_length], j=[-1, 1])
                    translate([i+5, j*(base_width/4), batteryself_thickness/2])
                        cube([batteryself_length/7-5, (base_width-5)/2-6, batteryself_thickness+2], center = true);

                for (i=[5:batteryself_length/6:batteryself_length], j=[-1, 1])
                translate([batteryself_length/2, base_width/2*j, 0])
                    cube([batteryself_length/3, 25, 10], center = true);
            }


            for (i=[5:batteryself_length/6:batteryself_length], j=[-1, 1])
                translate([batteryself_length/2, (base_width/2-8)*j, 0])
                    cube([20, 2, 10], center = true);
            //dirky v bocnich stenach

                for(x = [5:10:batteryself_length-5])
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
