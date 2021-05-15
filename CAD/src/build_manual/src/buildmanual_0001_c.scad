include <../../../parameters.scad>
use <../../888_1003.scad>

mezera = 00;

mirror([0, 1, 0]) rotate([90, 0, 0]) translate([-10, 0, 70/2+mezera]) 888_1003();

rotate([90, 0, 0]) translate([-10, 0, 70/2 + mezera]) 888_1003();
