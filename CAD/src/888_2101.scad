module leg()
{
big_tube_d=22.9;
bid_tube_out_d=25.4;
tube_l=40;
tube_screw_l=25;
small_tube_d=10.3;
sm_t_angle=70;
big_skelet_d=big_tube_d+20;
joint_d=40;
joint_h=30;    
tube_hole=3*joint_d;
sm_screw=3.1;
sm_maticka=7;
big_screw=3.1;
    
    
    
circle_fn=100;    

difference()
    {
    union()
        {

        translate([0,0,tube_l/2])
            cylinder(d=big_tube_d,h=tube_l, center=true,$fn=circle_fn);

        difference()
            {
            translate([0,0,-joint_h])
                cylinder(d=joint_d,h=joint_h+tube_l,$fn=circle_fn);
                
            translate([0,0,tube_l/2])        
                cylinder(d=bid_tube_out_d,h=tube_l+0.01, center=true,$fn=circle_fn);
            
            }
        }
       //tenká trubka nohy
       translate([0,0,-joint_h/2]) 
        rotate([sm_t_angle,0,0])
                cylinder(d=small_tube_d,h=tube_hole, center=true,$fn=circle_fn);
        
        //šroubek tenké trubky
        translate([0,0,-joint_h/2]) 
            rotate([0,90,0])
                    cylinder(d=sm_screw,h=tube_hole, center=true,$fn=circle_fn);
        
        //šroubek tulsté trubky
        translate([0,0,tube_screw_l]) 
            rotate([90,0,0])
                    cylinder(d=big_screw,h=tube_hole, center=true,$fn=circle_fn);
        
        //matičky - tenká trubka
       translate([joint_d/2,0,-joint_h/2]) 
            rotate([0,90,0])
                    cylinder(d=sm_maticka,h=4, center=true,$fn=6);
       translate([-joint_d/2,0,-joint_h/2]) 
            rotate([0,90,0])
                    cylinder(d=sm_maticka,h=4, center=true,$fn=6);
                    
       //matičky tlustá trubka
       translate([0,joint_d/2,tube_screw_l]) 
            rotate([90,0,0])        
                 translate([0,0,0])
                    cylinder(d=sm_maticka,h=4, center=true,$fn=6);
       translate([0,-joint_d/2,tube_screw_l]) 
            rotate([90,0,0])
                    cylinder(d=sm_maticka,h=4, center=true,$fn=6);
        
    }
}

leg();