//Pouozdro na akumulator

include <../parameters.scad>

module mirror_copy(v=[1,0,0])
{
    children();
    mirror(v) children();
}

//dummy 18650 pack
function pack_length(count,d,space) = count*d+(count-1)*space+(d+space)/2;
function pack_height(d,space) = d+sqrt(d*d-((d+space)/2)*((d+space)/2));
 
module 18650_8_pack(space=10,d=18.5,h=65)
{
    color("green")
    {             
        for(i=[0,1,2,3])
        {
            translate([d/2+i*(d+space),0,0])
                cylinder(h=h,d=d,center=true,$fn=120);
            translate([d+space/2+i*(d+space),pack_height(d,space)-d,0])
                cylinder(h=h,d=d,center=true,$fn=120);
        }
    }
}

module 18650_8_pack_simple(d=18.5,h=65)
{
    color("green")
    {             
        for(i=[0,1,2,3])
            for(j=[0,1])
            {
                translate([d/2+i*d,j*d,0])
                    cylinder(h=h,d=d,center=true,$fn=120);                
            }
    }
}

module 888_1018(battery_case_height = 0, battery_case_start_x = 25, battery_width = 73, battery_case_wall = 0.4*3, battery_height = 39, battery_length = 76, balancer_clip = true, draft=true)
{

    translate([battery_length/2-10, battery_width*3/8, -battery_height])
        rotate([0, 0, -90])
            linear_extrude(battery_case_wall)
              text(str(week, " ^"), halign="center", valign="center", size=4);
    battery_case_holes = true;
    battery_case_wire_holes = true;

    difference(){
      union(){
            minkowski(){
              translate([-(battery_length + 2* battery_case_wall - 3*battery_case_wall)/2, -(battery_width+2*battery_case_wall - 3*battery_case_wall)/2, -battery_height-0.5])
                cube([battery_length + 2* battery_case_wall - 3*battery_case_wall, battery_width+2*battery_case_wall - 3*battery_case_wall, battery_height - battery_case_wall]);
              cylinder(d1 = battery_case_wall, d2=3*battery_case_wall, h=2*battery_case_wall, $fn=30);
            }

          // pripevnovaci kostky
          for(i = [-1,1])          
          difference(){
            x=i*40;
            hull(){
              translate([-5+x, -base_width/2, -7.25])
                cube([10, base_width, 8]);
              intersection()
              {
                translate([-5+x, -(battery_width+2*battery_case_wall)/2, -battery_height+2*battery_case_wall-0.5])
                    cube([10, battery_width+2*battery_case_wall, battery_case_wall]);
                translate([-(battery_length + 2* battery_case_wall - 3*battery_case_wall)/2, -(battery_width+2*battery_case_wall - 3*battery_case_wall)/2, -battery_height-0.5])
                    cube([battery_length + 2* battery_case_wall - 3*battery_case_wall, battery_width+2*battery_case_wall - 3*battery_case_wall, battery_height - battery_case_wall]);        
              }
            }
            
            //seriznutí
            translate([x+i*(battery_width-3.5),0,-battery_height])
                rotate([0,0,15])
                    cylinder(h=2*battery_height,d=2*battery_width, $fn=12);
            
            translate([x, 0, -3])
                rotate([90, 0, 0])
                    cylinder(d = M3_screw_diameter, h = 100, $fn = 20, center = true);
            for(y = [base_width/2-3, -(base_width/2-3)])
              hull(){
                translate([x, y, -3]) rotate([90, 30, 0]) cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6, center = true);
                translate([x, y, 3]) rotate([90, 30, 0]) cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6, center = true);
              }
          }
      }

      // prostor na akumulator
      minkowski(){
        translate([-(battery_length-4*battery_case_wall)/2, -(battery_width-4*battery_case_wall)/2, -battery_height+ battery_case_wall - 0.5])
            cube([battery_length-4*battery_case_wall, battery_width-4*battery_case_wall, battery_height-2*battery_case_wall+global_clearance]);
        cylinder(d1=0, d2=4*battery_case_wall, h=2*battery_case_wall, $fn=30);
      }

      if(battery_case_wire_holes){
        for(y=[-1,0, 1])
          translate([0, y*battery_width*7/24, -battery_height/2])
            hull(){
              translate([0, 0, (battery_height/2-8) ]) rotate([0, 90, 0]) scale([1, 1.2, 1]) cylinder(d = 12, h =battery_length+20, center = true, $fn=30);
              translate([0, 0, -(battery_height/2-8)]) rotate([0, 90, 0]) scale([1, 1.2, 1]) cylinder(d = 12, h =battery_length+20, center = true, $fn=30);
            }
      }

      if(battery_case_holes){
        for(x=[-57,-25, 0 , 25,57])
          translate([x, 0, -battery_height/2])
            hull(){
              translate([0, 0, battery_height/2-(15/2+3)]) rotate([90, 0, 0]) cylinder(d = 18, h=battery_width+10, center = true, $fn=6);
              translate([0, 0, -battery_height/2+(15/2+3)]) rotate([90, 0, 0]) cylinder(d = 18, h=battery_width+10, center = true, $fn=6);
            }

        for(x=[0]){
          translate([x, 0, -battery_height/2])
            hull(){
              minkowski(){
                rotate([0, 0, 0]) cylinder(d = battery_width-15, h=battery_width+10, center = true, $fn=6);
                cylinder(d=4, h=1, $fn=30);
              }
            }
          }
      }

      for (x = [-battery_length/2+20, 0, battery_length/2-20], y=[-battery_width/2+2, battery_width/2-2])
        translate([x, y, -battery_height-5])
          hull(){
            translate([-1.5, 0, 0]) cylinder(d = 3, h = 30, $fn=15, center = true);
            translate([ 1.5, 0, 0]) cylinder(d = 3, h = 30, $fn=15, center = true);
          }

    mirror_copy([0, 1, 0])
      hull(){

        ribbon_hole = base_width/2 - battery_width/2-5*battery_case_wall;
        echo(ribbon_hole);
        translate([-battery_length/2, battery_width/2  + 1.5*battery_case_wall + ribbon_hole/2, -ribbon_hole/2 - M3_screw_diameter/2 - M3_nut_diameter/2 ])
            rotate([0,90,0])
                cylinder(d=ribbon_hole, h=battery_length, $fn=30);
        translate([-battery_length/2, battery_width/2 + 1.5*battery_case_wall + ribbon_hole/4, -battery_height/2 - M3_screw_diameter/2 ])
            rotate([0,90,0])
                cylinder(d=ribbon_hole/2, h=battery_length, $fn=30);
      }
      
      //nuts again
      for(x=[-40,40])
      for(y = [base_width/2-3, -(base_width/2-3)])
              hull(){
                translate([x, y, -3]) rotate([90, 30, 0]) cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6, center = true);
                translate([x, y, 3]) rotate([90, 30, 0]) cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6, center = true);
      }
    }

    // dummy accumulator model
    //%translate([0, 0, -battery_height/2 + 0.75])
    //    cube([battery_length, battery_width, battery_height], center = true);
}




//články
/*space=0;
plength=pack_length(4,18.5,space);
echo(plength);
pheight=pack_height(18.5,space);
echo(pheight);*/

/*translate([-18.5*2,0,-18.5*3/2])
    rotate([90,0,0])
        18650_8_pack_simple();*/
        
//888_1018(battery_width=70,battery_height=pheight+2,battery_length=plength+4);
888_1018();
