//nosna podlozka virniku1
include <../parameters.scad>

module 888_1021(){
    translate([base_length - base_patern*8, 0, 0])
    difference(){
            translate([0, -base_width/4, 0])
                cube([base_patern*8, base_width/2, base_thickness]);

            //dirky ve dnu dvojitá řada
            for (i=[10:base_patern*2:base_patern*8], j=[-1, 1])
            {
                    translate([i,j*base_patern,-0.1])
                        cylinder(h=base_thickness+0.2, d=M3_screw_diameter, $fn=50);
                    translate([i,j*base_patern,base_thickness-M3_nut_height])
                        cylinder(h=base_thickness, d=M3_nut_diameter, $fn=6);
            }
    }
}


888_1021();
