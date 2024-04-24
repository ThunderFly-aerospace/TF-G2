// Jiny drzak ocasni tyce

include<../parameters.scad>

module 888_3007()
{
    w=base_width;    
    d=tail_pipe_d;
    
    screw_head=plastic_screw_head+0.2;
    screw_hole=plastic_screw_diameter;
    screw_outerhole=plastic_screw_trought_diameter+0.2;
    screw_l=8;
    
    o=10;
    l=screw_head+1;

    difference()
    {
        hull()
        {
            rotate([90,0,0])
                cylinder(d=l,h=w,center=true,$fn=60);
            translate([o+d/2+l/2,0,0])
                rotate([90,0,0])
                    cylinder(d=l,h=d+4,center=true,$fn=60);
        }
        
        //trubka
        translate([o,0,0])
            cylinder(d=d,h=l+2,center=true,$fn=60);
        
        //naříznutí
        translate([o+d/2,0,0])
            cube([d,1,l+2],center=true);
            
        //šroubek
        translate([o+d/2+l/2,0,0])
                rotate([90,0,0])
                {                    
                    cylinder(d=screw_hole,h=50,center=true,$fn=30);
                    cylinder(d=screw_outerhole,h=50,$fn=30);
                    translate([0,0,3])                         
                         cylinder(d=screw_head,h=50,$fn=30);
                }
                
        //šroubky do bočnic
        rotate([90,0,0])
        for(i=[-1,1])
            translate([0,0,i*w/2])
        cylinder(d=screw_hole,h=20,center=true,$fn=30);       
        
    }
}


888_3007();