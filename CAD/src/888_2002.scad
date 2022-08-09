include <../parameters.scad>

$fn = 90;

zmenseni = 1.5;

cylinder_r2 = 0;
suspension_thickness = 0.41*6; // k cemu to je?
suspension_holder_flange_height = 25;
suspension_holder_thickness = 0.41*15;
suspension_camber = -2; // úhel zakončení, délka konstrukce
suspension_join_length = 22;
suspension_join_screw_distance = 20; // zvetsit na 20 nebo více po vyřešění: https://github.com/ThunderFly-aerospace/TF-G2/issues/86
suspension_bow_diameter = 300;      //cylinder_r1
suspension_bow_diameter_1 = 300 - 2*zmenseni;

wheel_mount_thickness = 13;

angle = 63;
sin_angle = sin(angle);
cylinder_h = sqrt(((sin_angle^2)*(suspension_bow_diameter^2))/(4*((1-(sin_angle^2)))));


cylinder_h_1 = sqrt(((sin_angle^2)*(suspension_bow_diameter^2))/(4*((1-(sin_angle^2))))) - zmenseni;

join_height = 17;
join_height_1 = join_height - zmenseni;

presah = 5; //prodloužení kvůli přesahu ze zmenšení úhlu

module mirror_copy(v=[1,0,0])
{
    children();
    mirror(v) children();
}

module 888_2002(){
    //spodní ořez
    difference(){
    union(){
    //obal
    difference(){
        union(){
            cylinder (cylinder_h, suspension_bow_diameter/2,0);
            translate([0,0,-cylinder_h])
                cylinder(cylinder_h,0, suspension_bow_diameter/2);
        }
        translate([join_height/2,0, -join_height])
            cylinder(cylinder_h, suspension_bow_diameter/2,0);
        translate([join_height/2,0,+ join_height - cylinder_h])
            cylinder(cylinder_h,0,suspension_bow_diameter/2);

        //odstranění zbylého kužele
        translate([0,-suspension_bow_diameter/2,-suspension_bow_diameter])
            cube([suspension_bow_diameter,suspension_bow_diameter,2*suspension_bow_diameter]);
        translate([-suspension_bow_diameter/2,0,-suspension_bow_diameter])
            cube([suspension_bow_diameter,suspension_bow_diameter,2*suspension_bow_diameter]);
        translate([-suspension_bow_diameter/2,-suspension_bow_diameter/2,join_height - 0.1])
            cube([suspension_bow_diameter,suspension_bow_diameter,2*suspension_bow_diameter]);
        translate([-suspension_bow_diameter/2,-suspension_bow_diameter/2,-2*suspension_bow_diameter - join_height + 0.1])
            cube([suspension_bow_diameter,suspension_bow_diameter,2*suspension_bow_diameter]);

        //dutý
        difference(){
            union(){
                    cylinder (cylinder_h_1, suspension_bow_diameter_1/2,0);
                translate([0,0,-cylinder_h_1 + 0.001])
                    cylinder(cylinder_h_1,0, suspension_bow_diameter_1/2);
            }

            translate([join_height_1/2 - zmenseni,-zmenseni, -join_height_1])
                cylinder(cylinder_h_1, suspension_bow_diameter_1/2,0);

            translate([join_height_1/2 - zmenseni,-zmenseni,+ join_height_1 - cylinder_h_1])
                cylinder(cylinder_h_1,0,suspension_bow_diameter_1/2);
        }

        //výřezy
        cuts = 25;
        rot = [for (a = -0, b = join_height/2;b > 0; a = a + b - b/3,
                    b = b - join_height/4/(cuts*0.7)) a];
        echo(rot);
        mirror_copy([0, 0, 1])
        for (i = [1:cuts]) {
            m = i*(join_height/4/(cuts*2));
            rotate([0, 0, -90 + rot[i]]) {
                if (i % 2 == 0) {
                    translate([0, 0, (join_height/2 - 1.5*m)/2 + 0])
                        rotate([90,30+1.8,0])
                            cylinder(h = suspension_bow_diameter, r = join_height/3 - m - 1, $fn=3);
                }
                else {
                    translate([0, 0, (join_height/2 - 4*m - 1)/2 + (join_height/2 * sqrt(3))/4 + 0])
                        rotate([90,-30-1.8,0])
                            cylinder(h = suspension_bow_diameter, r = join_height/3 - m - 1, $fn=3);
                }
            }
        }
    }

    //koncovky - hranatá
    rotate ([0,0,90])
        difference(){
          hull(){  // smooth connection to the leg
            translate([suspension_holder_thickness/2, suspension_bow_diameter/2 - join_height/2, 0])
                cube([suspension_holder_thickness/2, join_height + 2*presah, 2*join_height], center=true);
                intersection(){
                    difference(){
                        union(){
                            cylinder (cylinder_h_1, suspension_bow_diameter_1/2,0);
                            translate([0,0,-cylinder_h_1 + 0.001])
                                cylinder(cylinder_h_1,0, suspension_bow_diameter_1/2);
                        }

                        translate([join_height_1/2 - zmenseni,-zmenseni, -join_height_1])
                            cylinder(cylinder_h_1, suspension_bow_diameter_1/2,0);

                        translate([join_height_1/2 - zmenseni,-zmenseni,+ join_height_1 - cylinder_h_1])
                            cylinder(cylinder_h_1,0,suspension_bow_diameter_1/2);
                    }
                    translate([-suspension_holder_thickness/3, suspension_bow_diameter/2 - join_height/2, 0])
                        cube([suspension_holder_thickness, join_height + 2*presah, 1.5*join_height], center=true);
                }
            }


            mirror_copy([0, 0, 1])
            translate([-0.1, suspension_bow_diameter/2 + presah/2 - M3_screw_diameter/2, suspension_join_screw_distance/2])
            {
                rotate([0, 90, 0])
                    cylinder(d= M3_screw_diameter, h = 30);
                translate([global_clearance, 0, 0])
                    rotate([0, 90, 180])
                        cylinder(d= M3_head_diameter_ISO7380, h = 10);
            }

            mirror_copy([0, 0, 1])
            translate([-0.1, suspension_bow_diameter/2 - join_height - M3_screw_diameter/2, suspension_join_screw_distance/2])
            {
                rotate([0, 90, 0])
                    cylinder(d= M3_screw_diameter, h = 30);
                translate([global_clearance, 0, 0])
                    rotate([0, 90, 180])
                        cylinder(d= M3_head_diameter_ISO7380, h = 10);
            }
        }
    // koncovky - oblá
    rotate([180, 0, -90])
            translate([suspension_bow_diameter/2,-5, 0])
            difference(){
                hull(){
                    translate([-suspension_thickness/2, 5.5, 0])
                        cube([suspension_thickness, 1, join_height + 1], center=true);
                    translate([(-wheel_mount_thickness)/2, 0, 0])
                        cube([wheel_mount_thickness, 6, join_height + 1], center=true);
                    rotate([0, -90, 0])
                        cylinder(d = M3_screw_diameter+8, h = wheel_mount_thickness);
                }
                rotate([0, 90, 0])
                    cylinder(d = M3_screw_diameter, h = suspension_bow_diameter, center = true);
               rotate([0, 90, 0])
               translate([0, 0, -suspension_bow_diameter-wheel_mount_thickness + 3])
                cylinder(d = M3_nut_diameter, h = suspension_bow_diameter, $fn = 6, center = false);
            }
    }
    mirror_copy([0, 0, 1])
        translate([0, 0, -join_height + 0.5])
            rotate([-1.8, -1.8, 0])
                cube([2*suspension_bow_diameter, 2*suspension_bow_diameter, 10], center = true);
    }
}

difference(){
  888_2002();
//  translate([0,100,-30]) rotate([0,0,180]) cube(150);
}
