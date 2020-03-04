//@set_slicing_config(../slicing/default.ini)

//dil pro pripevneni tazneho motoru
include <../parameters.scad>

sides_height = 80; //vyska sten
lenght = 33; //delka sten z vykresu, nepouzity
thickness = 6; //sirka sten - dost random
drzak_height = 70; //vyska drzaku

base_length = 145; //delka podlozky
base_width = 55; //sirka podlozky
base_height = 10; //vyska podlozky
rantl_thickness = 4; //sirka steny podlozky
niy=13; //pocet der podelne -1
nix=6; //pocet der pricne +1
s=10.16;
M3_screw_diameter = 3.2;


module 888_1002(){
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
		        cylinder(d=base_height,h=thickness,$fn=100); //ma random prumer

//diry na sroubky uvnitr
        for (i=[0,120,240])
            translate([0,thickness/2,drzak_height/2]) //posunuti teziste triketry
                rotate([90,0,0]) //otoceni valecku, aby to byla dirka
                    rotate([0,0,i]) //triketra itself
                        translate([0,drzak_height/6,0]) //ramena triketry
                            cylinder(d=M3_screw_diameter,h=thickness,$fn=50);
//dirky ve dnu
        for (i=[-nix/2:nix/2])
            translate([i*s,0,0])
                cylinder(d=M3_screw_diameter,h=rantl_thickness,$fn=50);
//dirky v bocnich stenach
		for (j=[0:nix], i=[0,0,base_width-rantl_thickness]) //i dělá 2 řady děr, j dělá počet
            rotate([0,90,0])
                translate([j*s-drzak_height+2,0,-base_width/2+i]) //+2 je random posunuti, aby mi valecek nezasahoval do kvadriku
                    cylinder(d=M3_screw_diameter,h=rantl_thickness,$fn=50);
    }
}

}


888_1002();
