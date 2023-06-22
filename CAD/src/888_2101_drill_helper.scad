
d=25.3;
screw_p=25;
screw_d=3.1;

add=2;
l=screw_p+3*add;

difference()
{
    translate([0,0,l/2-add])
        cube([d+2*add,d+2*add,l],center=true);   
    cylinder(d=d,h=350,$fn=120);
    translate([0,0,screw_p])
        rotate([0,90,0])
            cylinder(d=screw_d,h=2*d,$fn=120,center=true);
}
