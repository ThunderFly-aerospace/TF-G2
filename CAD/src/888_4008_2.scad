include <../parameters.scad>

module 888_4008()
{
    h=21.6;
    top_d=27;
    center_d=30;
    center_h=3;
    bottom_d=51;
    neck_d=16;
    
    sensor_inner_d=29.8;
    sensor_outer_d=47.8;
    sensor_h=3.6;
    
    rotor_nut_h=5.5;
    rotor_nut_d=M3_nut_diameter;
    rotor_screw_dst=9;
    rotor_screw_d=3;
    
    pcb_screw_d=2;
    pcb_screw_h=9;
    pcb_screw_dst=11;
    pcb_screw_num=3;
    
    difference()
    {
        cylinder(d=bottom_d,h=h,$fn=120);
    
        //místo pro krček
        translate([0,0,-0.01])
        difference()
        {
            cylinder(d=neck_d,h=h-rotor_nut_h/2,$fn=120);
            //osazení k ložisku a kryt matiček rotoru
            translate([0,0,h-rotor_nut_h])
            hull()
            {
                cylinder(d1=rotor_nut_d+1,d2=neck_d,h=rotor_nut_h,$fn=120);
                for(i=[-1,1])
                {
                    translate([i*rotor_screw_dst,0,1])
                        cylinder(d=rotor_nut_d+1,h=rotor_nut_h-1,$fn=120);                    
                }
            }
        }
        
        
       //zkosení       
       translate([0,0,h-rotor_nut_h])
       difference()
       {
            cylinder(d=bottom_d+0.01,h=rotor_nut_h+0.01,$fn=120);
            cylinder(d1=bottom_d,d2=top_d,h=rotor_nut_h,$fn=120);
       }
            
            
       //matice rotoru     
       translate([0,0,h-rotor_nut_h-0.1])
            cylinder(d = rotor_nut_d+0.05, h = rotor_nut_h+0.2, $fn = 6);
            
       //šrouby rotoru a kapsy na matice rotoru
       for(i=[-1,1])
       {
            nut_h=3;
            translate([i*rotor_screw_dst,0,h-nut_h])
                cylinder(d=rotor_screw_d,h=rotor_nut_h,$fn=120);
            
            subscrew_h=rotor_nut_h-nut_h-1.5-0.3;
            translate([i*rotor_screw_dst,0,h-rotor_nut_h])
                cylinder(d=rotor_screw_d,h=subscrew_h,$fn=120);
                        
            hull()
            {
                nut_h=3;
                translate([i*rotor_screw_dst,0,h-1.5-nut_h])
                    cylinder(d=M3_nut_diameter,h=nut_h,$fn=6);
                    
                translate([i*100,0,h-1.5-nut_h])
                    cylinder(d=M3_nut_diameter,h=nut_h,$fn=6);
            }
       }
            
       //senzory
       translate([0,0,-0.01])         
       difference()
       {
            cylinder(d=sensor_outer_d,h=sensor_h,$fn=120);
            cylinder(d=sensor_inner_d,h=sensor_h+1,$fn=120);
       }
       
       
       //špulka
       translate([0,0,sensor_h])
       {
            difference()
            {
                spulka_h=h-sensor_h-rotor_nut_h;
                cylinder(d=bottom_d+0.01,h=spulka_h,$fn=120);
            
                cylinder(d1=bottom_d,d2=center_d,h=spulka_h/2-center_h/2,$fn=120);
                translate([0,0,spulka_h/2-center_h/2])
                    cylinder(d=center_d,h=center_h,$fn=120);
                translate([0,0,spulka_h/2+center_h/2])
                    cylinder(d2=bottom_d,d1=center_d,h=spulka_h/2-center_h/2,$fn=120);
            }
       }
       
       //dírka pro dráta
       rotate([0,0,90])
       {
           drat_d=2.5;
           translate([0,0,drat_d/2-0.01])
                cube([sensor_inner_d,2*drat_d,drat_d],center=true);
           for(i=[-1,1])
           {
                //svislé vedení
                translate([i*(neck_d/2+drat_d/4),0,0])
                    cylinder(d=drat_d,h=h-rotor_nut_h,$fn=60);
                
                translate([i*(neck_d/2+drat_d/4),0,h-rotor_nut_h])
                    rotate([0,i*65,-90])
                        translate([0,0,-2])
                            cylinder(d=drat_d,h=h-rotor_nut_h,$fn=60);
           }
       }
       
       //pcb screws
       for (i = [1:pcb_screw_num])
         rotate([0, 0, i*360/pcb_screw_num])
            translate([pcb_screw_dst,0,-0.01])
                cylinder(d=pcb_screw_d,h=pcb_screw_h,$fn=60);
                
       //rope hole
       translate([0,0,(h-sensor_h-rotor_nut_h)/2+sensor_h])
       rotate([0,90,0])
            cylinder(d=3,h=100,$fn=60,center=true);
            
      //sražení vršku
      for(i=[-1,1])
      translate([0,i*19/2,h])
        rotate([-1*i*19,0,0])
            translate([0,0,top_d/2])
                cube([top_d,2*top_d,top_d],center=true);
      
      
    }


}


888_4008();