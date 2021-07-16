

stand_outer=32;
stand_height=15;
shiled_diameter=66;
shiled_inside_diameter=20;
stick_outer = 4;
stick_inner = 2.5;

stand_d = 14;

/*
union(){
  difference(){
        cylinder(d=stand_outer+4,h=stand_d,$fn=60);
        cylinder(d=stand_outer,h=stand_d+5,$fn=60);
  }
}*/


module shield(istop=false)
{
difference(){
    cylinder(d1=shiled_diameter,d2=shiled_diameter-18,h=6,$fn=60);
    translate([0,0,-2])
        cylinder(d1=shiled_diameter+5,d2=shiled_diameter-18,h=6,$fn=60); 
    if(!istop)
    {
        translate([0,0,3.8])     
        cylinder(d1=shiled_inside_diameter,d2=shiled_inside_diameter,h=4,$fn=60);

    for(i=[0:2])
   {
       rotate([0,0,i*120]) 
       translate([15,0,5])
       cylinder(d=stick_outer,h=10,center=true,$fn=60);
    }


    }
    
}

for(i=[0:2])
{
   rotate([0,0,i*120]) 
   translate([15,0,5])
   difference(){ 
   translate([0,0,-2])
   cylinder(d=stick_outer+2.5,h=4.5,center=true,$fn=60);
   cylinder(d=stick_outer,h=10,center=true,$fn=60);
   }   
}


}

module holder(){
difference(){
union(){
translate([0,0,-6])
cylinder(d1=stand_outer-8,d2=stand_outer,h=6,$fn=60);
for(i=[0:2])
{
   rotate([0,0,i*120]) 
   translate([15,0,-2])
   cylinder(d=stick_outer+2,h=4,center=true,$fn=60); 
}
}

for(i=[0:2])
{
   rotate([0,0,i*120]) 
   translate([15,0,0])
   union(){ 
   cylinder(d=stick_inner+1,h=20,center=true,$fn=60);
   translate([0,0,-5])
   cylinder(d=6,h=3,center=true,$fn=60); 
   }   
}

translate([0,0,-2])
cylinder(d=stand_outer-13,h=6,$fn=60);

translate([-2,2,-2])
rotate([90,0,30])
cylinder(d=3,h=50,$fn=60);
}


translate([0,0,-14])
rotate([90,0,30])
union(){
difference(){
 cylinder(d=stand_d+6,h=30,$fn=60);
 cylinder(d=stand_d,h=60,$fn=60);
}
difference(){
    sphere(d=stand_d+6,$fn=50);
    translate([-50,-20,0])
    cube([100,100,120]);
}
}

}



