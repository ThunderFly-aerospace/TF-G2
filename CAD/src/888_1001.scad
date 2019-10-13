w1=65;
w2=3;
l=140;
h1=3;
h2=10;
d=3.2;
s=10.16;
nix=4;
niy=13;


module 888_1001(){
difference()
    {union()
            {translate([-w1/2,-l/2,0])
             cube([w1,l,h1]);
            for (i=[w1-w2,0,0])
                translate([i-w1/2,-l/2,0])
                    cube([w2,l,h2]);}
        #for (i=[-nix/2:nix/2],j=[-niy/2:niy/2])
            translate([i*s,j*s,0])
                cylinder(h=h1,d=d,$fn=100);
        for (j=[-niy/2:niy/2])
            rotate([0,90,0])
            translate([-h1-(h2-h1)/2,j*s,-w1/2])
                cylinder(h=w1,d=d,$fn=100);
            }
}

888_1001();
