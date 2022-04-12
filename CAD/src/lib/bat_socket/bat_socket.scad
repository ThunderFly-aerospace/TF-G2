
module xt60flange_hole(){

	hull(){
		translate([-4.1, -15.6/2, 0]) cube([8.2, 1, 10]);
		translate([0, 15.6/2-8.2/2, 0]) cylinder(d=8.2, h=10, $fn=20);
	}

	for(y=[-10, 10]) translate([0, y, 0]) cylinder(d=3, h=10, $fn=14);

}

module dovetail_socket(h = 10, connector = 0){

	difference(){
		render() translate([-3, 0, -4])
			rotate([90, 0, 90])
				linear_extrude(h+3)
					import("dovetail_socket.dxf", layer="layer");

		for(i=[1:2:5])
		translate([25*i+3, -70/2, 5]) cube([25, 70, 10]);
	}

	if(connector != 0){
		translate([-3, 0, 0])
		difference(){
			union(){
				translate([0, -73/2, 0])
					cube([3, 73, 11]);
				if(connector=="XT60"){
					translate([0, -35/2, 0]) cube([3, 35, 17]);
				}
				}

			if(connector=="XT60"){
				translate([0, 0, 10]) rotate([0, 90, 0]) xt60flange_hole();
			}
		}
	}
}


//dovetail_socket(h=150, connector = "XT60");



module batt_grid(count_x=8, count_y=1, thickness=4){
	difference(){
		translate([-10, -thickness/2, -10]) cube([count_x*20, thickness, count_y*20]);
		for(p_x = [0:count_x-1], p_y = [0:count_y-1])
			translate([p_x*20, 0, p_y*20]){
				color("green") rotate([90, 0, 0])
					cylinder(d = 18.5, h=65, center=true);
			}
		}
}

//batt_grid();
