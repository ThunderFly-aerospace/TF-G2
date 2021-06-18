// srouby do bocnice


include <../../../parameters.scad>
include <../../lib/NopSCAD/lib.scad>

for(m = [1, 0]) mirror([0, m, 0])
for (p = [
		[0, [2, 5, 9, 10, 20, 21, 29]],
		[2.5, [3, 5, 9, 10, 14]],
		[4.5, [14, 18, 24]]
	])
  
  for(x = p[1])
  translate([base_patern*x, base_width/2 + 1.5 , p[0]*base_patern ])
    rotate([-90, 0, 0]) {
      screw(M3_dome_screw, 8);
      translate([0, 0, -5]) nut(M3_nut);
    }
