include <../parameters.scad>


module 888_4011(thickness=2)
{
    h=thickness;
    l=55;
    w=19;

    difference()
    {
      union(){
        hull()
        {
            cylinder(h=h,d=30, $fn=120, center =true);
            cube([l,w,h], center =true);
        }
        translate([0,0,-0.6])
            cylinder(d=5,h=thickness,center=true,$fn=30);
      }


        //šroubky
        rotate([0,0,free_flap_delta_angle])
            for(i=[-1,1])
                translate([0,i*free_flap_central_part_screw_distance,0])
                    cylinder(d=M3_screw_diameter,h=20,center=true,$fn=30);

        //osa
        cylinder(d=M3_screw_diameter,h=20,center=true,$fn=30);

        //dražky
        for(i=[-1,1])
            translate([i*15,0,0])
                cube([15,1,20],center=true);

        rotate([0,0,40]){
            translate([-3.5, 3, 0.4])
              linear_extrude(1)
                text(str(week), size = 5);

            translate([-2, -8, 0.4])
              linear_extrude(1)
                text(str(thickness), size = 5);
        }
    }
}

888_4011();
