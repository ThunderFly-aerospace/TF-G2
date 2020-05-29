//@set_slicing_config(../../slicing/blade.ini)

//@set_modificator(888_4001_edge)
//@set_slicing_config(../../slicing/blade_infill_modif.ini, 888_4001_edge)

//drzak zadniho kolecka
include <../../parameters.scad>
use <../888_4001.scad>

translate([-rotor_blade_depth/4, 0, 0])
  888_4001();


module 888_4001_edge(){
translate([-rotor_blade_depth/4, 0, 0])
  888_4001_print_modificator();

}

%888_4001_edge();

echo("Vyvazeni:");
echo(blade_rod2_position  + [-rotor_blade_depth/4, 0, 0]);
echo(blade_rod3_position  + [-rotor_blade_depth/4, 0, 0]);
