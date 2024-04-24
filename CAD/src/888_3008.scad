include<../parameters.scad>

module 888_3008()
{
    d1=tail_pipe_d;
    d2=mount_tube_out_d;
 
    screw_head=plastic_screw_head+0.2;
    screw_hole=plastic_screw_diameter;
    screw_outerhole=plastic_screw_trought_diameter+0.2;
    screw_l=8;

    difference()
    {
        //kvluli tisku kašlu na elenagci
        /*hull()
        {
            cylinder(d=d1+2,h=d2+2,center=true,$fn=60);
            translate([-d1/2-screw_hole,0,0])
                rotate([90,0,0])
                    //cylinder(d=screw_head,h=screw_l+2,center=true,$fn=60);
                    cube([screw_head,screw_head,d1+2],center=true);
            translate([d1/2+d2/2+1,0,0])            
                rotate([90,0,0])
                {
                    cylinder(d=d2+2,h=d1+2,center=true,$fn=60);
                    translate([d2/2+screw_hole,0,0])
                        rotate([90,0,0])
                            cylinder(d=screw_head,h=screw_l+2,center=true,$fn=60);
                }
        }*/
        translate([(d1+d2+1+2*screw_head)/2-d1/2-screw_head,0,0])
            cube([d1+d2+1+2*screw_head+1,d1+2,d2+2],center=true);
        
        //trubka
        cylinder(d=d1,h=20,center=true,$fn=60);
        
        //naříznutí
        translate([-d1/2-1,0,0])
            cube([d1,1,d2+3],center=true);
            
       //šroubek
       translate([-d1/2-screw_head/2,0,0])
       rotate([90,0,0])
       {            
            cylinder(d=screw_hole,h=50,center=true,$fn=30);
            cylinder(d=screw_outerhole,h=50,$fn=30);
            translate([0,0,3])
                cylinder(d=screw_head,h=50,$fn=30);
       }
        
        //druhá trubka
        translate([d1/2+d2/2+1,0,0])            
                rotate([90,0,0])
                {
                    //trubka
                    cylinder(d=d2,h=20,center=true,$fn=60);
                    //nariznutí
                    translate([d2/2+1,0,0])
                        cube([d2,1,d1+3],center=true);
                    //šroubek
                    translate([d2/2+screw_head/2,0,0])
                    rotate([90,0,0])
                    {            
                         cylinder(d=screw_hole,h=50,center=true,$fn=30);
                         cylinder(d=screw_outerhole,h=50,$fn=30);
                         translate([0,0,(screw_l-(d2+2)/2)])                         
                             cylinder(d=screw_head,h=50,$fn=30);
                             
                    }
                }
    
    }
}

888_3008();