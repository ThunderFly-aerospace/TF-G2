//// ThunderFly TF-G2 3D printable Rotor blade

/// Rotor blade

DOC_SCALING_FACTOR = 100;
DOC_HEIGHT = 50;

include <lib/stdlib/dimlines.scad>

DIM_LINE_WIDTH = .025 * DOC_SCALING_FACTOR;
DIM_SPACE = .1 * DOC_SCALING_FACTOR;



include <../parameters.scad>
use <lib/stdlib/naca4.scad>

// rotor_blade_endtip_diameter = 15;

spine_radius = (blade_rod3_position[0] - blade_rod2_position[0]) / 2; // vypocet radiusu ohybu dratu
spine_length = rotor_blade_length - rod_from_end - blade_mount_screw_offset + spine_radius + blade_rod2_diameter/2;


module base_airfoil(h = rotor_blade_length, draft = true){
    rotor_blade_depth_naca_resolution = draft ? 50 : 200;

    airfoil(naca = rotor_blade_naca, L = rotor_blade_depth, N = rotor_blade_depth_naca_resolution, h = h - blade_transition_length - blade_mount_length, open = false);
}

module blade_shell(thickness = blade_shell_thickness,draft = true){
    rotor_blade_depth_naca_resolution = draft ? 50 : 200;

    hollow_airfoil(naca = rotor_blade_naca, L = rotor_blade_depth, N = rotor_blade_depth_naca_resolution, h = rotor_blade_length - blade_transition_length - blade_mount_length, open = false, wall_thickness = thickness);
}


module blade_infill(){
    difference(){
        intersection(){
            union(){
                    for (i=[0 : blade_infill_distance*2 : rotor_blade_length + rotor_blade_depth]) {
                        translate([rotor_blade_depth/4, -10, i])
                            rotate([0, 50, 0])
                                cube([rotor_blade_depth*0.70, 20, blade_shell_thickness_inner]);

                    }

                    for (i=[blade_infill_distance : blade_infill_distance*2 : rotor_blade_length + rotor_blade_depth]) {
                        translate([rotor_blade_depth/4, -10, i])
                            rotate([0, 50, 0])
                                cube([rotor_blade_depth*0.40, 20, blade_shell_thickness_inner]);

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
        blade_shell(thickness = blade_shell_thickness);


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


module blade_mount(draft){

    rotor_blade_depth_naca_resolution = draft ? 50 : 200;

    translate([rotor_blade_depth/4, 0, rotor_blade_length - blade_mount_length])
        difference(){
            union(){
                translate([-blade_mount_width/2-3, -blade_mount_thickness/2 + blade_rod2_position[1], -1])
                    cube([blade_mount_width + 3, blade_mount_thickness, blade_mount_length + 1]);

                hull(){
                    translate([-rotor_blade_depth/4, 0, - blade_transition_length])
                        linear_extrude(height = 0.1)
                            polygon(points = airfoil_data(naca=rotor_blade_naca, L = rotor_blade_depth, N = rotor_blade_depth_naca_resolution));

                    translate([-blade_mount_width/2-3, -blade_mount_thickness/2 + blade_rod2_position[1], -1])
                        cube([blade_mount_width+3, blade_mount_thickness, blade_mount_length/2]);
                }
            }

            translate([-2, blade_mount_thickness/2 + 0.1, blade_mount_length -blade_mount_screw_offset - blade_mount_screw_distance/2])
              rotate([90, 0, 180])
                linear_extrude(10)
                  text(str(rotor_blade_naca), size=6, font="Liberation Sans", halign="center", valign="center");

            translate([0, 20, blade_mount_length -blade_mount_screw_offset])
                rotate([90, 0, 0])
                    cylinder(d = blade_mount_screw, h=40, $fn = 50);
            translate([0, 20, blade_mount_length -blade_mount_screw_offset -blade_mount_screw_distance])
                rotate([90, 0, 0])
                    cylinder(d = blade_mount_screw, h=40, $fn = 50);

        }

}


module 888_4001_doc(part = 1)
{

  translate([(blade_rod3_position[0] + blade_rod2_position[0]) / 2, blade_rod3_position[1], rotor_blade_length - blade_mount_screw_offset])
  rotate([90, 0, 0])
  rotate_extrude(angle = 180, convexity = 2)
      translate([spine_radius, 0, 0])  // posunutí o radius ohybu
          circle(d = blade_rod2_diameter,  $fn = $preview? 50 : 100);


  translate(blade_rod1_position - [0, 0, -rod_from_end])
      cylinder(d = blade_rod1_diameter, h = rotor_blade_length - rod_from_end - blade_mount_screw_offset + spine_radius + blade_rod2_diameter/2, $fn = 50);
  translate(blade_rod2_position - [0, 0, -rod_from_end])
      cylinder(d = blade_rod2_diameter, h = rotor_blade_length - rod_from_end - blade_mount_screw_offset, $fn = 50);
  translate(blade_rod3_position - [0, 0, -rod_from_end])
      cylinder(d = blade_rod3_diameter, h = rotor_blade_length - rod_from_end - blade_mount_screw_offset, $fn = 50);

// The following two lines are vertical lines that bracket the dimensions
// left arrow
translate([-2*DIM_SPACE, 0, rod_from_end + spine_length ])
  rotate([0, 0, 0])
    line(length=4*DIM_SPACE, width=DIM_LINE_WIDTH, height=DIM_HEIGHT,
        left_arrow=false, right_arrow=false);


// bottom
translate([-2*DIM_SPACE, 0, rod_from_end])
  rotate([0, 0, 0])
    line(length=4*DIM_SPACE, width=DIM_LINE_WIDTH, height=DIM_HEIGHT,
        left_arrow=false, right_arrow=false);

// length dimension
translate([-DIM_SPACE, 0, rod_from_end])
  rotate([90, -90, 0])
      dimensions(length=spine_length, line_width=DIM_LINE_WIDTH, loc=0);

// bend radius
translate([(blade_rod3_position[0] + blade_rod2_position[0])/2, 0, rod_from_end + spine_length ])
  rotate([90, -90, 0])
leader_line(angle=0, radius=0,
                angle_length=DIM_SPACE,
                horz_line_length=DIM_SPACE, direction=DIM_RIGHT,
                line_width=DIM_LINE_WIDTH,
                text=str("R ", spine_radius + blade_rod2_diameter/2));

}

module 888_4001(draft){
    difference(){
        union(){
            base_airfoil(draft = draft);
            blade_mount(draft);
        }

        blade_infill();

        // diry na vyztuhu
        if (rotor_blade_rod) translate([0, 0, rod_from_end]){
            translate(blade_rod1_position - [0, 0, 0.5])
                cylinder(d = blade_rod1_diameter, h = rotor_blade_length + 1, $fn = 50);
            translate(blade_rod2_position - [0, 0, 0.5])
                cylinder(d = blade_rod2_diameter, h = rotor_blade_length + 1, $fn = 50);
            translate(blade_rod3_position - [0, 0, 0.5])
                cylinder(d = blade_rod3_diameter, h = rotor_blade_length + 1, $fn = 50);
        }

        if (rotor_blade_rod)
          if(blade_glue_holes)
            translate([0, 0, rod_from_end]){
                for(z = [10:30:rotor_blade_length-20])
                    translate(blade_rod1_position - [0, 0, -z])
                        rotate([90, 0, 0])
                            cylinder(d = 2, h = 5, $fn = 50);

                for(z = [10:30:rotor_blade_length-20])
                    translate(blade_rod2_position - [0, 0, -z])
                        rotate([90, 0, 0])
                            cylinder(d = 2, h = 5, $fn = 50);

                for(z = [10:30:rotor_blade_length-30])
                    translate(blade_rod3_position - [0, 0, -z-15])
                        rotate([90, 0, 0])
                            cylinder(d = 2, h = 5, $fn = 50);

            }

        // kulaté zakončení výztuhy v kořenu listu

        spine_radius = (blade_rod3_position[0] - blade_rod2_position[0]) / 2; // vypocet radiusu ohybu dratu
        echo(str("Stredni radius vyztuhy je:",  spine_radius, " mm"));
        translate([(blade_rod3_position[0] + blade_rod2_position[0]) / 2, blade_rod3_position[1], rotor_blade_length -blade_mount_screw_offset])
        rotate([90, 0, 0])
        intersection(){
            rotate_extrude(angle = 180, convexity = 2)
                translate([spine_radius, 0, 0])  // posunutí o radius ohybu
                  union(){
                    circle(d = blade_rod2_diameter,  $fn = $preview? 7 : 50);
                    translate([0, -blade_rod2_diameter/2, 0])
                      square([10,blade_rod2_diameter]);
                  }
            union(){
                translate([-spine_radius,0, -blade_rod2_diameter/2])
                  cube([spine_radius * 2,40, 30]);
                translate([spine_radius,0, 0])
                  rotate([90, 0, 0])
                    cylinder(d = blade_rod2_diameter, h = 40,$fn = 50, center = true);
                translate([-spine_radius,0, 0])
                  rotate([90, 0, 0])
                    cylinder(d = blade_rod2_diameter, h = 40,$fn = 50, center = true);
            }
      }


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

    translate([0, -4, 0])
        cube([rotor_blade_depth, 8, rotor_balde_tip_cutoff/2+2]);

    translate([0, -4, rotor_blade_length-2])
        cube([rotor_blade_depth/2, 8, 2]);
}

//%888_4001_modificator();
//%888_4001_end_modificator();


module 888_4001_print(part = 1, draft){

    part_height = rotor_blade_part_list[part] - rotor_blade_part_list[part-1];
    part_bottom = rotor_blade_part_list[part-1];

      if (part == 1)
        difference(){
          translate([0, 0, -part_bottom])
            intersection(){

                888_4001(draft=draft);

                translate([0, -25, part_bottom])
                    cube([rotor_blade_depth, 50, part_height]);
            }

        translate(blade_rod1_position + [0, 0, part_height - 3*layer_thickness])
            cylinder(d2 = blade_rod1_diameter + global_clearance, d1 = blade_rod1_diameter, h = 3*layer_thickness, $fn = 50);

        translate(blade_rod2_position + [0, 0, part_height - 3*layer_thickness])
            cylinder(d2 = blade_rod2_diameter + global_clearance, d1 = blade_rod2_diameter, h = 3*layer_thickness, $fn = 50);

        translate(blade_rod3_position + [0, 0, part_height - 3*layer_thickness])
            cylinder(d2 = blade_rod3_diameter + global_clearance, d1 = blade_rod3_diameter, h = 3*layer_thickness, $fn = 50);
        }
      else
      difference(){
        translate([0, 0, -part_bottom])
          intersection(){

              888_4001(draft=draft);

              translate([0, -25, part_bottom])
                  cube([rotor_blade_depth, 50, part_height]);
          }

      translate(blade_rod1_position)
          cylinder(d1 = blade_rod1_diameter + global_clearance, d2 = blade_rod1_diameter, h = 3*layer_thickness, $fn = 50);

      translate(blade_rod2_position)
          cylinder(d1 = blade_rod2_diameter + global_clearance, d2 = blade_rod2_diameter, h = 3*layer_thickness, $fn = 50);

      translate(blade_rod3_position)
          cylinder(d1 = blade_rod3_diameter + global_clearance, d2 = blade_rod3_diameter, h = 3*layer_thickness, $fn = 50);
    }
}
module 888_4001_print_modificator(part = 1){
    part_height = rotor_blade_part_list[part] - rotor_blade_part_list[part-1];
    part_bottom = rotor_blade_part_list[part-1];

    translate([0, 0, -part_bottom])
            888_4001_modificator();

}


module 888_4001_end_print_modificator(part = 1){
    part_height = rotor_blade_part_list[part] - rotor_blade_part_list[part-1];
    part_bottom = rotor_blade_part_list[part-1];

    translate([0, 0, -part_bottom])
            888_4001_end_modificator();

}

888_4001();
//blade_mount();





echo(str("Delka vyztuhy uvnitr listu je:", (rotor_blade_length - rod_from_end), " mm"));
echo(str("Celkova delka rovne vyztuhy je:", (spine_length), " mm"));
echo(str("Celkova delka ohnute vyztuhy je:", ((spine_length-blade_mount_screw_offset)*2 + (spine_radius - blade_rod2_diameter/2) * PI ), " mm"));


echo(blade_rod1_position);
echo(blade_rod2_position);
echo(blade_rod3_position);


echo(str("Roztec vyztuh je:",  blade_rod3_position[0]-blade_rod2_position[0], " mm"));
