include <bolt_parameters.scad>
use <./src/lib/stdlib/naca4.scad>

week = "77";  // dummy value for visual rendering not used for printing.

global_clearance = 0.2;
clearance = global_clearance;

layer_thickness = 0.2;
base_patern = 10;

gliding_angle = 14;         // tenhle úhel by se zřejmě v budoucnu měl počítat z požadované klouzavosti.



////Simoniny parametry pro nosník rotoru
base_length = 290; //delka podlozky
base_split_position = [0, 149, base_length];
base_width = 70; //sirka podlozky - vnější šířka nosníku
base_thickness = 3; //vyska podlozky
rantl_thickness = 3; //sirka steny podlozky
rantl_height = 6.5;
niy=4; //pocet der podelne

side_base_thickness = 0.2*6; // minimalni tlouska  u bocnic napr. sten



// Rotor parameters

rotor_blade_AOA = 1.5;      // nastavení úhlu náběhu rotorového listu
rotor_blade_rod = true;  // generovat diru pro uhlikove tycky
rotor_blade_length = 500;   // délka rotorového listu
// rotor_blade_length = 450 - 15;   // délka rotorového listu -- nastaveni prvniho vytisku
//rotor_blade_length = 460;   // délka rotorového listu
rotor_blade_depth = 45.5+2;     // hloubka rotorového listu
rotor_balde_tip_cutoff = 15.5;

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
//rotor_balde_tip_cutoff = 10;

rotor_blade_naca = 2412;
rotor_blade_parts_count = 4;
//rotor_blade_parts_count = 3;

blade_transition_length = 10; // length of blade transition

blade_mount_screw_distance = (16.47+11.86)/2;

rod_from_end = 10;

/* blade_shell_thickness = 0.4;
blade_shell_thickness_inner = 0.4;
blade_shell_thickness_wire = 0.4;
blade_infill_distance = 25;
blade_infill_overlap = 0; */

/// Nastaveni pro Slic3r
blade_shell_thickness = 0.5;
blade_shell_thickness_inner = 0.08;
blade_shell_thickness_wire = 0.5;
blade_infill_distance = 23;
blade_infill_overlap = 0;

//blade_rod_position = [rotor_blade_depth/4 + 5, 0, 0];
//blade_rod_position2 = [rotor_blade_depth/4 - 5, 0, 0];

//blade_rod_position = [15, 0, 0];
//blade_rod_position2 = [4, 0.3, 0];

//blade_rod1_diameter = 2.58;
//blade_rod2_diameter = 2.58;
//blade_rod3_diameter = 2.13;
blade_rod1_diameter = 2.45;
blade_rod2_diameter = 2.45;
blade_rod3_diameter = 2.45;


// blade_rod1_position = [3.4, 0.3, 0];

blade_rod1_xposition = rotor_blade_depth/4 - 8.9;
blade_rod1_yposition = rotor_blade_depth * camberY(naca = rotor_blade_naca, x = blade_rod1_xposition / rotor_blade_depth); // calculate airfoil chamber line y position

blade_rod1_position = [blade_rod1_xposition, blade_rod1_yposition, 0];  // shift rod1 to chamber line location
blade_rod2_position = [rotor_blade_depth/4 - 5.8, 0.5, 0];
blade_rod3_position = [rotor_blade_depth/4 + 3.5, 0.5, 0];

blade_glue_holes = 0;

blade_mount_screw = M3_screw_diameter;
blade_mount_nut = M3_nut_diameter;

rotor_blade_endtip_diameter = 20;

rotor_blade_part_list = [0, 50, 200, 350, 500];


// vzdalenosti der pro kryty
//platform_mount_points = [base_patern*5, base_patern*13, base_patern*17, base_patern*26];
// Otvory pro pripevneni na platformu
platform_mount_points = [base_patern*8, base_patern*26];



/////
// Tohle jsou parametry jeste z AUto-G2
/////
rotor_head_width =  30;    //Rozměr 1 v nákresu
pylon_wall_thickness = 4.2;  // Rozměr 2 v nákresu
horizontal_screw_distance = 14.5;   // Rozměr 4 v nákresu
vertical_screw_distance = 12;       // rozměr 5 v nkresu
topscrew_distance_endofpylon = 5;

rotorhead_wall_thickness = 3; // sila tistenych dilu


bearing_outer_diameter = 10.2;    // Rozměr B1 v nákresu s přídavkem na toleranci otvoru
bearing_thickness = 4;        // Rozměr B2 v nákresu
//bearing_shaft_length = 19.5;    // Rozměr B3 v nákresu, Originalni hodnota 19.5
bearing_shaft_length = 20;    // Rozměr B3 v nákresu

/////
// Parametry rotorové hlavy
/////

////
//
//	Navrh geometrie rotorove hlavy vychazi z nakresu od Dobiase
//
////

rotor_head_plate_thickness = 5;

rotor_ball_joint_neck = 3; // vyska krcku tahla od stredu koule.


// parametry pro dil, co se naklapi v roll a pitch, obsahuje tfprobe

// delka dilu v podelne ose virniku - od osy pitch
rotor_head_rod_x = 35;
// sirka dilu na stredy tahel
rotor_head_rod_y = rotor_head_rod_x*2 - rotor_ball_joint_neck*2;
// vyska dilu az po rovinu rotoru
rotor_head_rod_z = 0;

rotor_head_shaft_angle = 10;



rotor_head_pitch = 0;
rotor_head_roll = 0;



// Engine and engine holder parameters

motor_holder_height = base_patern * 5;
motor_holder_thickness = 3.5;
motor_holder_motor_height = 25;
motor_holder_side_mount_height = base_patern*2.5;
pylon_holder_side_mount_height = base_patern*4.5;

engine_angle = -5; // ongle of engine axis relative to fuselage main axis
engine_diameter = 55;
engine_offset = 53;			// Posun motoru v ose X (dopredu)




// Parametry pro hacek na kabely od motoru
	motor_wire_holder_width = 5;
	motor_wire_holder_height = 10;
	motor_wire_holder_space = 3;
	motor_wire_holder_thickness = 2.5;
	motor_wire_holder_z_shift = 10;
	motor_wire_holder_x_shift = 19;

// Parametry pro ochranny ram nad motorem
	motor_protective_frame_x_shift = 20;
	motor_protective_frame_z_base = 32;
	motor_protective_frame_beam_width = 5;
	motor_protective_frame_beam_thickness = 3;
	motor_protective_frame_width = base_width-3;
	motor_protective_frame_plug_thickness = 2;
	motor_protective_frame_plug_length = 4;
	motor_protective_frame_thickness = 5;
	motor_protective_frame_z_scale = 0.75;



// Overit, jestli tyto parametry jsou pouzite
engine_screws_radius = 15;
engine_holes_radius = (24 + 44)/4;
engine_shatf_hole_diameter = 13;

//sroub servo
Servo_screw = 1.5;
Servo_nut_height = 1;
Servo_nut_diameter = 2.7;

tail_pipe_d = 10.3;

// elevator parameters

elevator_pitch = 2; // elevator pitch relative to main fuselage axis

/// rudder parameters

rudder_height = 150;
height_bottom_part = 130;
rudder_depth_max = 200;

below_rudder_height = 30;
rudder_depth = 60;

tail_airfoil_n = 80;

//center_of_gravity_position = [main_pylon_position - tan(gliding_aggle)*rotor_height, 0, 0];


////landing gear

radius_undercarriage = 25;
vzdalenost_x = tan(20) * 131;
vzdalenost_y = (131 - radius_undercarriage)/tan(79);
uhel_y = 90 - 20;
uhel_x = 90 - 79;

maximum_printable_size = 150;



// Rotor pylon parameters


// pylon_height = 250 - pylon_holder_side_mount_height;


pylon_pipe_d = 10.3;
pylon_suspension_height = 150;
pylon_pipe_top_dist = 0;
pylon_thickness = 0; // Netusim, co to je

pylon_bottom_wall = 5;

pylon_silentblocks_base_distance = 58;    // vzdalenost silentblocku pylonu od sebe
pylon_pipe_top_y_dist = 25;
pylon_pipe_top_x_dist = 30;
pylon_screw_top_y_dist = 25;
pylon_screw_top_x_dist = 15;

pylon_height = 180 + 50 - pylon_holder_side_mount_height;

airspeed_width = 35;
airspeed_naca = 0004;
airspeed_dist = 20;


// Parametry k akumulatoru

battery_type = "Zippy_4S_3700";
//  GensACE 3300 mAh


//if(battery_type == "GensACE_3S_3300"){
	// battery_case_height = 25;
	// battery_case_start_x = 25;
	// battery_case_wall = 1;

	// battery_width = 50;
	// battery_height = 20;
	// battery_length = 150;

	// battery_capacity = 3300;
	// battery_cells = 3;
//}


// ZIPPY 3700 mAh
//if(battery_type == "Zippy_4S_3700"){
	battery_case_height = 0;
	battery_case_start_x = 25;
	battery_case_wall = 0.4*3;


/* // ZIPPY 3700 mAh
	battery_width = 48;
	battery_height = 35;
	battery_length = 150;
	battery_capacity = 3700;
	battery_cells = 4; */

/* // ZIPPY 4500 mAh
	battery_width = 48;
	battery_height = 42;
	battery_length = 160;
	battery_capacity = 4500;
	battery_cells = 4; */


// ZIPPY 5000 mAh
	battery_width = 48;
	battery_height = 42;
	battery_length = 165;
	battery_capacity = 5000;
	battery_cells = 4;



//}
