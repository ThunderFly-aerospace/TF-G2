//// ThunderFly - Rotor Head - Part 3

/// Main parameters

include <../parameters.scad>
$fn = 100;

space = 1; // parametr z dilu 1002, rika tloustku steny

rotor_shaft_angle = 10;

rod_size = 8; // delka hrany sloupku
Bwall = 1.6; // wall around bearing

BaseThickness = 0;
BaseBoldDiameter = M3_screw_diameter;
BaseBoldHeadDiameter = M3_nut_diameter + 0.5;
BaseBoldHeadHeight = M3_nut_height;

bearing_inner_diameter = 7;

// nastaveni delek tahel
rod_x_dist = 30;

rod_y_distance = rod_x_dist*2 - 3*2; // 3 je delka kuloveho cepu
rod_x_distance = rod_x_dist - rod_size/2 - BaseThickness - M3_screw_diameter/2 - space;

TFPROBE01_PCB_thickness = 1.8;
TFPROBE01_PCB_width = 10.2;
TFPROBE01_sensor_height = 0.9;

starter_rope_diameter=4;
starter_rope_d = 39.2;

   // Vypocet uhlu
    rotor_plane_space = 7+3; // Vzdalenost od loziska k rovine rotoru (je to predevsim vzdalenost dvou maticek)

    bearing_shaft_shift = ((rod_size/2 + BaseThickness + M3_screw_diameter/2 + space)/tan(rotor_shaft_angle)) - bearing_shaft_length - rotor_plane_space;
    echo(bearing_shaft_shift);

// Parametry pro spojení obou dílů
    PridavnaSirkaNaSpojeniDilu = 10;
    SirkaRohu = 8;      // Roh je označení pro sešikmené kvádry ve spojení obou dílů s dírami na šrouby
    VyskaRohu = 3;
    TloustkaDna = 6.6;   // V nejtlustším místě podstavy pro upevnění válce na trojúhleníkovém dílu
    PosunDerY = 3.6;
    PosunDerZ = 3.6;
    rot_screw = 10;  // Natočení děr na šrouby spojující oba díly

  // Parametry pro západky na uchycení válce
    ZapadkaX = 2.2;
    ZapadkaY = 4.4;
    ZapadkaZ = 5.2;
    PosunZapadek = 0.7; // Od středu
    PosunZ = 1.8;
    PosunNahoru = 1.4;


    ZmenseniTisk = 0.05;

    // Parametry sloupků pro upevnění disku mlýnku
        PosunZsl = 7.0;
        PosunYsl = 13.9;
        Vyska_sloupku = 4;
        Self_screw_diameter = 2;
        
      // hollows slicing bug workaround hole
        H_mill_disc = 1.6;   // Thickness of thundermills PCB
        Pin_slot_height = 1.78; // Height of the used pin slot
        
      

module bearing_house(breaking_groove = true, draft = true){
    ZmenseniTiskDno = 0.1;
    TloustkaDna = TloustkaDna+ZmenseniTiskDno;

    // Groove on the main cylinder
    Groove_height = 1;
    Inner_diameter = 11.6;

    difference(){
        union(){
            difference(){
                union(){
                       translate([-rod_size/2, 0, bearing_outer_diameter/2 + Bwall]) rotate([0, 90, 0])
                            cylinder(d = bearing_outer_diameter + Bwall*2, h = bearing_shaft_length + bearing_shaft_shift + rod_size/2, $fn = draft?16:120);
                //       translate([-rod_size/2, -bearing_outer_diameter/2 - Bwall, -BaseThickness])
                //            cube([bearing_shaft_length + bearing_shaft_shift + rod_size/2, bearing_outer_diameter + Bwall*2, bearing_outer_diameter/2 + Bwall]);

                       translate([-rod_size/2, -bearing_outer_diameter/2 - Bwall-PridavnaSirkaNaSpojeniDilu/2, -BaseThickness])
                            cube([rod_size, bearing_outer_diameter + Bwall*2 +PridavnaSirkaNaSpojeniDilu, bearing_outer_diameter + Bwall*2+3]);
                }
                // Seriznuti podstavy
                translate([-rod_size/2- bearing_outer_diameter+TloustkaDna, -bearing_outer_diameter/2 - Bwall-PridavnaSirkaNaSpojeniDilu/2, -BaseThickness])
                    cube([bearing_outer_diameter, bearing_outer_diameter + Bwall*2 +PridavnaSirkaNaSpojeniDilu, bearing_outer_diameter + Bwall*2+3]);
             }

              // Rohy (Roh je označení pro sešikmené kvádry ve spojení obou dílů s dírami na šrouby)
              difference(){
                  translate([-rod_size/2+TloustkaDna-VyskaRohu, -bearing_outer_diameter/2 - Bwall-PridavnaSirkaNaSpojeniDilu/2, -BaseThickness])
                      cube([VyskaRohu, bearing_outer_diameter + Bwall*2 +PridavnaSirkaNaSpojeniDilu, bearing_outer_diameter + Bwall*2+3]);

                  translate([-rod_size/2+TloustkaDna-VyskaRohu, -bearing_outer_diameter/2 - Bwall-PridavnaSirkaNaSpojeniDilu/2+SirkaRohu, -BaseThickness])
                      cube([VyskaRohu, bearing_outer_diameter + Bwall*2 +PridavnaSirkaNaSpojeniDilu - 2*SirkaRohu, bearing_outer_diameter + Bwall*2+3]);

                  translate([-rod_size/2+TloustkaDna-8, -bearing_outer_diameter/2 - Bwall-PridavnaSirkaNaSpojeniDilu/2+SirkaRohu, -BaseThickness])
                     rotate([0,0,-45])
                        translate([0,-5,0])
                            cube([6, 12, bearing_outer_diameter + Bwall*2+3]);

              mirror([0,1,0])
                   translate([-rod_size/2+TloustkaDna-8, -bearing_outer_diameter/2 - Bwall-PridavnaSirkaNaSpojeniDilu/2+SirkaRohu, -BaseThickness])
                   rotate([0,0,-45])
                   translate([0,-5,0])
                        cube([6, 12, bearing_outer_diameter + Bwall*2+3]);

              }
        }

     // Diry na sesroubovani obou casti
        rotate([0, rot_screw, 0]){
    translate([-rod_size/2-1, -bearing_outer_diameter/2 - Bwall-PridavnaSirkaNaSpojeniDilu/2 + PosunDerY, -BaseThickness-(bearing_outer_diameter)/2+ 5 + PosunDerZ])
        rotate([0, 90, 0])
            cylinder(d = M3_screw_diameter, h = 100, $fn = draft?16:120);

    translate([-rod_size/2-1, -(-bearing_outer_diameter/2 - Bwall-PridavnaSirkaNaSpojeniDilu/2 +PosunDerY), -BaseThickness-(bearing_outer_diameter)/2+ 5 + PosunDerZ])
        rotate([0, 90, 0])
            cylinder(d = M3_screw_diameter, h = 100, $fn = draft?16:120);

    translate([rod_size/2-1, -bearing_outer_diameter/2 - Bwall-PridavnaSirkaNaSpojeniDilu/2 + PosunDerY, -BaseThickness-(bearing_outer_diameter)/2+ 5 + PosunDerZ])
        rotate([0, 90, 0])
          rotate([0, 0, 30])
              cylinder(d = M3_head_diameter - 0.6, h = M3_head_height+1.7, $fn = draft?16:120);

    translate([rod_size/2-1, -(-bearing_outer_diameter/2 - Bwall-PridavnaSirkaNaSpojeniDilu/2 +PosunDerY), -BaseThickness-(bearing_outer_diameter)/2+ 5 + PosunDerZ])
        rotate([0, 90, 0])
            rotate([0, 0, 30])
                cylinder(d = M3_head_diameter -0.6, h = M3_head_height+1.7, $fn = draft?16:120);
        }

    // bottom bearing
    translate([bearing_shaft_shift + bearing_thickness, 0, bearing_outer_diameter/2 + Bwall])
         rotate([0, 90, 180])
             cylinder(d = bearing_outer_diameter, h = 100);

    // rotor shaft hole
    translate([bearing_shaft_shift + bearing_thickness + layer_thickness, 0, bearing_outer_diameter/2 + Bwall])
        rotate([0, 90, 0])
            cylinder(d = bearing_inner_diameter, h = 100, $fn = draft?16:120);

    //top bearing
    translate([bearing_shaft_shift + bearing_shaft_length - bearing_thickness, 0, bearing_outer_diameter/2 + Bwall])
        rotate([0, 90, 0])
            cylinder(d = bearing_outer_diameter, h = bearing_thickness + global_clearance, $fn = draft?16:120);

    translate([bearing_shaft_shift + bearing_thickness -10, 0, bearing_outer_diameter/2 + Bwall])
        rotate([0, 90, 0])
            cylinder(d = 0.6, h = 2*layer_thickness, $fn = draft?16:120);  // Dírka pro tisk

    // podlozka pod hlavu sroubu - roll axis
    translate([0, 0, bearing_outer_diameter + Bwall*2+1])
        cylinder(d = 9, h = 5, $fn = draft?16:120);

    // hollows slicing bug workaround hole
    translate([rod_size/2+Vyska_sloupku+H_mill_disc-Pin_slot_height/2, 0, bearing_outer_diameter + Bwall*2+1.3])
        sphere(d = 6, $fn = draft?16:120);
        
/*         translate([rod_size/2+Vyska_sloupku+H_mill_disc-Pin_slot_height/2, 0, bearing_outer_diameter + Bwall*2-6])
    #    cylinder(d = 1.07, h = 20, $fn = draft?16:120); */  // Testovací válec o průměru pinu


    // TFPROBE01 RPM sensor
    translate([-rod_size/2, -9/2, bearing_outer_diameter + Bwall*4])
        cube([rod_size + TFPROBE01_sensor_height/3,9,rod_y_distance]);

    if(breaking_groove == true)
    translate([rod_size/2 + bearing_outer_diameter - rod_size +1, 0, bearing_outer_diameter/2 + Bwall]) rotate([0, 90, 0])
        difference(){
            cylinder(d = bearing_outer_diameter + Bwall*2+1, h = Groove_height, $fn = draft?16:120);

            cylinder(h = Groove_height, d1 = bearing_outer_diameter + Bwall*2, d2 = Inner_diameter, $fn = draft?16:120);
            cylinder(h = Groove_height, d1 = Inner_diameter, d2 = bearing_outer_diameter + Bwall*2, $fn = draft?16:120);
        }

    // Západky pro uchycení válce
    translate([+rod_size/2-ZmenseniTisk+PosunNahoru, -bearing_outer_diameter/2 - Bwall-PridavnaSirkaNaSpojeniDilu/2-PosunZapadek+ZmenseniTisk, +BaseThickness+(bearing_outer_diameter)/2+bearing_outer_diameter/2 + Bwall-ZmenseniTisk])
        rotate([0, -45, 0])
            translate([0, 0,  PosunZ])
                cube([ZapadkaX+4, ZapadkaY, ZapadkaZ+4]);

    translate([+rod_size/2-ZmenseniTisk+PosunNahoru, -(-bearing_outer_diameter/2 - Bwall-PridavnaSirkaNaSpojeniDilu/2-PosunZapadek+ZmenseniTisk)-ZapadkaY, +BaseThickness+(bearing_outer_diameter)/2 +bearing_outer_diameter/2 + Bwall-ZmenseniTisk])
        rotate([0, -45, 0])
            translate([0, 0,  PosunZ])
                cube([ZapadkaX+4, ZapadkaY, ZapadkaZ+4]);
  }

  // bridge slicing helper
  translate([-rod_size/2+TloustkaDna, 0, bearing_outer_diameter/2 + Bwall])
      rotate([0, 90, 0])
          difference(){
              cylinder(d = bearing_outer_diameter + 2*global_clearance, h = layer_thickness, $fn = draft?16:120);  // Dírka pro tisk
              // hollows slicing bug workaround hole
              cylinder(d = 2*global_clearance, h = 2*layer_thickness, $fn = draft?16:120);  // Dírka pro tisk
          }
}

module 888_1012(draft = true){


    union(){
    translate([0, 0, -bearing_outer_diameter/2 - Bwall])
    difference(){
    union(){


        // sloupky
        hull(){
            translate([0, 0, -BaseThickness+4])
                cube([rod_size, rod_size, 6], center = true);

            translate([0, rod_y_distance/2 - rod_size/4 , rod_x_distance + rod_size/2])
                cube([rod_size, rod_size/2, rod_size],center = true);

            translate([0 , -rod_y_distance/2 + rod_size/4, rod_x_distance + rod_size/2])
                cube([rod_size, rod_size/2, rod_size],center = true);
        }
    }

    // servo nuts
   translate([0, rod_y_distance/4, rod_x_distance + rod_size])
       rotate([0, 90, 0])
           cylinder(d = rod_x_distance/2, h = 100, center = true, $fn = draft?16:120);

   translate([0, - rod_y_distance/4, rod_x_distance + rod_size])
       rotate([0, 90, 0])
           cylinder(d = rod_x_distance/2, h = 100, center = true, $fn = draft?16:120);

     // Zapusteni pro loziska
   translate([bearing_shaft_shift + bearing_shaft_length - bearing_shaft_length + bearing_thickness - 100, 0, bearing_outer_diameter/2 + Bwall])
        rotate([0, 90, 0])
            cylinder(d = bearing_outer_diameter, h = 100, $fn = draft?16:120);



    // Dira pro ROLL osu.
    translate([0, 0, -10])
        cylinder(d = M3_screw_diameter, h = 100, $fn = draft?16:120);

        // TFPROBE01 RPM sensor
    translate([-rod_size/2, -9/2, bearing_outer_diameter + Bwall*4-0.2])
        cube([rod_size + TFPROBE01_sensor_height/3,9,rod_y_distance]);

      // podlozka pod hlavu sroubu
    translate([0, 0, bearing_outer_diameter + Bwall*2+1])
        cylinder(d = 9, h = 5, $fn = draft?16:120);

    // diry v sloupku pro pridelai kuloveho drzaku pro tahlo
    translate([0, 0, rod_x_distance + rod_size/2])
        rotate([90, 0, 0])
            translate([0, 0, -100])
                cylinder(d = M2_screw_diameter, h=200, $fn = draft?16:120);

    translate([0, 0, rod_x_distance + rod_size/2])
        rotate([90, 0, 0])
          cylinder(d = M2_nut_diameter, h = rod_y_distance - 2* Bwall, center = true, $fn=6);

     // Odečtení kvádru patřícího ke sloupku
    translate([-rod_size/2, -bearing_outer_diameter/2 - Bwall-PridavnaSirkaNaSpojeniDilu/2, -BaseThickness])
                cube([bearing_outer_diameter, bearing_outer_diameter + Bwall*2 +PridavnaSirkaNaSpojeniDilu, bearing_outer_diameter + Bwall*2+3]);

      // Prodloužení děr ve sloupcích pro připevnění disku
          rotate([0, 90, 0])
             for(i=[-1,1])
                translate([ -bearing_outer_diameter/2 - Bwall-PosunZsl,  i*PosunYsl, -5])
                    cylinder(d = Self_screw_diameter, h = Vyska_sloupku+10, $fn = draft?16:120);         
    }

  // Západky pro uchycení válce

    difference(){
        union(){
   translate([+rod_size/2+PosunNahoru, -bearing_outer_diameter/2 - Bwall-PridavnaSirkaNaSpojeniDilu/2-PosunZapadek, +BaseThickness+(bearing_outer_diameter)/2+0])
      rotate([0, -45, 0])
    translate([0, 0,  PosunZ])
    cube([ZapadkaX+1, ZapadkaY, ZapadkaZ+2]);

     translate([+rod_size/2+PosunNahoru, -(-bearing_outer_diameter/2 - Bwall-PridavnaSirkaNaSpojeniDilu/2-PosunZapadek)-ZapadkaY, +BaseThickness+(bearing_outer_diameter)/2+0])
      rotate([0, -45, 0])
    translate([0, 0,  PosunZ])
    cube([ZapadkaX+1, ZapadkaY, ZapadkaZ+2]);
        }
     translate([+rod_size/2+5, 0, 0])
       cube([10, 50, 40], true);

    }
    
    //Sloupky pro uchycení mlýnku
    for(i=[-1,1])
    translate([rod_size/2, i*PosunYsl,  PosunZsl])
        rotate([0, 90, 0])
           difference(){
                cylinder(d = 4.3, h = Vyska_sloupku, $fn = draft?16:120);
                cylinder(d = Self_screw_diameter, h = Vyska_sloupku+0.2, $fn = draft?16:120);

           }

   //tretí sloupek
   translate([rod_size/2, 0, 22.6])
        rotate([0, 90, 0])
           difference(){
               union()
               {
                
                cylinder(d = 4.3, h = Vyska_sloupku, $fn = draft?16:120);
                translate([0.1, 0, 1.3-4])
                cube([4.5, 15, 7], true);
               }
               translate([0, 0, -7])
               cylinder(d = Self_screw_diameter, h = Vyska_sloupku+10, $fn = draft?16:120);

                rotate([0, -90, 0])
                translate([-6, 0, -4])
               cylinder(d = 9, h = Vyska_sloupku+10, $fn = draft?16:120);
               }
    /* */
}

// Spojení s lámacím válcem
translate([0, 0, -bearing_outer_diameter/2 - Bwall])
difference(){
        intersection(){

        translate([-rod_size/2, -bearing_outer_diameter/2 - Bwall-PridavnaSirkaNaSpojeniDilu/2, -BaseThickness])
                cube([bearing_outer_diameter-ZmenseniTisk, bearing_outer_diameter + Bwall*2 +PridavnaSirkaNaSpojeniDilu, bearing_outer_diameter + Bwall*2+3]);

      union()  {


  // Seriznuti podstavy
           translate([-rod_size/2- bearing_outer_diameter+TloustkaDna, -bearing_outer_diameter/2 - Bwall-PridavnaSirkaNaSpojeniDilu/2, -BaseThickness])
                cube([bearing_outer_diameter, bearing_outer_diameter + Bwall*2 +PridavnaSirkaNaSpojeniDilu, bearing_outer_diameter + Bwall*2+3]);
       }
}

 // Dira pro ROLL osu.
    translate([0, 0, -10])
        cylinder(d = M3_screw_diameter, h = 100, $fn = draft?16:120);

 // Diry na sesroubovani obou casti
    rotate([0, rot_screw, 0]){
        translate([-rod_size/2+1.9, -bearing_outer_diameter/2 - Bwall-PridavnaSirkaNaSpojeniDilu/2 + PosunDerY, -BaseThickness-(bearing_outer_diameter)/2+ 5 + PosunDerZ])
        rotate([0, 90, 0])
        cylinder(d = M3_screw_diameter, h = 100, $fn = draft?16:120);

     translate([-rod_size/2+1.9, -(-bearing_outer_diameter/2 - Bwall-PridavnaSirkaNaSpojeniDilu/2 +PosunDerY), -BaseThickness-(bearing_outer_diameter)/2+ 5 + PosunDerZ])
        rotate([0, 90, 0])
        cylinder(d = M3_screw_diameter, h = 100, $fn = draft?16:120);

    translate([-rod_size/2-2, -bearing_outer_diameter/2 - Bwall-PridavnaSirkaNaSpojeniDilu/2 + PosunDerY, -BaseThickness-(bearing_outer_diameter)/2+ 5 + PosunDerZ])
        rotate([0, 90, 0])
     rotate([0, 0, 120])
     cylinder(d = M3_nut_diameter, h = M3_nut_height+1, $fn = 6);

    translate([-rod_size/2-2, -(-bearing_outer_diameter/2 - Bwall-PridavnaSirkaNaSpojeniDilu/2 +PosunDerY), -BaseThickness-(bearing_outer_diameter)/2+ 5 + PosunDerZ])
        rotate([0, 90, 0])
     rotate([0, 0, 120])
     cylinder(d = M3_nut_diameter, h = M3_nut_height+1, $fn = 6);
    }

    // Rohy (Roh je označení pro sešikmené kvádry ve spojení obou dílů s dírami na šrouby)
       difference(){
            translate([-rod_size/2+TloustkaDna-VyskaRohu, -bearing_outer_diameter/2 - Bwall-PridavnaSirkaNaSpojeniDilu/2, -BaseThickness])
                cube([VyskaRohu, bearing_outer_diameter + Bwall*2 +PridavnaSirkaNaSpojeniDilu, bearing_outer_diameter + Bwall*2+3]);

          translate([-rod_size/2+TloustkaDna-VyskaRohu, -bearing_outer_diameter/2 - Bwall-PridavnaSirkaNaSpojeniDilu/2+SirkaRohu, -BaseThickness])
                cube([VyskaRohu, bearing_outer_diameter + Bwall*2 +PridavnaSirkaNaSpojeniDilu - 2*SirkaRohu, bearing_outer_diameter + Bwall*2+3]);

           translate([-rod_size/2+TloustkaDna-8, -bearing_outer_diameter/2 - Bwall-PridavnaSirkaNaSpojeniDilu/2+SirkaRohu, -BaseThickness])
           rotate([0,0,-45])
           translate([0,-5,0])
                cube([6, 12, bearing_outer_diameter + Bwall*2+3]);

       mirror([0,1,0])
           translate([-rod_size/2+TloustkaDna-8, -bearing_outer_diameter/2 - Bwall-PridavnaSirkaNaSpojeniDilu/2+SirkaRohu, -BaseThickness])
           rotate([0,0,-45])
           translate([0,-5,0])
                cube([6, 12, bearing_outer_diameter + Bwall*2+3]);

        }

             // podlozka pod hlavu sroubu
    translate([0, 0, bearing_outer_diameter + Bwall*2+1])
        cylinder(d = 9, h = 5, $fn = draft?16:120);

}

}

888_1012(draft=false);



 /*translate([0, 0, -bearing_outer_diameter/2 - Bwall - 20])
 bearing_house();*/
