include <../parameters.scad>


module 888_4010(colective=1.5)
{

ax_length=free_flap_ax_length;
ax_diameter=free_flap_ax_diameter;

bearings_length=free_flap_bearings_length;
bearings_outer_diameter=free_flap_bearings_outer_diameter;
negativ_flap_limit=free_flap_negativ_flap_limit;
bearing_add=free_flap_bearing_add;
desk_add=free_flap_desk_add;
desk_h=free_flap_desk_h;

delta_angle=free_flap_delta_angle;
blade_screw_distance=free_flap_blade_screw_distance;
central_part_screw=free_flap_central_part_screw;
central_part_screw_distance=free_flap_central_part_screw_distance;

circle_fn=free_flap_circle_fn;
ax_offset=free_flap_ax_offset;

shaft_l=free_flap_shaft_l-0.2;
shaft_h=free_flap_shaft_h;
shaft_neck_l=free_flap_shaft_neck_l;

cut_d=free_flap_cut_d;
cut_h=free_flap_cut_h;
cut_w=free_flap_cut_w;

blade_d=free_flap_blade_d;
blade_holder_h=free_flap_blade_holder_h;

blade_holder_l=free_flap_blade_holder_l;
blade_h=free_flap_blade_h;
blade_w=free_flap_blade_w;
blade_first_screw=free_flap_blade_first_screw;

blade_holder_radius=free_flap_blade_holder_radius;
rubber_spring_d=5;


difference()
{
    union()
    {

        hull()
        {

        //shaft
        rotate([0,0,delta_angle])
            rotate([90,0,0])
                cylinder(d=shaft_h,h=shaft_l,center=true,$fn=circle_fn);

        //shaft neck
        rotate([0,0,delta_angle])
            translate([shaft_neck_l-0.05,0,0])
                cube([.01,shaft_l,shaft_h],center=true);
        }
        
        hull()
        {

            //shaft neck
            rotate([0,0,delta_angle])
                translate([shaft_neck_l-0.05,0,0])
                    cube([.01,shaft_l,shaft_h],center=true);


            //printing support
            rotate([colective,0,0])
                translate([cut_d/2-0.5,-blade_w/2+0.05,0])
                    cube([0.1,0.1,shaft_h],center=true);                   
            rotate([colective,0,0])
                translate([cut_d-0.1,-blade_w/2+0.05,0])
                    cube([0.1,0.1,cut_h],center=true);

            //cut neck
            translate([cut_d-0.5,0,0])
                cube([0.1,cut_w,cut_h],center=true);
        }
        
        //printing support between part
        rotate([colective,0,0])
                translate([cut_d+1.5,-blade_w/2+0.4,0])
                    cube([16,0.8,2*blade_holder_h+blade_h],center=true);   

        hull()
        {
        //cut neck
        translate([cut_d-0.5,0,0])
            cube([0.1,cut_w,cut_h],center=true);

        //blade hodler
        rotate([colective,0,0])                
           for(j=[-1,1])
           {               
              translate([blade_d+blade_holder_l/2,(blade_w/2-blade_holder_radius/2),j*((2*blade_holder_h+blade_h)/2-blade_holder_radius/2)])
                  rotate([0,90,0])
                            cylinder(d=blade_holder_radius,h=blade_holder_l,center=true,$fn=circle_fn);
                            
              #translate([blade_d+blade_holder_l/2,-1*(blade_w/2-0.1/2),j*((2*blade_holder_h+blade_h)/2-0.1/2)])
                  rotate([0,90,0])
                            cylinder(d=0.1,h=blade_holder_l,center=true,$fn=circle_fn);
           }

        }

        // rotor blade spring
        /*hull()
        {
            //cut neck
            translate([cut_d-0.5,0,0])
                cube([0.1,cut_w,cut_h],center=true);

            //rubber ring holder
            rotate([colective,0,0])
              translate([blade_d,-blade_holder_radius/2,((3*blade_holder_h+blade_h)/2)])
                    rotate([90,0,0])
                        cylinder(d=2*rubber_spring_d,h=blade_w-blade_holder_radius,center=true,$fn=circle_fn);
        }*/

        //blade hodler screw nuts cylnders
        rotate([colective,0,0])
        {
            translate([blade_first_screw+blade_d,0,-(2*blade_holder_h+blade_h)/2])
                cylinder(d=10,h=M3_nut_height,center=true,$fn=circle_fn);

            translate([blade_screw_distance+blade_first_screw+blade_d,0,-(2*blade_holder_h+blade_h)/2])
                cylinder(d=10,h=M3_nut_height,center=true,$fn=circle_fn);
        }

        //krčky pro matičky
       rotate([0,0,delta_angle])
       {
          for(yy =[-4,4])
             translate([ax_diameter/2+M3_screw_diameter/2,yy,3])
             {
                cylinder(d=M3_nut_diameter+1.5,h=M3_nut_height,center=true,$fn=100);
             }
       }
    }

    //gumičky
    /*rotate([colective,0,0])
      translate([blade_d,-blade_holder_radius/2,((3*blade_holder_h+blade_h)/2+1)])
      {
            rotate([90,0,0])
                cylinder(d=rubber_spring_d,h=blade_w,center=true,$fn=circle_fn);
            translate([rubber_spring_d/2,0,-rubber_spring_d/12])
                cube([cut_d/2,blade_w,rubber_spring_d-rubber_spring_d/6],center=true);
      }
    */


    //díra pro list
    rotate([colective,0,0])
    {
        hull()
        {
            translate([blade_d+blade_holder_l/2,0,0])
                cube([blade_holder_l+0.1,blade_w+0.1,blade_h],center=true);
            translate([blade_d,0,0])
                rotate([90,0,0])
                    cylinder(d=blade_h,h=blade_w+0.1,center=true,$fn=100);
            translate([blade_d-5,0,0])
                sphere(d=blade_h*3/4, $fn=100);
        }

        //díry pro přišroubování listu
        translate([blade_first_screw+blade_d,0,0])
            cylinder(d=blade_mount_screw,h=2* (blade_h+2*blade_holder_h),center=true,$fn=circle_fn);

        translate([blade_first_screw+blade_d,0, 2* (blade_h+blade_holder_h)+1])
            cylinder(d=M3_head_diameter_ISO7380,h=2* (blade_h+2*blade_holder_h),center=true,$fn=circle_fn);


        translate([blade_screw_distance+blade_first_screw+blade_d,0,0])
            cylinder(d=blade_mount_screw,h=2* (blade_h+2*blade_holder_h),center=true,$fn=circle_fn);


        //matičky
        translate([blade_first_screw+blade_d,0,-(2*blade_holder_h+blade_h)/2-0.1])
            cylinder(d=M3_nut_diameter,h=M3_nut_height,center=true,$fn=6);

        translate([blade_screw_distance+blade_first_screw+blade_d,0,-(2*blade_holder_h+blade_h)/2-0.1])
            cylinder(d=M3_nut_diameter,h=M3_nut_height,center=true,$fn=6);

          //popisky
        translate([blade_first_screw+blade_d+blade_screw_distance/2, 0, (2*blade_holder_h+blade_h)/2-0.5])
          linear_extrude(4)
                text(str(colective), size = 4, halign="center", valign="center");
    }

    //zabroušení usazení a díra pro osu
    rotate([0,0,delta_angle])
    {
        translate([0,shaft_l,0])
            cube([2*shaft_neck_l,shaft_l,2*shaft_h],center=true);
        translate([0,-shaft_l,0])
            //cube([4*shaft_neck_l,shaft_l,2*shaft_h],center=true);
            cube([2*shaft_neck_l,shaft_l,2*shaft_h],center=true);

        //díra pro osu
        rotate([90,0,0])
            cylinder(d=ax_diameter,h=shaft_l+1,center=true,$fn=circle_fn);
        translate([ax_diameter/2+3.5-0.1,0,0])
            cube([7,shaft_l+1,1],center=true);

        //přitažení osičky
        for(yy =[-4,4])
            translate([ax_diameter/2+M3_screw_diameter/2,yy,0])
            {
                cylinder(d=M3_screw_diameter,h=15,center=true,$fn=100);
                //matička
                translate([0,0,4])
                    rotate([0,0,30])
                        cylinder(d=M3_nut_diameter,h=3,center=true,$fn=6);
                //šroubek
                translate([0,0,-4])
                    cylinder(d=7.1,h=M3_head_height,center=true,$fn=100);
            }
    }

}
}

/*intersection()
{
    888_4010();
    translate([0,46,0])
        rotate([0,0,free_flap_delta_angle])
            cube([100,100,100], center=true);
}*/

888_4010();
