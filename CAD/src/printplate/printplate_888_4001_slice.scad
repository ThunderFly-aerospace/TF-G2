//@set_slicing_config(../../slicing/blade.ini)

//@set_modificator(888_4001_edge)
//@set_slicing_config(../../slicing/blade_infill_modif.ini, 888_4001_edge)

//drzak zadniho kolecka
include <../../parameters.scad>
use <../888_4001.scad>


module vyrez(){

  translate([0, 0, 100])
    cube([80, 80, 50], center = true);
}


translate([-rotor_blade_depth/4, 0, 0])
intersection(){
  888_4001();
  vyrez();
}


module 888_4001_edge(){
translate([-rotor_blade_depth/4, 0, 0])
intersection(){
  888_4001_print_modificator();
  vyrez();
}

}

%888_4001_edge();
