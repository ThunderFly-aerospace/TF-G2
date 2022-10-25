use <888_1001.scad>
include <../parameters.scad>
//use <888_1001_frontpart.scad>

module 888_1001_rearpart()
{
    difference()
    {
        888_1001();
        translate([75,0,0])
            cube([160,100,100],center=true);
    }

    difference()
    {
        union()
        {            
            for(i=[-1,1])            
                hull()
                {
                    translate([150,10*i,-rantl_height/2-base_thickness])
                        cylinder(d=11,h=4+base_thickness,$fn=60);
                    
                    translate([160,(base_width/2-5)*i,-rantl_height/2-base_thickness/2])
                        cube([5,5,base_thickness],center=true);
                    
                }
            hull()
                for(i=[-1,1])
                   translate([150,10*i,-rantl_height/2-base_thickness])
                      cylinder(d=11,h=4+base_thickness,$fn=60); 
                
            hull()
            {
                translate([165,0,-rantl_height/2-base_thickness/2])
                    cube([1,5.5,base_thickness],center=true);
                
                translate([155,0,-rantl_height/2-base_thickness/2+2])
                    cube([1,8,4+base_thickness],center=true);

            }
        }
            
        
        for(i=[-1,1])
            translate([150,10*i,-rantl_height/2-base_thickness-0.005])
            {
                cylinder(d=9,h=base_thickness+0.6,$fn=60);
                translate([0,0,4+base_thickness-0.5])
                    cylinder(d=M3_screw_diameter,h=5,$fn=60,center=true);
                translate([0,0,4+base_thickness+1.5])
                    cylinder(d=M3_nut_diameter,h=5,$fn=6,center=true);
            }
                
        translate([143.6,0,-rantl_height/2-base_thickness/2+0.5-0.005])       
            cube([20,8,base_thickness+1],center=true);
        
        translate([150,0,-rantl_height/2-base_thickness/2+0.3-0.005])       
            cube([7+0.2,base_width,base_thickness+0.6],center=true);
           
        for(i=[-1,1])
            translate([150,i*(base_width/2+14),-rantl_height/2-base_thickness/2+0.5-0.005])       
                cube([7+0.2,base_width,base_thickness+1],center=true);
            
   }
        
   
    
}

888_1001_rearpart();


//locktest
/*intersection()
{
    888_1001_frontpart();
    translate([150,0,0])
        cube([40,100,100],center=true);
}

//translate([20,0,0])
intersection()
{
    888_1001_rearpart();
    translate([150,0,0])
        cube([40,100,100],center=true);
}*/

