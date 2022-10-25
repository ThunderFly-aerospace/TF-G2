use <888_1001.scad>
include <../parameters.scad>

module 888_1001_frontpart()
{
    difference()
    {
        intersection()
        {
            888_1001();
            translate([74,0,0])
                cube([160,100,100],center=true);
        }

        translate([157.75,0,-5])
            cube([10,10,10],center=true);
            
        for(i=[-1,1])
            translate([158.5,i*(base_width/2-6.5),-5])
                rotate([0,0,-i*10])
                    cube([10,7,20],center=true);
        
    }
}

888_1001_frontpart();