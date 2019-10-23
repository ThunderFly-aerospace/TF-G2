//nosna podlozka

////Simoniny parametry pro nosník rotoru
base_length = 145; //delka podlozky
base_width = 55; //sirka podlozky
base_height = 10; //vyska podlozky
rantl_thickness = 4; //sirka steny podlozky
niy=13; //pocet der podelne
nix=6; //pocet der pricne
s=10.16;
M3_screw_diameter = 3.2;

//include <Users/parandelic/.ssh/TF-G2/CAD/src/parameters.scad>


module 888_1001(){

    difference(){ 
            union(){   
                //kvadr
                translate([-base_width/2,-base_length/2,0])
                    cube([base_width,base_length,rantl_thickness]);
                //+2 kvadriky
                for (i=[base_width-rantl_thickness,0,0])
                    translate([i-base_width/2,-base_lenght/2,0])
                        cube([rantl_thickness,base_length,base_height]);
            }
            //dirky ve dnu
            for (i=[-nix/2:nix/2],j=[-niy/2:niy/2])
                translate([i*s,j*s,0])
                    cylinder(h=rantl_thickness,M3_screw_diameter,$fn=100);

            //dirky v bocnich stenach
            for (j=[-niy/2:niy/2])
                rotate([0,90,0])   
                translate([-rantl_thickness-(base_height-rantl_thickness)/2,j*s,-base_width/2])
                    cylinder(h=base_width,M3_screw_diameter,$fn=100);
    }
}


888_1001();                
