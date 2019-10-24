
include <../parameters.scad>

use <888_1001.scad>
use <888_1002.scad>
use <888_1003.scad>
use <888_1005.scad>



translate([0, 10.16*-3, 0]){
	translate([0, base_length*0.5, 0])
		888_1001();
	translate([0, base_length*1.5+10.16, 0])
		888_1001();
}

translate([0, 10.16*13, 0]){
	mirror([1, 0 ,0]) 888_1003();
	888_1003();
}

888_1002();


//888_1005();