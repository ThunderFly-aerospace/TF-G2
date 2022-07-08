




module 888_4046()
{
    outer_d=50;
    inner_d=28;
    h=1.4;
    
    rpm_outer_dst=24;
    rpm_inner_dst=20;
    rpm_d=rpm_outer_dst-rpm_inner_dst;
    rpm_l=5;
    
    pos_outer_dst=19;
    pos_inner_dst=15;
    pos_d=pos_outer_dst-pos_inner_dst;
    pos_l=5;    
    pos_angle_to_rpm_angle=50;
    
    pcb_screw1_to_rpm_angle=60;
    
    pcb_screw1_x=22.6;
    pcb_screw23_x= 7.0;
    pcb_screw23_y = 13.9;
    pcb_screw_d=4.6;    
    
    pcb_h=2.0;
    key_b=1.4;
    key_t=0.6;
    key_h=pcb_h+key_b+key_t;
    key_l=10;
    key_dst=8;
    key_d=inner_d/2-key_dst;
    key_k=1.4;//šírka škvírky
    key_r_dd=1.8;//rozšíření škvírky vzdálenost děr
    key_r_d=12.4;//rozšíření škvírky vzdálenos od osy
    ker_r=2; //rozšíření škvírky polomer vrtání
    
    

    //mezikruží
    difference()
    {
        cylinder(d=outer_d,h=h,$fn=120);                                
        
        //vnitřní díra
        translate([0,0,-0.01])
        cylinder(d=inner_d,h=h+0.02,$fn=120);
        
        //rpm
        translate([rpm_d/2+rpm_inner_dst,0,h/2])
            cube([rpm_d,rpm_l,h+0.02],center=true);
        
        //pos
        rotate([0,0,pos_angle_to_rpm_angle])     
        translate([pos_d/2+pos_inner_dst,0,h/2])
            cube([pos_d,pos_l,h+0.02],center=true);
            
       //pcb screw
       rotate([0,0,-pcb_screw1_to_rpm_angle])
       translate([0,0,-0.01])
       {
           translate([pcb_screw1_x,0,0])
                cylinder(d=pcb_screw_d,h=h+0.02, $fn=60);

            translate([pcb_screw23_x,-pcb_screw23_y,0])
                cylinder(d=pcb_screw_d,h=h+0.02, $fn=60);
                
            translate([pcb_screw23_x,pcb_screw23_y,0])
                cylinder(d=pcb_screw_d,h=h+0.02, $fn=60);
        }
  
  
    }
    
    //klíč
    rotate([0,0,-pcb_screw1_to_rpm_angle])
    difference()
    {
        translate([key_dst,-key_l/2,-(key_h-key_t)])
               cube([key_d,key_l,key_h]);
        
        difference()
        {        
            //pcb
            pcb_l=key_l/2-key_k/2-0.8;
            for(i=[-1,1])
                translate([key_dst+key_d/2,i*(pcb_l/2+key_k/2),-pcb_h/2])
                   cube([key_d+0.02,pcb_l,pcb_h],center=true);
            
            //rozšíření škvírkyv pcb
           /* hull()
            {
                for(i=[-1,1])
                    translate([key_r_d,i*key_r_dd/2,-pcb_h/3])
                        cylinder(h=pcb_h/3,d=ker_r,$fn=120);
                
            }  */                      
        }
        
        //zaříznutí 
        translate([key_r_d+5/2+ker_r/2,0,-pcb_h/2])
           cube([5,key_k+0.02,pcb_h],center=true);
                
               
    }
    
    //podpera pro tisk
    rotate([0,0,-pcb_screw1_to_rpm_angle])
    {
        translate([key_dst,0,h/2])
            cube([1,key_l,h],center=true);
   
        translate([key_dst+key_d/2,0,h/2])
            cube([1,key_l,h],center=true);
    }
    
}


888_4046();