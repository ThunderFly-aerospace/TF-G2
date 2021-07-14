
// Tunel pro pylon
include <../parameters.scad>



module 888_1008() {
    translate([-40*0.3, 0, 0])
            hollow_airfoil(naca = 0035, L = 40, N = 50, h= 140, open = true, wall_thickness=0.4);
}


888_1008();
