//@set_slicing_config(../../slicing/blade.ini)

//@set_modificator(888_4001_modif_cd)
//@set_slicing_config(../../slicing/blade_infill_modif.ini, 888_4001_modif_cd)

//drzak zadniho kolecka
include <../../parameters.scad>
use <../888_4001.scad>

print_offset=10;

rotate([0,0,90])
{
    translate([-rotor_blade_depth/2, 2.5*print_offset, 0])
      888_4001_print(4, draft = false);

    translate([-rotor_blade_depth/2, -2.5*print_offset, 0]) 
      888_4001_print(4, draft = false);

    translate([-rotor_blade_depth/2, 1.5*print_offset, 0])
      888_4001_print(3, draft = false);

    translate([-rotor_blade_depth/2, -1.5*print_offset, 0]) 
      888_4001_print(3, draft = false);

    translate([-rotor_blade_depth/2, 0.5*print_offset, 0])
      888_4001_print(2, draft = false);

    translate([-rotor_blade_depth/2, -0.5*print_offset, 0]) 
      888_4001_print(2, draft = false);
}



module 888_4001_modif_cd(){
rotate([0,0,90])
{    
  translate([-rotor_blade_depth/2, 2.5*print_offset, 0])
    888_4001_print_modificator(4);

  translate([-rotor_blade_depth/2, -2.5*print_offset, 0])
    888_4001_print_modificator(4);

  translate([-rotor_blade_depth/2, 1.5*print_offset, 0])
    888_4001_print_modificator(3);

  translate([-rotor_blade_depth/2, -1.5*print_offset, 0])
    888_4001_print_modificator(3);

  translate([-rotor_blade_depth/2, 0.5*print_offset, 0])
    888_4001_print_modificator(2);

  translate([-rotor_blade_depth/2, -0.5*print_offset, 0])
    888_4001_print_modificator(2);
}

}

//888_4001_modif_cd();
