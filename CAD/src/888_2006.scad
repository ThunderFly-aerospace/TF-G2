include <../parameters.scad>
use <888_1003.scad>

module 888_2006(draft=true)
{
    top_leg_screw_pos_x=270;
    top_leg_screw_pos_y=-10;
    x_border=11;


    height_above_top_leg_screw=22;
    leg_screw_dy = 20;
    height_below_low_leg_screw=5;

    thickness=5;

    box_h=height_above_top_leg_screw+leg_screw_dy+height_below_low_leg_screw;
    length=leg_screw_dy+2*x_border;



    difference()
    //intersection()
    {
        translate([top_leg_screw_pos_x-x_border,-box_h+(height_above_top_leg_screw+top_leg_screw_pos_y),1.2])
                cube([length,box_h,thickness]);


        888_1003();
        /*translate([260,0,0])
            cylinder(d=8, h = 8,$fn=60);*/

        //šroubky pro nohy
        translate([top_leg_screw_pos_x+leg_screw_dy/2,top_leg_screw_pos_y-leg_screw_dy/2,1.2])
        {
            for(xx=[-leg_screw_dy/2, leg_screw_dy/2])
                for(yy=[-leg_screw_dy/2, leg_screw_dy/2])
                {
                     translate([xx,yy,0])
                     {
                        translate([0,0,-15])
                            cylinder(d= M3_screw_diameter, h = 30,$fn=60);
                        translate([0,0,-5])
                            cylinder(d = M3_nut_diameter, h = M3_nut_height+5, $fn = 6);
                     }

                }

        }

        translate([top_leg_screw_pos_x + leg_screw_dy/2,-box_h + height_above_top_leg_screw + top_leg_screw_pos_y + leg_screw_dy/2,1.2])
            cylinder(d=mount_tube_out_d, h = 8,$fn=60);


        //šroubky platformy
        // dolni rada
        for(x = [20:10:base_length])
              translate([x,  -base_thickness+rantl_height/3*2, -0.1])
              {
                  translate([0,0,-10+thickness-M3_nut_height+1.2-0.1])
                    cylinder(d = M3_screw_diameter+0.1, h = 10, $fn = 50);
                  translate([0,0,thickness-M3_nut_height+1.2])
                    cylinder(d = M3_head_diameter, h = M3_head_height +5, $fn = 50);
              }

        // Rada sroubu zadni sklonena hrana
        translate([10*26+2, pylon_holder_side_mount_height, 0])
        rotate([0,0,-48])
		for(x = [0:10:10*5])
	        translate([x, 0, -0.1])
            {
	            translate([0,0,-10+thickness-M3_nut_height+1.2-0.1])
                    cylinder(d = M3_screw_diameter+0.1, h = 10, $fn = 50);
                  translate([0,0,thickness-M3_nut_height+1.2])
                    cylinder(d = M3_head_diameter, h = M3_head_height +5, $fn = 50);
            }

    }
}

888_2006();
