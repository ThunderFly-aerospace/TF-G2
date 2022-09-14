//@set_slicing_config(../../slicing/blade.ini)


//@set_modificator(888_4001_modif_a)
//@set_slicing_config(../../slicing/blade_infill_modif.ini, 888_4001_modif_a)

//@set_modificator(888_4001_modif_b)
//@set_slicing_config(../../slicing/blade_infill_modif.ini, 888_4001_modif_b)


include <../../parameters.scad>
use <../888_4001.scad>



translate([8, 5, 0])
  rotate([0, 180, -90])
    888_4001_print(1, draft = false);

translate([-8, 5, 0])
  rotate([0, 180, -90])
    888_4001_print(1, draft = false);




module 888_4001_modif_a(){

  translate([8, 5, 0])
  rotate([0, 180, -90])
      888_4001_print_modificator(1);

  translate([-8, 5, 0])
  rotate([0, 180, -90])
      888_4001_print_modificator(1);


}

module 888_4001_modif_b(){

  translate([8, 5, 0])
  rotate([0, 180, -90])
      888_4001_end_print_modificator(1);

  translate([-8, 5, 0])
  rotate([0, 180, -90])
      888_4001_end_print_modificator(1);


}


%888_4001_modif_a();
%888_4001_modif_b();
