include <../parameters.scad>


module 888_4009()
{

ax_length=free_flap_ax_length;
ax_diameter=free_flap_ax_diameter;

bearings_length=free_flap_bearings_length;
bearings_outer_diameter=free_flap_bearings_outer_diameter;
bearings_ring_diameter=free_flap_bearings_ring_diameter;
bearings_ring_h=free_flap_bearings_ring_h;


negativ_flap_limit=free_flap_negativ_flap_limit;
bearing_add=free_flap_bearing_add;
desk_add=free_flap_desk_add;
desk_h=free_flap_desk_h;

delta_angle=free_flap_delta_angle;
blade_screw_distance=free_flap_delta_angle;
central_part_screw=free_flap_central_part_screw;
central_part_screw_distance=free_flap_central_part_screw_distance;

circle_fn=free_flap_circle_fn;
ax_offset=free_flap_ax_offset;

shaft_l=free_flap_shaft_l;
shaft_h=free_flap_shaft_h;
shaft_neck_l=free_flap_shaft_neck_l;
rubber_spring_d=5;

difference()
{

    union()
    {
    for(r=[0,180])
        hull()
        {
            rotate([0,0,r])
            {
                translate([ax_offset,0,(bearings_outer_diameter+bearing_add)/2])
                    rotate([0,0,delta_angle])
                        rotate([90,0,0])
                        {
                            cylinder(d=bearings_outer_diameter+bearing_add,h=ax_length-0.01, center=true,$fn=circle_fn);
                            translate([2,-desk_add,0])
                                cylinder(d=bearings_outer_diameter+bearing_add,h=ax_length-2, center=true,$fn=circle_fn);
                            //hacek
                            /*translate([0,bearings_outer_diameter,0])
                              cylinder(d=bearings_outer_diameter+bearing_add,h=ax_length+3, center=true,$fn=circle_fn);*/

                        }

            rotate([0,0,delta_angle])
                /*translate([0,0,desk_h/2-desk_add])
                    cube([desk_l,desk_w,desk_h],center=true);*/
                for(i=[-1,1])
                {
                    translate([0,i*(central_part_screw_distance-1),desk_h/2-desk_add])
                        cylinder(d=10,h=desk_h, center=true,$fn=circle_fn);
                }
           }
        }
        
        //materiál pod matičkou
        cylinder(d=11,h=desk_h, $fn=circle_fn);
     }

    for(r=[0,180])
        rotate([0,0,r])
        {
            //díra pro flap osu pro list
            translate([ax_offset,0,(bearings_outer_diameter+bearing_add)/2])
                rotate([0,0,delta_angle])
                {
                    rotate([90,0,0])
                        cylinder(d=ax_diameter+0.1,h=ax_length+5, center=true,$fn=circle_fn);

                    //díra pro list
                    /*#translate([(bearings_outer_diameter+bearing_add)/2,0,shaft_h*3/2])
                        cube([2*(bearings_outer_diameter+bearing_add)+0.1,shaft_l+0.1,3*shaft_h],center=true);*/
                    //díra pro list v záporném flappingu
                    rotate([0,negativ_flap_limit,0])
                    {
                        /*translate([(bearings_outer_diameter+bearing_add)/2+1,0,shaft_h/2])
                            cube([2*(bearings_outer_diameter+bearing_add),shaft_l+0.2,2*shaft_h+0.2],center=true);*/

                        hull()
                        {
                            for(yy=[-1,1])
                                translate([ax_diameter/2+M3_screw_diameter/2,yy*4,0])
                                    cylinder(d=M3_head_diameter,h=20,center=true,$fn=100);
                           translate([ax_diameter/2+M3_screw_diameter/2+5,0,-0])
                                cube([M3_head_diameter,ax_length-2*bearings_length+2*bearings_ring_h,20],center=true);
                        }
                    }

                }

            //díra pro ložiska
            for(i=[-1,1])
                translate([ax_offset,0,(bearings_outer_diameter+bearing_add)/2])
                    rotate([0,0,delta_angle])
                        translate([0,i*(shaft_l/2+bearings_length/2),0])
                            rotate([90,0,0])
                                cylinder(d=bearings_outer_diameter,h=bearings_length, center=true, $fn=circle_fn);
                                
           //díra pro hranu ložiska
           for(i=[-1,1])
                translate([ax_offset,0,(bearings_outer_diameter+bearing_add)/2])
                    rotate([0,0,delta_angle])
                        translate([0,i*(shaft_l/2+bearings_ring_h/2-5),0])
                            rotate([0,negativ_flap_limit,0])
                            rotate([90,0,0])
                              hull()
                              {
                                cylinder(d=bearings_ring_diameter,h=bearings_ring_h+10, center=true, $fn=circle_fn);
                                translate([bearings_ring_diameter,0,0])
                                   cylinder(d=bearings_ring_diameter,h=bearings_ring_h+10, center=true, $fn=circle_fn);
                                translate([0,bearings_ring_diameter,0])
                                   cylinder(d=bearings_ring_diameter,h=bearings_ring_h+10, center=true, $fn=circle_fn);
                              }

              
                                
            //hacek pro gumu
            /*translate([ax_offset,0,(bearings_outer_diameter+bearing_add)/2])
                rotate([0,0,delta_angle])
                    rotate([90,0,0])
                        translate([-2.5,bearings_outer_diameter+1.5,0])
                            cylinder(d=rubber_spring_d,h=ax_length+6, center=true,$fn=circle_fn);*/
        }

        //díra pro matičku rotoru
        hull()
        {
            translate([0,0,5+desk_h/2])
                        cylinder(d=11,h=10, center=true, $fn=circle_fn);

            //elegance
            for(rr=[0,180])
                rotate([0,0,rr])
                {
                    difference()
                    {
                        translate([ax_offset,0,(bearings_outer_diameter+bearing_add)/2])
                            rotate([0,0,delta_angle])
                                translate([-(bearings_outer_diameter+bearing_add)/4,0,shaft_h])
                                    cube([(bearings_outer_diameter+bearing_add)/2,shaft_l+2*bearings_ring_h+0.1,2*shaft_h],center=true);

                        hull()
                        {
                            translate([ax_offset,0,(bearings_outer_diameter+bearing_add)/2])
                            rotate([0,0,delta_angle])
                                rotate([90,0,0])
                                    cylinder(d=bearings_outer_diameter+bearing_add,h=ax_length+1, center=true,$fn=circle_fn);

                            rotate([0,0,delta_angle])
                                for(i=[-1,1])
                                {
                                    translate([0,i*central_part_screw_distance,desk_h/2-desk_add])
                                        cylinder(d=10,h=desk_h, center=true,$fn=circle_fn);
                                }
                        }
                    }
               }
        }
        
        
        for(i=[-1,1])
        {
         rotate([0,0,delta_angle])
            translate([0,i*central_part_screw_distance,0])
            {
                cylinder(d = M3_screw_diameter, h =  30, center=true, $fn = circle_fn);
                translate([0,0,desk_h/2])
                    cylinder(d = M3_nut_diameter, h =  30, $fn = 6);
            }
        }

        
        cylinder(d=M3_screw_diameter,h=10, center=true, $fn=circle_fn);
}


}

888_4009();
