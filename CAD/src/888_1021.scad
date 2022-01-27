//nosna podlozka virniku1
include <../parameters.scad>

module 888_1021(){
    base_thickness = autopilot_base_thickness;
    translate([base_length - base_patern*8, 0, 0])
        difference(){
                hull(){
                  for (i=[10:base_patern*2:base_patern*8], j=[-1, 1])
                    translate([i,j*base_patern,0])
                        cylinder(h=base_thickness, d1=2.5*M3_nut_diameter, d2=2*M3_nut_diameter, $fn=50);
                }

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
