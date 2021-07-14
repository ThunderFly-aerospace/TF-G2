
// Tunel pro pylon
include <../parameters.scad>



module 888_1008() {
    translate([-40*0.3, 0, 0])
      airfoil(naca = 0035, L = 40, N = 50, h= 140, open = true);
}

888_1008();
