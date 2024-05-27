include <../parameters.scad>


module 888_4011()
{
    h=2;
    l=55;
    w=19;
    
    difference()
    {
        hull()
        {
            cylinder(h=h,d=30, $fn=120, center =true);
            cube([l,w,h], center =true);
        }
        
        //šroubky
        rotate([0,0,free_flap_delta_angle])
            for(i=[-1,1])
                translate([0,i*free_flap_central_part_screw_distance,0])
                    cylinder(d=M3_screw_diameter,h=20,center=true,$fn=30);
                    
        //osa
        cylinder(d=M3_screw_diameter,h=20,center=true,$fn=30);
        
        //dražky
        for(i=[-1,1])
            translate([i*15,0,0])
                #cube([15,1,20],center=true);
    
    
    }
    
    
    
}

888_4011();