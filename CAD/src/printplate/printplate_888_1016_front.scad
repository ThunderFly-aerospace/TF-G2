//@set_slicing_config(../../slicing/kryt.ini)

//Zadni dil krytu
include <../../parameters.scad>


rotate([0, 90, 0])
    import("../../stl/cover_part_front.stl" );
