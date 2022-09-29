//@set_slicing_config(../../slicing/blade.ini)

//@set_modificator(888_4001_edge)
//@set_slicing_config(../../slicing/blade_infill_modif.ini, 888_4001_edge)

//@set_modificator(888_4001_end)
//@set_slicing_config(../../slicing/blade_infill_modif.ini, 888_4001_end)   

//drzak zadniho kolecka 
include <../../parameters.scad> 
use <../888_4001.scad>

translate([-rotor_blade_depth/4, 0, 0]) 
  888_4001();


module 888_4001_edge(){
translate([-rotor_blade_depth/4, 0, 0])
  888_4001_print_modificator();

}

module 888_4001_end(){

translate([-rotor_blade_depth/4, 0, 0])
      888_4001_end_print_modificator(1);
}

%888_4001_edge(); 
%888_4001_end();

echo("Vyvazeni:");
echo(blade_rod1_position  + [-rotor_blade_depth/4, 0, 0]);
echo(blade_rod2_position  + [-rotor_blade_depth/4, 0, 0]);
echo(blade_rod3_position  + [-rotor_blade_depth/4, 0, 0]);
