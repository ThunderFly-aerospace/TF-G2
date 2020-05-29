//// ThunderFly Auto-G2 3D printable Rotor blade

/// Rotor blade

//@set_slicing_config(../slicing/blades/blade.ini)

//@set_modificator(888_4001_modificator)
//@set_slicing_config(../slicing/blade_infill_modif.ini, 888_4001_modificator)

draft = true;


include <../parameters.scad>
use <lib/stdlib/naca4.scad>
rotor_blade_endtip_diameter = 10;
rotor_blade_depth_naca_resolution = draft ? 50 : 100;

module base_airfoil(h = rotor_blade_length){
    airfoil(naca = rotor_blade_naca, L = rotor_blade_depth, N = rotor_blade_depth_naca_resolution, h = h - blade_transition_length - blade_mount_length, open = false);
}

module blade_shell(thickness = blade_shell_thickness){
    hollow_airfoil(naca = rotor_blade_naca, L = rotor_blade_depth, N = rotor_blade_depth_naca_resolution, h = rotor_blade_length - blade_transition_length - blade_mount_length, open = false, wall_thickness = thickness);
}


module blade_infill(){
    difference(){
        intersection(){
            union(){
                    for (i=[0 : blade_infill_distance : rotor_blade_length + rotor_blade_depth]) {
                        translate([rotor_blade_depth/4, -10, i])
                            rotate([0, 50, 0])
                                cube([rotor_blade_depth*0.70, 20, blade_shell_thickness_inner]);

                    //translate([rotor_blade_depth/4, -10, i])
                    //  rotate([0, 90+30, 0])
                    //        cube([rotor_blade_depth, 20, blade_shell_thickness_inner]);

                    //    translate([rotor_blade_depth/4, -10, i + blade_infill_distance/2])
                    //        rotate([0, 90+30, 0])
                    //            cube([rotor_blade_depth, 20, blade_shell_thickness_inner]);
                    }

            }
            base_airfoil();
        }
        blade_shell(thickness = 0.8);


        difference(){
            cube([100, 30, 30], center = true);
            translate([0, rotor_blade_endtip_diameter/2-4, rotor_balde_tip_cutoff])
                rotate([10, 0, 0])
                    rotate([0, 90, 0])
                        scale([1.65, 1, 1])
                            cylinder(d = rotor_blade_endtip_diameter, h = rotor_blade_depth, $fn = 100);
        }
    }
}


module blade_mount(){
    translate([rotor_blade_depth/4, 0, rotor_blade_length - blade_mount_length])
        difference(){
            union(){
                translate([-blade_mount_width/2, -blade_mount_thickness/2 + blade_rod2_position[1], -1])
                    cube([blade_mount_width, blade_mount_thickness, blade_mount_length + 1]);

                hull(){
                    translate([-rotor_blade_depth/4, 0, - blade_transition_length])
                        linear_extrude(height = 0.1)
                            polygon(points = airfoil_data(naca=rotor_blade_naca, L = rotor_blade_depth, N = rotor_blade_depth_naca_resolution));

                    translate([-blade_mount_width/2, -blade_mount_thickness/2 + blade_rod2_position[1], -1])
                        cube([blade_mount_width, blade_mount_thickness, blade_mount_length/2]);
                }
            }

            translate([0, -blade_mount_thickness/2 + 0.3, blade_mount_length -blade_mount_screw_offset - blade_mount_screw_distance/2 + 3])
              rotate([90, 0, 0])
                linear_extrude(10)
                  text(str(rotor_blade_naca), size=4, font="Liberation Sans", halign="center", valign="center");

            translate([0, 20, blade_mount_length -blade_mount_screw_offset])
                rotate([90, 0, 0])
                    cylinder(d = blade_mount_screw, h=40, $fn = 50);
            translate([0, 20, blade_mount_length -blade_mount_screw_offset -blade_mount_screw_distance])
                rotate([90, 0, 0])
                    cylinder(d = blade_mount_screw, h=40, $fn = 50);

        }

        /* hull(){
            translate([0, 0, rotor_blade_length - blade_transition_length - blade_mount_length])
                linear_extrude(height = 0.1)
                    polygon(points = airfoil_data(naca=rotor_blade_naca, L = rotor_blade_depth, N = rotor_blade_depth_naca_resolution));

            #translate([rotor_blade_depth/4 -blade_mount_width/2, -blade_mount_thickness/2, rotor_blade_length - blade_transition_length - blade_mount_length/4])
                cube([blade_mount_width, blade_mount_thickness, blade_mount_length/4]);
        } */
}


module 888_4001(){
    difference(){
        union(){
            base_airfoil();
            blade_mount();
        }

        blade_infill();

        // diry na vyztuhu
        if (rotor_blade_rod) translate([0, 0, rod_from_end]){
            translate(blade_rod2_position - [0, 0, 0.5])
                cylinder(d = blade_rod2_diameter, h = rotor_blade_length + 1, $fn = 50);
            translate(blade_rod3_position - [0, 0, 0.5])
                cylinder(d = blade_rod3_diameter, h = rotor_blade_length + 1, $fn = 50);
        }

        if (rotor_blade_rod) translate([0, 0, rod_from_end]){
            for(z = [10:30:rotor_blade_length-20])
                translate(blade_rod2_position - [0, 0, -z])
                    rotate([90, 0, 0])
                        cylinder(d = 2, h = 5, $fn = 50);
            // for(z = [10:30:rotor_blade_length])
            //     translate(blade_rod3_position - [0, -8, -z])
            //         rotate([90, 0, 0])
            //             cylinder(d = 2, h = 8, $fn = 50);
            for(z = [10:30:rotor_blade_length-30])
                translate(blade_rod3_position - [0, 0, -z-15])
                    rotate([90, 0, 0])
                        cylinder(d = 2, h = 5, $fn = 50);
            // for(z = [10:30:rotor_blade_length])
            //     translate(blade_rod2_position - [0, -8, -z-15])
            //         rotate([90, 0, 0])
            //             cylinder(d = 2, h = 8, $fn = 50);

        }


        rotor_blade_endtip_diameter = 20;

        difference(){
            cube([100, 30, 30], center = true);
            translate([0, rotor_blade_endtip_diameter/2-4, rotor_balde_tip_cutoff])
                rotate([10, 0, 0])
                    rotate([0, 90, 0])
                        scale([1.7, 1, 1])
                            cylinder(d = rotor_blade_endtip_diameter, h = rotor_blade_depth, $fn = 100);
        }

        translate([rotor_blade_depth-2, -10, -1])
            cube([20, 20, rotor_blade_length+2]);
    }

}

module 888_4001_modificator(){

    translate([-1, -3, 0])
        cube([rotor_blade_depth/4+1, 7, rotor_blade_length]);

    hull(){
        translate([0, -3, rotor_blade_length-2])
            cube([rotor_blade_depth/2, 7, 2]);

        translate([-1, -3, rotor_blade_length-2 - 60])
            cube([rotor_blade_depth/4, 7, 2]);
    }
}


module 888_4001_end_modificator(){

    translate([0, -5, 0])
        cube([rotor_blade_depth, 10, rotor_balde_tip_cutoff]);

    translate([0, -5, rotor_blade_length-2])
        cube([rotor_blade_depth/2, 10, 2]);
}

//%888_4001_modificator();
//%888_4001_end_modificator();


module 888_4001_print(part = 1){
    height = rotor_blade_length;
    part_height = height/rotor_blade_parts_count;
    bottom  = part_height*(part-1);

    translate([0, 0, -bottom])
    intersection(){


        888_4001();


        translate([0, -25, bottom])
            cube([rotor_blade_depth, 50, part_height]);
        }
}
module 888_4001_print_modificator(part = 1){
    height = rotor_blade_length;
    part_height = height/rotor_blade_parts_count;
    bottom  = part_height*(part-1);

    translate([0, 0, -bottom])
            888_4001_modificator();

}


module 888_4001_end_print_modificator(part = 1){
    height = rotor_blade_length;
    part_height = height/rotor_blade_parts_count;
    bottom  = part_height*(part-1);

    translate([0, 0, -bottom])
            888_4001_end_modificator();

}

888_4001();
