//@set_slicing_config(../../slicing/blade.ini)

//@set_modificator(888_4001_modif_cd)
//@set_slicing_config(../../slicing/blade_infill_modif.ini, 888_4001_modif_cd)

//drzak zadniho kolecka
include <../../parameters.scad>
use <../888_4001.scad>

draft = false;

translate([-rotor_blade_depth/2, 28, 0])
  888_4001_print(4);

translate([rotor_blade_depth/2, -28, 0]) rotate([0, 0, 180])
  888_4001_print(4);

translate([-rotor_blade_depth/2, -12, 0])
  888_4001_print(3);

translate([rotor_blade_depth/2, 12, 0]) rotate([0, 0, 180])
  888_4001_print(3);

translate([-rotor_blade_depth/2, 3.5, 0])
  888_4001_print(2);

translate([rotor_blade_depth/2, -3.5, 0]) rotate([0, 0, 180])
  888_4001_print(2);

/*  chybi modifikatory pro plnou spicku na konci wingletu
translate([rotor_blade_depth/2, -20, rotor_blade_part_list[1]])
  rotate([0, 180, 0])
    888_4001_print(1);

translate([-rotor_blade_depth/2, 20, rotor_blade_length/4]) rotate([0, 0, 180])
  rotate([0, 180, 0])
    888_4001_print(1);
*/



module 888_4001_modif_cd(){
  translate([-rotor_blade_depth/2, 28, 0])
    888_4001_print_modificator(4);

  translate([rotor_blade_depth/2, -28, 0]) rotate([0, 0, 180])
    888_4001_print_modificator(4);

  translate([-rotor_blade_depth/2, -12, 0])
    888_4001_print_modificator(3);

  translate([rotor_blade_depth/2, 12, 0]) rotate([0, 0, 180])
    888_4001_print_modificator(3);

  translate([-rotor_blade_depth/2, 3.5, 0])
    888_4001_print_modificator(2);

  translate([rotor_blade_depth/2, -3.5, 0]) rotate([0, 0, 180])
    888_4001_print_modificator(2);

  translate([rotor_blade_depth/2, -20, rotor_blade_length/4])
  rotate([0, 180, 0])
      888_4001_print_modificator(1);

  translate([-rotor_blade_depth/2, 20, rotor_blade_length/4]) rotate([0, 0, 180])
  rotate([0, 180, 0])
      888_4001_print_modificator(1);


}

%888_4001_modif_cd();
