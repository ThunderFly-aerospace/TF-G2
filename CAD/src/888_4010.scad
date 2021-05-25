d=20;
delta=15;

inner_l=20;

axToTopofDesk=4;
cylinder_r=6;
cylinder_l=2*inner_l;

ax_offset=7.5;

blade_screw_distance=(16.47+11.86)/2;

circle_fn=40;

difference()
{
    union()
    {
        hull()
        {
        translate([0,ax_offset,axToTopofDesk])
            rotate([0,90,0])
                cylinder(cylinder_l,cylinder_r,cylinder_r, center=true, $fn=circle_fn);
            
        //konec obalu
        rotate([0,0,delta])
            translate([0,-1+d+ax_offset,-1])
                cube([17,2,2], center=true);
        }

        //upevnění listu        
            rotate([0,0,delta])
                translate([0,d+ax_offset,-1])
                    difference()
                    {
                        translate([0,26/2-1,0])
                            cube([17,25+1,2], center=true,$fn=circle_fn);
                        translate([0,25/2-blade_screw_distance/2,0])
                            cylinder(h=10,d=3,center=true,$fn=circle_fn);
                        translate([0,25/2+blade_screw_distance/2,0])
                            cylinder(h=10,d=3,center=true,$fn=circle_fn);
                    }
        
    }
    translate([0,ax_offset,axToTopofDesk])
        rotate([0,90,0])
            cylinder(h=cylinder_l+2,d=3,center=true,$fn=circle_fn);
        
    translate([0,ax_offset,axToTopofDesk])
        cube([inner_l+1,2*cylinder_r+1,50],center=true);
    
}
        
        