//@set_slicing_config(slicing/default.ini)
//nosna podlozka

include <../parameters.scad>

release_servo = 0;
use_myxa = 1;
use_xt60_flange = 1;

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

                for (i=[-base_width/2 + rantl_thickness, base_width/2 - rantl_thickness])
                    translate([base_length/2 + 26/2, i , base_thickness])
                      rotate([45, 0, 0])
                        cube([base_length-26, 3, 3], center = true);
            }

            // Srazeni spodnich hran
            for(y=[-base_width/2, base_width/2])
                translate([base_length/2, y, 0])
                    rotate([45, 0, 0]) cube([base_length+1, 2, 2], center=true);


            //XT60 konektor
            if(use_xt60_flange)
                translate([15, base_width/4, 0])
                    rotate([0, 0, 90]){
                        hull(){
                            cube([8.5, 16, 10], center = true);
                        }
                        for(y = [10, -10])
                            translate([0, y, 0])
                                cylinder(d = M2_5_screw_diameter, h = 20, $fn=20);
                    }

            // Myxa mount
            if(use_myxa)
                translate([80, -9, 0]){
                    for(x=[0, 30.6], y=[-29.5/2, 29.5/2])
                        translate([x, y, 0]){
                            cylinder(d = M2_5_screw_diameter, h = 10, center=true, $fn=15);
                            translate([0,0,-0.1]) cylinder(d1 = M2_5_screw_diameter+2, d2 = M2_5_screw_diameter, h = 1.5, $fn=15);
                        }
                    //%translate([-4, -39/2, 3]) cube([49, 39, 24]);
                }


            //dirky ve dnu dvojitá řada
            for (i=[10:base_patern*2:base_length-base_patern], j=[-1, 1])
                if(i!=10 && (i!=10*11 && use_myxa))
                    translate([i,j*base_patern,-0.1])
                        cylinder(h=base_thickness+0.2, d=M3_screw_diameter, $fn=50);

            //dirky ve dnu
            // for (i=[10*2], j=[0])
            //     translate([i,j*base_patern,-0.1])
            //         cylinder(h=base_thickness+0.2, d=M3_screw_diameter, $fn=50);

            if(release_servo) %translate([65, 5, 0]) rotate(90) cube([20, 8.5, 10]);

            // Otvory pro servo
            if(release_servo)
                for (i=[base_patern*6], j=[base_patern*1.5-29/2, base_patern*1.5+28/2])
                    translate([i,j,-0.1])
                        cylinder(h=base_thickness+0.2, d=2, $fn=50);

            //Velke otvory ve spodni casti.
            difference(){
                for (i=[base_patern:base_patern*2:base_length-base_patern], j=[-1, 1])
                if(!(i==10&&j==1))
                hull(){
                    translate([i +base_patern/2,j*base_patern/2,-0.1])
                        cylinder(h=base_thickness+0.2, d=M4_screw_diameter, $fn=50);
                    translate([i+base_patern +base_patern/2,j*base_patern/2,-0.1])
                        cylinder(h=base_thickness+0.2, d=M4_screw_diameter, $fn=50);
                    translate([i +base_patern/2,j*(base_width/2-10),-0.1])
                        cylinder(h=base_thickness+0.2, d=M4_screw_diameter, $fn=50);
                    translate([i+base_patern +base_patern/2,j*(base_width/2-10),-0.1])
                        cylinder(h=base_thickness+0.2, d=M4_screw_diameter, $fn=50);
                }



            //dirky ve dnu dvojitá řada
            for (i=[10:base_patern*2:base_length-base_patern], j=[-1, 1])
                if(i!=10 && (i!=10*11 && use_myxa))
                    translate([i,j*base_patern,-0.1])
                        cylinder(h=base_thickness+0.2, d=M3_screw_diameter+5, $fn=50);

            }
            //dirky v bocnich stenach

                for(x = [10:10:base_length-10])
                    rotate([90, 0, 0])
                        translate([x, base_thickness + rantl_height/2, 0]){
                            cylinder(d = M3_screw_diameter, h = base_width+0.2, center = true, $fn = 50);
                            if(x>20) cylinder(d = M3_nut_diameter, h = base_width-4, center = true, $fn = 6);
                        }

            for (i=[0:len(base_split_position)]) {
                s = base_split_position[i];
                e = base_split_position[i+1];

            }

    }

  translate([5, -10, -rantl_height/2])
    rotate([0, 0, -90])
      linear_extrude(0.7)
        text(str(week), size = 6);
}

module 888_1001_part(part = 0){
    x0 = base_split_position[part];
    length = base_split_position[part+1] - base_split_position[part];

    translate([-x0, 0, 0])
        intersection(){
            translate([x0, -base_width/2, -10])
                translate([-2, 0, 0])
                    cube([length, base_width+10, base_thickness+30]);
            888_1001();
        }
}

module 888_1001_crop_visualisation(){
    %for (i=base_split_position) {
        translate([i, 0, 0])
            union(){
              cube([0.01, base_width+10, base_thickness+20], center = true);
            }
    }
}


888_1001();
888_1001_crop_visualisation();
//888_1001_part(0);
