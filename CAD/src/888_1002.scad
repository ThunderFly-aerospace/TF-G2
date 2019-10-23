//dil pro pripevneni tazneho motoru
include <../parameters.scad>

sides_height = 80; //vyska sten
lenght = 33; //delka sten z vykresu, nepouzity
thickness = 3; //sirka sten
drzak_height = 55; //spatny rozmer so far

base_length = 145; //delka podlozky
base_width = 55; //sirka podlozky
base_height = 10; //vyska podlozky
rantl_thickness = 4; //sirka steny podlozky
niy=13; //pocet der podelne -1
nix=6; //pocet der pricne +1
s=10.16;
M3_screw_diameter = 3.2;

difference(){
	translate([-base_width/2,-thickness/2,0])
		cube([base_width,thickness,drzak_height]);

	union(){
//+2 kvadriky
        for (i=[base_width-rantl_thickness,0,0])
            translate([i-base_width/2,-base_length/2,0])
                cube([rantl_thickness,base_length,base_height]);
//dira uprostred
        translate([0,thickness/2,drzak_height/2])	
        rotate([90,0,0])	
		    cylinder(h=thickness,d=base_height,$fn=100);
//dirky ve dnu
            for (i=[-nix/2:nix/2])
                translate([i*s,0,0])
                    cylinder(h=rantl_thickness,M3_screw_diameter,$fn=100);
//dirky v bocnich stenach	
			for (j=[-nix/2:nix/2], i=[0,0,base_width-rantl_thickness])
                rotate([0,90,0])
                translate([j*s-drzak_height/2,0,-base_width/2+i])
                    cylinder(h=rantl_thickness,M3_screw_diameter,$fn=100);	    //mam tady nejaky nepopsatelny problem s dirama, nechapu
    }
};