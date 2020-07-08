//@set_slicing_config(../../slicing/blade_center_parts.ini)


//@set_modificator(888_4001_modif_ab)
//@set_slicing_config(../../slicing/blade_infill_modif.ini, 888_4001_modif_ab)

include <../../parameters.scad>
use <../888_4001.scad>

translate([-rotor_blade_depth/2, 3.5, 0])
  888_4001_print(2);

translate([rotor_blade_depth/2, -3.5, 0]) rotate([0, 0, 180])
  888_4001_print(2);

translate([rotor_blade_depth/2, -12, 0])
  rotate([0, 180, 0])
    888_4001_print(1);

translate([-rotor_blade_depth/2, 12, 0]) rotate([0, 0, 180])
  rotate([0, 180, 0])
    888_4001_print(1);




module 888_4001_modif_ab(){
  translate([-rotor_blade_depth/2, 3.5, 0])
    888_4001_print_modificator(2);

  translate([rotor_blade_depth/2, -3.5, 0]) rotate([0, 0, 180])
    888_4001_print_modificator(2);

  translate([rotor_blade_depth/2, -12, rotor_blade_length/4])
  rotate([0, 180, 0])
      888_4001_print_modificator(1);

  translate([-rotor_blade_depth/2, 12, rotor_blade_length/4]) rotate([0, 0, 180])
  rotate([0, 180, 0])
      888_4001_print_modificator(1);


}

//%888_4001_modif_ab();
