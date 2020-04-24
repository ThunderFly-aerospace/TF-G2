//@set_slicing_config(../../slicing/tail.ini)

//@set_modificator(888_3004_modif_a)
//@set_slicing_config(../../slicing/default.ini, 888_3004_modif_a)

//@set_modificator(888_3004_modif_b)
//@set_slicing_config(../../slicing/tail_center.ini, 888_3004_modif_b)

//dil pro pripevneni tazneho motoru
include <../../parameters.scad>
use <../888_3004.scad>

888_3004();


module 888_3004_modif_a() 888_3004_modif_hand();
module 888_3004_modif_b() 888_3004_modif_pipe();
