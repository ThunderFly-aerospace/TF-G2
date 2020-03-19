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

batteryself_thickness = 2;
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
            for (i=[0:batteryself_length/7-5/3:batteryself_length-20], j=[0, 1])
                translate([i+5, j*-(base_width/2-2.5*2), 0])
                    #cube([batteryself_length/7-5, (base_width-5)/2-5, batteryself_thickness]);


            //dirky v bocnich stenach

                for(x = [5:10:batteryself_length-5])
                    rotate([90, 0, 0])
                        translate([x, base_thickness + rantl_height/2, 0])
                            cylinder(d = M3_screw_diameter, h = 200, center = true, $fn = 50);

            for (i=[0:len(base_split_position)]) {
                s = base_split_position[i];
                e = base_split_position[i+1];

            }

    }
}

888_1006();
