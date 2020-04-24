//@set_slicing_config(slicing/default.ini)
//nosna podlozka

include <../parameters.scad>

////Simoniny parametry pro nosník
//base_length = 145; //delka podlozky
//base_width = 55; //sirka podlozky
//base_height = 10; //vyska podlozky
//rantl_thickness = 4; //sirka steny podlozky
//niy=13; //pocet der podelne
//nix=6; //pocet der pricne
//M3_screw_diameter = 3.2;


module 888_1001(){
    translate([0, 0, -base_thickness - rantl_height/2])
    difference(){
            union(){
                //kvadr
                translate([0, -base_width/2, 0])
                    cube([base_length, base_width, base_thickness]);
                //+2 kvadriky
                for (i=[-base_width/2, base_width/2 - rantl_thickness])
                    translate([0, i , 0])
                        cube([base_length, rantl_thickness, rantl_height + base_thickness]);
            }

            //dirky ve dnu
            for (i=[10:base_patern:base_length-base_patern], j=[-niy/2:niy/2])
                translate([i,j*base_patern,-0.1])
                    cylinder(h=base_thickness+0.2, d=M3_screw_diameter, $fn=50);

            //Velke otvory ve spodni casti.
            for (i=[10:base_patern*2:base_length-base_patern], j=[-1, 1])
                hull(){
                    #translate([i,j*base_patern/2,-0.1])
                        cylinder(h=base_thickness+0.2, d=M3_screw_diameter, $fn=50);
                    translate([i+base_patern,j*base_patern/2,-0.1])
                        cylinder(h=base_thickness+0.2, d=M3_screw_diameter, $fn=50);
                    translate([i,j*(base_width/2-10),-0.1])
                        cylinder(h=base_thickness+0.2, d=M3_screw_diameter, $fn=50);
                    translate([i+base_patern,j*(base_width/2-10),-0.1])
                        cylinder(h=base_thickness+0.2, d=M3_screw_diameter, $fn=50);
                }

            //dirky v bocnich stenach

                for(x = [10:10:base_length-10])
                    rotate([90, 0, 0])
                        translate([x, base_thickness + rantl_height/2, 0]){
                            cylinder(d = M3_screw_diameter, h = base_width+0.2, center = true, $fn = 50);
                            cylinder(d = M3_nut_diameter, h = base_width-4, center = true, $fn = 6);
                        }

            for (i=[0:len(base_split_position)]) {
                s = base_split_position[i];
                e = base_split_position[i+1];

            }

    }
}

module 888_1001_part(part = 0){

    x0 = base_split_position[part];
    length = base_split_position[part+1] - base_split_position[part];


    translate([-x0, 0, 0])
    intersection(){
        translate([x0, -base_width/2-5, -10])
        cube([length, base_width+10, base_thickness+30]);
        888_1001();
    }
}

module 888_1001_crop_visualisation(){
    %for (i=base_split_position) {
        translate([i, 0, 0])
            cube([0.01, base_width+10, base_thickness+20], center = true);
    }
}


888_1001();


888_1001_crop_visualisation();
//888_1001_part(0);
