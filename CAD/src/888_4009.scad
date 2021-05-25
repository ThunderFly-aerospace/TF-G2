d=20;
delta=15;

inner_l=20;

axToTopofDesk=4;
cylinder_r=6;
cylinder_l=2*inner_l;

ax_offset=10+cylinder_r;

blade_screw_distance=(16.47+11.86)/2;
blade_mount_screw=3;
central_part_screw_distance=3 + 4.5 + blade_mount_screw/2;

circle_fn=40;

central_h=5;


for(angle=[0,180])
{
    rotate([0,0,angle])
    {
        
        difference()
        {
            union()
            {
                hull()
                {
                    translate([0,ax_offset,axToTopofDesk])
                        rotate([0,90,0])
                            cylinder(h=inner_l,r1=cylinder_r,r2=cylinder_r,center=true,$fn=circle_fn);
            
                    translate([0,5,axToTopofDesk+central_h/2-cylinder_r])
                        cube([inner_l,2,central_h],center=true);
                }
                
                hull()
                {
                    translate([central_part_screw_distance,0,axToTopofDesk+central_h/2-cylinder_r])
                        cylinder(h=central_h,d=10,center=true);
                    
                    translate([0,0,axToTopofDesk+central_h/2-cylinder_r])
                        cube([inner_l,2*(ax_offset-cylinder_r),central_h],center=true);
                }
            }
            
            translate([0,0,axToTopofDesk+central_h/2-cylinder_r])
                cylinder(d=3,h=central_h+1,center=true,$fn=circle_fn);
            
            for(i=[-1,1])
                translate([i*central_part_screw_distance,0,axToTopofDesk+central_h/2-cylinder_r])
                    cylinder(d=3,h=central_h+1,center=true,$fn=circle_fn);
            
            
            translate([0,ax_offset,axToTopofDesk])
                        rotate([0,90,0])
                            cylinder(h=inner_l+1,d=3,center=true,$fn=circle_fn);
        
        }
    }
}

