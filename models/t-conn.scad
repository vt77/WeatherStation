
stand_d = 14;
width=60;
in_len = 20;

module tt(){
    difference(){
        cylinder(d=stand_d+6,h=width,$fn=60,center=true);
        cylinder(d=stand_d,h=width+10,$fn=60,center=true);        
    }
}

module tconn(){

rotate([90,0,0])
{
difference(){
union(){    
tt();
translate([17,0,0]){    
rotate([0,90,0]){
      cylinder(d=stand_d-1,h=in_len,$fn=60,center=true);
    }
}

}
   translate([17,0,0]){    
   rotate([0,90,0]){ cylinder(d=stand_d-8,h=in_len+10,$fn=60,center=true);
   }}
 
    translate([0,0,20]){    
   rotate([90,0,0]){ cylinder(d=stand_d-8,h=in_len+10,$fn=60,center=true);
   }} 
 
   translate([0,0,-20]){    
   rotate([90,0,0]){ cylinder(d=stand_d-8,h=in_len+10,$fn=60,center=true);
   }} 
   
}

}

}

//tconn();