//// ThunderFly - Rotor Head - Vicka na TFASPDIMU

/// Main parameters

include <../parameters.scad>
$fn = 100;



module 888_1013(draft = true){

  difference(){
    cube([30, airspeed_width, 3]);

  }

}

888_1013(draft=true);
