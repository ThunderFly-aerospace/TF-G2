include <../parameters.scad>


module 888_2101(draft=true) // Skid holder
{
    tube_l=mount_tube_out_d*3;
    tube_screw_l=tube_l/2;
    sm_t_angle=70;
    joint_d=mount_tube_out_d*1.5;
    joint_h=joint_d;
    tube_hole=3*joint_d;
    sm_screw=plastic_screw_diameter;
    sm_maticka=7;
    big_screw=plastic_screw_trought_diameter;



    circle_fn=draft?20:100;

    difference()
    {
        union()
        {

            translate([0,0,0])
                cylinder(d=mount_tube_in_d,h=tube_l/5, center=false,$fn=circle_fn);

            difference()
            {
                translate([(-1.5*joint_d)/3.5,0,-joint_h])
                    airfoil(naca = 0055, L = 1.4*joint_d, N = 100, h= joint_h+tube_l, open = true);
                  //  cylinder(d=joint_d,h=joint_h+tube_l,$fn=circle_fn);

                translate([0,0,tube_l/2])
                    cylinder(d=mount_tube_out_d,h=tube_l+0.01, center=true,$fn=circle_fn);
            }
        }

          //tenká trubka nohy
          translate([0,0,-joint_h/2])
              rotate([sm_t_angle,0,0])
                  cylinder(d=skid_tube_d,h=tube_hole, center=true,$fn=circle_fn);

          // prorez tenké trubky
          translate([joint_d+skid_tube_d/2,0,-joint_h/2 ])
              rotate([90+sm_t_angle,0,0])
                  cube([2*joint_d,joint_d,4*global_clearance], center = true);

          //šroubek tenké trubky
          translate([skid_tube_d,0,-joint_h/2])
              rotate([0,0,0])
                      cylinder(d=sm_screw,h=joint_h, center=true,$fn=circle_fn);

          translate([skid_tube_d,0,-joint_h])
              rotate([0,0,0])
                      cylinder(d=big_screw,h=joint_h/2, center=false,$fn=circle_fn);



          //prořez pro tlustou trubku
          translate([mount_tube_in_d/2,-2*global_clearance,0])
              cube([2*joint_d,4*global_clearance,joint_h+tube_l]);


          //šroubek tulsté trubky
          translate([mount_tube_out_d/2 + big_screw,0,tube_screw_l])
              rotate([90,0,0])
                      cylinder(d=sm_screw,h=tube_hole, center=true,$fn=circle_fn);

          translate([mount_tube_out_d/2 + big_screw,0,tube_screw_l])
              rotate([-90,0,0])
                      cylinder(d=big_screw,h=tube_hole, center=false,$fn=circle_fn);


          //matičky - tenká trubka
         translate([skid_tube_d,0,-joint_h])
              rotate([0,0,0])
                      cylinder(d=M3_head_diameter,h=4, center=true, $fn = circle_fn);

         //matičky tlustá trubka
         translate([mount_tube_out_d/2 + big_screw,joint_d/3,tube_screw_l])
              rotate([90,0,0])
                   translate([0,0,0])
                      cylinder(d=M3_head_diameter,h=4, center=true, $fn = circle_fn);
    }
}

888_2101();
