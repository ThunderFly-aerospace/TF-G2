include <../../../parameters.scad>
use <../../888_4009.scad>
use <../../888_4010.scad>

flap=-10;

//intersection()
union()
{
888_4009();

    union()
    {
    translate([free_flap_ax_offset,0,(free_flap_bearings_outer_diameter+free_flap_bearing_add)/2])
        rotate([0,0,free_flap_delta_angle])
            rotate([0,-flap,0])
                rotate([0,0,-free_flap_delta_angle])
                    888_4010(); 
    
    rotate([0,0,180])
    translate([free_flap_ax_offset,0,(free_flap_bearings_outer_diameter+free_flap_bearing_add)/2])
        rotate([0,0,free_flap_delta_angle])
            rotate([0,-flap,0])
                rotate([0,0,-free_flap_delta_angle])
                888_4010();
    }
    
}
    
/**/