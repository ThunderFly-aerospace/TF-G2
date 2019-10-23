
global_clearance = 0.5;

layer_thickness = 0.3;

//Main tube diameter - hole [mm]
main_tube_outer_diameter = 25.4;
main_tube_inner_diameter = 23.05;

// Nastavení parametrů rotoru

gliding_aggle = 14;         // tenhle úhel by se zřejmě v budoucnu měl počítat z požadované klouzavosti.

rotor_blade_AOA = 1.5;      // nastavení úhlu náběhu rotorového listu

// Rotor Auto-G2
rotor_blade_rod = true;  // generovat diru pro uhlikove tycky
rotor_blade_length = 400 - 15;   // délka rotorového listu
rotor_blade_depth = 45.5;     // hloubka rotorového listu


blade_mount_length = 30;

blade_mount_width = 17;
blade_mount_thickness = 4.6;
blade_mount_screw_offset = 5; // distance of first screw from rotor end

// Testovaci maly rotor

        /*
        rotor_blade_rod = false;
        rotor_blade_length = 145;   // délka rotorového listu
        rotor_blade_depth = 45.5 * (145/385);     // hloubka rotorového listu
        blade_mount_length = 20;
        blade_mount_width = 10;
        blade_mount_thickness = 4;
        */

// konec parametru pro testovaci maly rotor

rotor_height = 180;         // výška otočného kloubu rotoru nad hlavní trubkou vírníku (odhad)
rotor_blades_count = 2;
rotor_delta_angle = 12;
rotor_blade_thickness = 5.1;

rotor_blade_naca = 2412;
rotor_blade_parts_count = 3;

blade_transition_length = 10; // length of blade transition

blade_mount_screw_distance = (16.47+11.86)/2;

/* blade_shell_thickness = 0.4;
blade_shell_thickness_inner = 0.4;
blade_shell_thickness_wire = 0.4;
blade_infill_distance = 25;
blade_infill_overlap = 0; */

/// Nastaveni pro Slic3r
blade_shell_thickness = 0.45;
blade_shell_thickness_inner = 0.43;
blade_shell_thickness_wire = 0.45;
blade_infill_distance = 20;
blade_infill_overlap = 0;


//blade_rod_position = [rotor_blade_depth/4 + 5, 0, 0];
//blade_rod_position2 = [rotor_blade_depth/4 - 5, 0, 0];

//blade_rod_position = [15, 0, 0];
//blade_rod_position2 = [4, 0.3, 0];

blade_rod1_diameter = 2.58;
blade_rod2_diameter = 2.58;
blade_rod3_diameter = 2.13;

blade_rod1_position = [3.4, 0.3, 0];
blade_rod2_position = [rotor_blade_depth/4 - 4, 0.2, 0];
blade_rod3_position = [rotor_blade_depth/4 + 3.5, 0, 0];


rotor_head_width =  21.4;    //Rozměr 1 v nákresu
pilon_wall_thickness = 4.2;  // Rozměr 2 v nákresu
horizontal_screw_distance = 14.5;   // Rozměr 4 v nákresu
vertical_screw_distance = 12;       // rozměr 5 v nkresu
topscrew_distance_endofpilon = 5;

rotorhead_wall_thickness = 2; // sila tistenych dilu


bearing_outer_diameter = 10.2;    // Rozměr B1 v nákresu s přídavkem na toleranci otvoru
bearing_thickness = 4;        // Rozměr B2 v nákresu
//bearing_shaft_length = 19.5;    // Rozměr B3 v nákresu, Originalni hodnota 19.5
bearing_shaft_length = 20;    // Rozměr B3 v nákresu


// nastavení parametrů motoru

engine_angle = -8;
engine_diameter = 55;
engine_offset = 55;

engine_screws_radius = 15;
engine_holes_radius = (24 + 44)/4;
engine_shatf_hole_diameter = 13;

// screw length step - minimum difference in length between two types of screws
basic_screw_length = 5;

//Screw diameter and nut for M6 [mm]
M6_screw_diameter=6.5;
M6_head_diameter = 10+0.5;
M6_head_height = 6;
M6_nut_height = 4.9;
M6_nut_diameter = 11.8;
M6_nut_pocket = 10.4;

//Screw diameter and nut for M5 [mm]
M5_screw_diameter=5.5;
M5_head_height = 5;
M5_head_diameter = 13+0.5;
M5_nut_height = 4.5;
M5_nut_diameter = 9.4;
M5_nut_pocket = 8.4;

//Screw diameter and nut for M4 [mm]
M4_screw_diameter=4.5;
M4_screw_head_height = 4;
M4_nut_height = 3.2;
M4_nut_diameter = 8.4;
M4_nut_pocket = 7.5;

//Screw diameter and nut for M3 [mm]
M3_screw_diameter = 3.2;
M3_nut_height = 2.7;
M3_nut_diameter = 6.6;
M3_screw_head_height = 3;
M3_nut_pocket = 5.6;


//Screw diameter and nut for M2,5 [mm]
M2_5_screw_diameter = 2.7;
M2_5_nut_height = 2.3;
M2_5_nut_diameter = 6;
M2_5_nut_pocket = 5.1;

//Screw diameter and nut for M2 [mm]
M2_screw_diameter = 2.0;
M2_nut_height = 1.8;
M2_nut_diameter = 4.8;
M2_nut_pocket = 3.95;


blade_mount_screw = M2_screw_diameter;
blade_mount_nut = M2_nut_diameter;


//šroub servo
Servo_screw = 1.5;
Servo_nut_height = 1;
Servo_nut_diameter = 2.7;



//center_of_gravity_position = [main_pilon_position - tan(gliding_aggle)*rotor_height, 0, 0];


////podzvozek

radius_undercarriage = 25;
vzdalenost_x = tan(20) * 131;
vzdalenost_y = (131 - radius_undercarriage)/tan(79);
uhel_y = 90 - 20;
uhel_x = 90 - 79;

maximum_printable_size = 150;


////Pitotova trubice
Pitot_tube_diameter = 4.02 + 1;
Distance_hole_from_tube = 11.92;  //vzdálenost otvoru pro připevnění od samotné trubičky


////Vlečné zařízení
tow_ring_diameter = 20;
tow_ring_thickness = 5;
tow_ring_groove = 2;
tow_ring_hole_diameter = M3_screw_diameter;

////Simoniny parametry pro nosník rotoru
base_length = 145; //delka podlozky
base_width = 55; //sirka podlozky
base_height = 10; //vyska podlozky
rantl_thickness = 4; //sirka steny podlozky
niy=13; //pocet der podelne
nix=6; //pocet der pricne

