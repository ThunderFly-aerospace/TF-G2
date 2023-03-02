// Drzak ocasni tyce pod podlozkou

include<../parameters.scad>
module 888_3006(){
    holder_wall_thickness = 2;
    offset=tail_pipe_d/2+holder_wall_thickness+1.45;
    mount_h=9;
 
    difference(){
        union(){
            cube([10, base_width+1, 3], center=true);
            
            for(i=[-1,1])
            translate([0,i*(base_width/2+3),-(base_thickness+rantl_height+1)/2])
                cube([10,6,base_thickness+rantl_height+3+1],center=true);

            translate([0, 0, offset])
                rotate([0, 90, 0])
                    cylinder(d=tail_pipe_d + 2*holder_wall_thickness, h=10, center = true, $fn=$preview?80:150);
            translate([0, 0, tail_pipe_d/2 +mount_h/2+offset ])
                cube([10, 4*holder_wall_thickness, mount_h], center=true);
        }

        translate([0, 0, tail_pipe_d/2 +mount_h/2+offset ])
            cube([11, 2, tail_pipe_d], center=true);

        translate([0, 0, offset])
            rotate([0, 90, 0])
                cylinder(d=tail_pipe_d, h=10.2, center = true, $fn=$preview?80:150);

        /*for(y = [-10, 10]){
            translate([0, y, -3/2-.1])
                cylinder(d=M3_screw_diameter, h = 2*holder_wall_thickness, $fn=$preview?80:150);
        }*/

        translate([0, 0, tail_pipe_d/2+offset+mount_h/2])
            rotate([90, 0, 0]){
                cylinder(d=M3_screw_diameter, h = 20, center = true, $fn=$preview?80:150);
                rotate(30)
                    translate([0, 0, 2*holder_wall_thickness - M3_nut_height/2 ])
                        cylinder(d=M3_nut_diameter, h = 20, $fn=6);
        }
        
        //bočnice
        translate([0,0,-(6+1.5)])
            cube([12,base_width+2*side_base_thickness,12], center=true);
        translate([0,0,-(1.5+1)])
            cube([12,base_width+2*(3+0.2),2], center=true);
        translate([0,0,-(1.5+base_thickness+rantl_height)])
            cube([12,base_width+2*(3+0.2),2], center=true);
            
        translate([0,0,-1.5-base_thickness -rantl_height/2])
            rotate([90,0,0])
            cylinder(d=M3_screw_diameter,h=2*base_width,center=true,$fn=60);
        
        //lámač
        translate([0,0,-5.5])
            rotate([0,90,0])
                cylinder(d=10,h=15,$fn=4,center=true);
            #for(i=[-1,1])
                translate([0,i*(base_width/2+2.7),-1.5])
                    rotate([i*30,0,0])
                    rotate([0,90,0])                    
                    cylinder(h=12, d=2,center=true,$fn=3);

        
    }
}

888_3006();
