
// Tunel pro pylon
include <../parameters.scad>



module 888_1008() {
    translate([-40*0.3, 0, 0])
      airfoil(naca = pylon_case_naca_profile, L = 40, N = 100, h= 140, open = true);
}

888_1008();
