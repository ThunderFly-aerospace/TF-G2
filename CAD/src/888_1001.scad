//nosna podlozka virniku1
include <../parameters.scad>
//include <lib/bat_socket/bat_socket.scad>

release_servo = 0;
use_myxa = 1;
use_xt60_flange = 1;

module 888_1001(){
    translate([0, 0, -base_thickness - rantl_height/2])
    difference(){
            union(){
                //kvadr, spodni palcka
                translate([0, -base_width/2, 0])
                    cube([base_length, base_width, base_thickness]);
                //+2 kvadriky, bocni rantl
                for (i=[-base_width/2, base_width/2 - rantl_thickness])
                    translate([0, i , 0])
                        cube([base_length, rantl_thickness, rantl_height + base_thickness]);

                // Zvyseny rantl pro drzak motoru
                for (i=[-base_width/2, base_width/2 - rantl_thickness])
                    translate([0, i , 0])
                        cube([base_patern*2.5, rantl_thickness, rantl_height*2 + base_thickness]);

                // zesileni boku
                for (i=[-base_width/2 + rantl_thickness, base_width/2 - rantl_thickness])
                    translate([base_length/2 + 26/2, i , base_thickness])
                      rotate([45, 0, 0])
                        cube([base_length-26, 3, 3], center = true);

                translate([26, 0, base_thickness]) dovetail_socket(160, connector="XT60");

                // vyztuzeni zadni strany
                translate([base_length-2, -base_width/2, base_thickness]) cube([2, base_width, 2]);

                for(x=[5, 8, 12])
                translate([base_length-5.5 - base_patern*2*x, -base_width/2, base_thickness]) cube([1, base_width, 0.5]);

                // Zesileni podlozky v puzzle spoji
                // translate([base_length/2-7/2, -base_width/2, base_thickness]) cube([7, base_width, 2]);

            }

            // Srazeni spodnich hran
            for(y=[-base_width/2, base_width/2])
                translate([base_length/2, y, 0])
                    rotate([45, 0, 0]) cube([base_length+1, 1, 1], center=true);


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
            for (i=[190+5:base_patern*1:base_length], j=[-1, 1])
                if(i!=10 && (i!=10*11 && use_myxa))
                    translate([i,j*base_patern,-0.1])
                        cylinder(h=base_thickness+0.2, d=M3_screw_diameter, $fn=50);

            if(release_servo) %translate([65, 5, 0]) rotate(90) cube([20, 8.5, 10]);

            // Otvory pro servo
            if(release_servo)
                for (i=[base_patern*6], j=[base_patern*1.5-29/2, base_patern*1.5+28/2])
                    translate([i,j,-0.1])
                        cylinder(h=base_thickness+0.2, d=2, $fn=50);

            //Velke otvory ve spodni casti.
            difference(){
                for (i=[base_patern/2:base_patern*2:base_length-base_patern], j=[-1, 1])
                if(!(i==10&&j==1))
                hull(){
                    translate([i +base_patern/2,j*base_patern/2,-0.1])
                        cylinder(h=base_thickness+0.2, d=M5_screw_diameter, $fn=50);
                    translate([i+base_patern +base_patern/2,j*base_patern/2,-0.1])
                        cylinder(h=base_thickness+0.2, d=M5_screw_diameter, $fn=50);
                    translate([i +base_patern/2,j*(base_width/2-10),-0.1])
                        cylinder(h=base_thickness+0.2, d=M5_screw_diameter, $fn=50);
                    translate([i+base_patern +base_patern/2,j*(base_width/2-10),-0.1])
                        cylinder(h=base_thickness+0.2, d=M5_screw_diameter, $fn=50);
                }

                // Rozsireni pricky pro puzzle spjku
                lock_material_width = 11; // sirka materialu, ve kterem budou zamky
                translate([base_split_position[1], 0, 0] + [-lock_material_width/2+1, -base_width/2, 0])
                    cube([lock_material_width, base_width, base_thickness]);

                // Vyztuzeni okolo XT60 konektoru
                if(use_xt60_flange)
                translate([15, base_width/4, 0])
                    rotate([0, 0, 90]){
                        cube([8.5+4, 16+4, 10], center = true);
                    }


                //Vyztuzeni okolo montaznich otvoru
                for (i=[200+5:base_patern*2:base_length], j=[-1, 1])
                    if(i!=10 && (i!=10*11 && use_myxa))
                        translate([i,j*base_patern,-0.1])
                            cylinder(h=base_thickness+0.2, d=M3_screw_diameter+5, $fn=50);
                            cylinder(h=base_thickness+0.2, d=M3_screw_diameter+5, $fn=50);

            }

            //dirky v bocnich stenach
            for(x = [10*3:10:base_length-10]) // Vynechat prvni dva otvory - ty budou vyse kvuli motorovemu drzaku
                rotate([90, 0, 0])
                    translate([x, 2*base_thickness/3, 0]){
                        translate([0, 0, base_width/2]) cylinder(d = plastic_screw_diameter, h = 2*7+0.2, center = true, $fn = 20);
                        translate([0, 0, -base_width/2]) cylinder(d = plastic_screw_diameter, h = 2*7+0.2, center = true, $fn = 20);
                    }

            for(x = [10:10:base_patern*2]) // Vynechat prvni dva otvory - ty budou vyse kvuli motorovemu drzaku
                rotate([90, 0, 0])
                    translate([x, base_thickness+rantl_height, 0]){
                        translate([0, 0, base_width/2]) cylinder(d = plastic_screw_diameter, h = 2*7+0.2, center = true, $fn = 20);
                        translate([0, 0, -base_width/2]) cylinder(d = plastic_screw_diameter, h = 2*7+0.2, center = true, $fn = 20);
                    }

            for (i=[0:len(base_split_position)]) {
                s = base_split_position[i];
                e = base_split_position[i+1];

            }

    }


  translate([2, -10, -rantl_height/2])
    rotate([0, 0, -90])
      linear_extrude(0.7)
        text(str(week), size = 5);
}

// module 888_1001_part(part = 0){
//     x0 = base_split_position[part];
//     length = base_split_position[part+1] - base_split_position[part];

//     translate([-x0, 0, 0])
//         intersection(){
//             translate([x0, -base_width/2, -10])
//                 translate([-2, 0, 0])
//                     cube([length, base_width+10, base_thickness+30]);
//             888_1001();
//         }
// }

module 888_1001_part_0(){
    x0 = base_split_position[1];
    difference(){
        888_1001();
        888_1001_crop(offset = 0.15);
    }
}

module 888_1001_part_1(){
    x0 = base_split_position[1];
    intersection(){
        888_1001();
        888_1001_crop(offset = -0.15);
    }
}

module 888_1001_crop_visualisation(offset = 0){
    %for (i=base_split_position) {
        translate([i, 0, 0])
            union(){
              cube([0.01, base_width+10, base_thickness+20], center = true);
            }


    }
}


module 888_1001_crop(offset = 0) translate([base_split_position[1], 0, -10]) {
            translate([3-offset, -50, 0]) cube([300, 100, 20]);
            for(y = [-3:3]) translate([0, 15*y, 0]){
                translate([0, 0, 0]) scale([1, 1.2, 1]) cylinder(d=5+offset, h=20, $fn=30);
                translate([0, 0-3/2-offset/2, 0]) cube([10, 3+offset, 20]);
            }

}

888_1001();
//888_1001_crop_visualisation();
//888_1001_crop(offset = 0);


base_splitter_length = 45;
base_splitter_thickness = 2;

module 888_1001_splitter(){
    translate([base_split_position[1], 0, 0]) difference() {
        union(){
        translate([-base_splitter_length/2, -base_width/2+2, -5-base_splitter_thickness])
            cube([base_splitter_length, base_width-4, base_splitter_thickness]);

        translate([0, 0, -5])
        for(i=[-20, 0])
            for(j=[-1, 1])
            hull(){
                translate([i +base_patern/2,j*base_patern/2,-0.1])
                    cylinder(h=base_thickness/2, d=M4_screw_diameter-0.2, $fn=50);
                translate([i+base_patern +base_patern/2,j*base_patern/2,-0.1])
                    cylinder(h=base_thickness/2, d=M4_screw_diameter-0.2, $fn=50);
                translate([i +base_patern/2,j*(base_width/2-10),-0.1])
                    cylinder(h=base_thickness/2, d=M4_screw_diameter-0.2, $fn=50);
                translate([i+base_patern +base_patern/2,j*(base_width/2-10),-0.1])
                    cylinder(h=base_thickness/2, d=M4_screw_diameter-0.2, $fn=50);
            }

        }

    translate([0, 0, -5])
    for(i=[-20, 0])
        for(j=[-1, 1])
        union(){
            translate([i +base_patern/2,j*base_patern/2,-0.1])
                cylinder(h=base_thickness, d=2, $fn=50);
            translate([i+base_patern +base_patern/2,j*base_patern/2,-0.1])
                cylinder(h=base_thickness, d=2, $fn=50);
            translate([i +base_patern/2,j*(base_width/2-10),-0.1])
                cylinder(h=base_thickness, d=2, $fn=50);
            translate([i+base_patern +base_patern/2,j*(base_width/2-10),-0.1])
                cylinder(h=base_thickness, d=2, $fn=50);
        }
    }
}



//888_1001_splitter();

// module battery_slot(height = 5){

//     linear_extrude(height){

//         translate([0, -40]) square([3, 80]);
//         difference(){
//             square();
//             circle(r=3);
//         }

//     }
// }

//translate([0, 0, 50]) battery_slot();
