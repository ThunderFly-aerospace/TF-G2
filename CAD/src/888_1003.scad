//bocni steny

include <../parameters.scad>

sides_height = 90; //vyska sten
length = 330; //delka sten z vykresu, nepouzity
thickness = 3; //sirka sten
drzak_height = 70; //spatny rozmer so far

base_length = 145; //delka podlozky
base_width = 61; //sirka podlozky
base_height = 10; //vyska podlozky
rantl_thickness = 4; //sirka steny podlozky
niy=13; //pocet der podelne -1
nix=6; //pocet der pricne +1
s=10.16;
M3_screw_diameter = 3.2;

module 888_1003(){

	difference(){
		hull(){
//kvadrik ("spolecny s podlozkou")
                translate([-base_width/2,-length/2,0])
		            cube([thickness,length,base_height]);
//zaobleni spodnich rohu dilu		            
		    for (j=[0,length,0])
		    	translate([-base_width/2,j-length/2,base_height/2])
			    rotate([0,90,0])
			    	cylinder(d=base_height,h=thickness,$fn=100);
//zaobleni v nejvyssim miste dilu		    		
		    	translate([-base_width/2,-length/4,sides_height/2])		
			    rotate([0,90,0])	
			    	cylinder(d=3*base_height,h=thickness,$fn=100);
//zaobleni #3		    		
		    	translate([-base_width/2,length/4,sides_height/3])	
			    rotate([0,90,0])	
			    	cylinder(h=thickness,d=2*base_height,$fn=100);					
		}
//dirky v bocnich stenach na prisroubovani k podlozce
            for (j=[-niy:niy])
                rotate([0,90,0])   
	            translate([-rantl_thickness-(base_height-rantl_thickness)/2,j*s,-base_width/2])
	                cylinder(d=M3_screw_diameter,h=10,$fn=50, center = true);
//dirky v bocnich stenach na prisroubovani drzaku
			#for (j=[0:nix]) //i dělá 2 řady děr, j dělá počet
            	rotate([0,90,0])
            	translate([j*s-drzak_height+2,-length/4,-base_width/2]) //+2 je random posunuti, aby mi valecek nezasahoval do kvadriku
                	cylinder(d=M3_screw_diameter,h=thickness,$fn=100);	
	}
}

888_1003(); 

//druha stena - spise k nicemu, pro predstavu
mirror()888_1003();