//@set_slicing_config(../../slicing/test.ini)
h=5;
a=10;
b=2;
s=1;
$fn=20;
linear_extrude(height = 0.20)
    square([a,b]);
    
linear_extrude(height = h)
    square(s);

difference(){
translate([a,0,0])    
linear_extrude(height = h)
    square(2*s);
translate([a+s/2,s/2,0])    
  linear_extrude(height = h+1)
    square(1);
}


linear_extrude(height = 0.20)
    square([b,a]);

difference(){
translate([s,a,0])    
linear_extrude(height = h)
    circle(s);
translate([s,a,0])    
  linear_extrude(height = h+1)
    circle(s/2);
}
