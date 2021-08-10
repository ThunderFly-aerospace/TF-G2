
include<../parameters.scad>

rear_wheel_holder_thickness = 4;
rear_wheel_holder_excentric = rear_wheel_holder_thickness/2+2;

module 888_3007(){
difference(){
    union(){
        hull(){
            translate([5, 0, 0]) cylinder(d = rear_wheel_holder_thickness, h = 10+10+5-0.5, $fn=$preview?10:30);
            translate([0, rear_wheel_holder_excentric, 0]) cylinder(d = rear_wheel_holder_thickness+1, h = 10+10+5-0.5, $fn=$preview?10:30);
            translate([1, -rear_wheel_holder_thickness/2, 0]) cube([15-1, rear_wheel_holder_thickness, 25-0.5]);
        }
        hull(){
            translate([15+20, 0, -10]) rotate([90, 0, 0]) cylinder(d = 9, h = rear_wheel_holder_thickness, $fn=$preview?10:30, center = true);
            translate([-2+15, -rear_wheel_holder_thickness/2, 0]) cube([2, rear_wheel_holder_thickness, 25-0.5]);
        }
    }
    translate([0, rear_wheel_holder_excentric, 0]) translate([0, 0, 1]) cylinder(d = 2.5, h=50, $fn = $preview?7:20);
    translate([0, 0, 5+5]) cube([20, 20, 11], center = true);
    translate([15+20, 0, -10]) rotate([90, 0, 0]) cylinder(d = M3_screw_diameter, h = 9, $fn=$preview?10:30, center = true);
    translate([15+20, 9, -10]) rotate([90, 0, 0]) cylinder(d = M3_nut_diameter, h = 8, $fn=6);


}
    translate([0, 0, 10+10+5+0.5-2-1]) difference(){
        hull(){
            translate([10, 0, 1]) cube([10, 2, 2], center = true);
            translate([0, 20 + rear_wheel_holder_excentric, 0]) cylinder(d = 7, h=2, $fn=40);
        }
        translate([0, 20 + rear_wheel_holder_excentric, 0]) cylinder(d = 2.6, h=2, $fn=40);
    }
}


888_3007();
