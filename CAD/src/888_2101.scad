include <../parameters.scad>


module 888_2101(draft=true) // Skid holder
{
    tube_l=mount_tube_out_d*3;
    tube_screw_l=tube_l/2;
    sm_t_angle=70;
    joint_d=mount_tube_out_d*1.5;
    joint_h=joint_d;
    tube_hole=3*joint_d;
    sm_screw=3.1;
    sm_maticka=7;
    big_screw=3.1;



    circle_fn=draft?20:100;

    difference()
    {
        union()
        {

            translate([0,0,tube_l/2])
                cylinder(d=mount_tube_in_d,h=tube_l, center=true,$fn=circle_fn);

            difference()
            {
                translate([0,0,-joint_h])
                    cylinder(d=joint_d,h=joint_h+tube_l,$fn=circle_fn);

                translate([0,0,tube_l/2])
                    cylinder(d=mount_tube_out_d,h=tube_l+0.01, center=true,$fn=circle_fn);
            }
        }
         //tenká trubka nohy
         translate([0,0,-joint_h/2])
          rotate([sm_t_angle,0,0])
                  cylinder(d=skid_tube_d,h=tube_hole, center=true,$fn=circle_fn);

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

888_2101();

translate([0,50,0])
888_2101_drill_helper();

module 888_2101_drill_helper()
{
    tube_l=mount_tube_out_d*3;
    d=mount_tube_out_d;
    screw_p=tube_l/2;
    screw_d=3.1;

    add=2;
    l=screw_p+3*add;

    difference()
    {
        translate([0,0,l/2-add])
            cube([d+2*add,d+2*add,l],center=true);
        cylinder(d=d,h=tube_l,$fn=120);
        translate([0,0,screw_p])
            rotate([90,0,0])
                cylinder(d=screw_d,h=2*d,$fn=120,center=true);
    }
}
