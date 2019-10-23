//bocni steny

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

module 888_1003(){

difference(){
		hull(){
//+2 kvadriky
                translate([-base_width/2,-base_length/2,0])
		            cube([thickness,base_length,base_height]);
//zaobleni spodnich rohu dilu		            
		    for (j=[0,base_length,0])
		    	translate([-base_width/2,j-base_length/2,base_height/2])
			    	rotate([0,90,0])
			    		cylinder(h=thickness,d=base_height,$fn=100);
//zaobleni v nejvyssim miste dilu		    		
		    	translate([-base_width/2,-base_length/4,sides_height/2])	
			    	rotate([0,90,0])	
			    		cylinder(h=thickness,d=3*base_height,$fn=100);
//zaobleni #3		    		
		    	translate([-base_width/2,base_length/4,sides_height/2])	
			    	rotate([0,90,0])	
			    		cylinder(h=thickness,d=2*base_height,$fn=100);
					
		}
//dirky v bocnich stenach na prisroubovani k podlozce
            for (j=[-niy/2:niy/2])
                rotate([0,90,0])   
	                translate([-rantl_thickness-(base_height-rantl_thickness)/2,j*s,-base_width/2])
	                    cylinder(h=10, d = M3_screw_diameter,$fn=50, center = true);
	}


}

888_1003(); 

//druha stena - spise k nicemu, pro predstavu
mirror()888_1003();