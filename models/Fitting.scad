
stand_d = 14;

module fitting(){
difference(){
union(){
//difference(){
 cylinder(d=stand_d+6,h=20,$fn=60);
 //cylinder(d=stand_d,h=60,$fn=60);
//}

translate([0,15,0])
difference(){
rotate([90,0,0]){
translate([0,191,-10])
union(){
difference(){
 cylinder(d=335+8,h=50,$fn=600);
 translate([0,0,-10])
 cylinder(d=335,h=100,$fn=100);
}
}
}

translate([-200,-60,22])
cube([500,500,500]);
}
}

 translate([0,0,-10])
 cylinder(d=stand_d,h=60,$fn=60);
 translate([-9,-15,0])
 cylinder(d=3,h=60,$fn=60);
 translate([-9,15,0])
 cylinder(d=3,h=60,$fn=60);
translate([-20,0,10])
rotate([0,90,0])
cylinder(d=5,h=60,$fn=60);
 translate([0,-50,0])
 cube([100,100,100]);
 translate([-35,-30,0])
 cube([20,100,100]);
}

}

