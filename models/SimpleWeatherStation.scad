include <MCAD/bearing.scad>

/*686zz bearing */
bearing_inner=6;
bearing_outer=13;
bearing_height=5;

stand_inner=28;
stand_outer=30;

shoulder=20;

magnet_diameter = 4;

head_height=15;
stand_height=15;

fletching_width  = 2;
fletching_depth  = 20;

head_bearing_stopper_h = 8;
hallunit_outer = 5;

model = "anemometer_base";


module cup_holder(preview=false)
{
  
  holder_len=11;
  holder_big_h=8;  
  holder_big_w=4;
  holder_sml_h=4.5;  
  holder_sml_w=2.5;
  center_offset = 6;  
    
    
CubePoints = [
  [  0, -holder_big_w ,  0 ],  //0
  [ holder_len, -holder_sml_w ,  0 ],  //1
  [ holder_len, holder_sml_w ,  0 ],  //2
  [  0,  holder_big_w,  0 ],  //3
  [  0,  -holder_big_w,  holder_big_h ],  //4
  [ holder_len,  -holder_sml_w, holder_sml_h  ],  //5
  [ holder_len, holder_sml_w ,  holder_sml_h ],  //6
  [  0,  holder_big_w,  holder_big_h ]]; //7

CubeFaces = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left
  
  p_diam = 3.5;
  p_center_x = holder_sml_w - p_diam / 2;
  p_center_z = holder_sml_h - p_diam / 2;  
  p_depth = 10;
  
  for(i=[1:3])
  {
     rotate([0,0,i*120])
     difference(){     
     translate([center_offset,0,0])    
     polyhedron( CubePoints, CubeFaces);
     translate([holder_len,p_center_x-0.7,p_center_z-0.5])    
     rotate([0,90,0])
     cylinder(d=p_diam,h=holder_len,center=false,$fn=60);
     }
     
     if(preview)
     {
        rotate([0,90,i*120])
        translate([-2,0,10])
        anemometer_cup();
     }
  } 
 
}

module arrow()
{ 
   arrow_diameter = 5;
    
   translate([-50,0,-1])
   rotate([0,90,0])
   difference(){
     cylinder(d=arrow_diameter,h=100,center=false,$fn=30);
     translate([-arrow_diameter/2,-fletching_width/2,0])  
     cube([5,2,fletching_depth],center=false);
   }
   translate([50,0,-1])
   rotate([0,90,0])
   cylinder(r1=2.5,r2=0,h=8,center=false,$fn=30);       
}

module magnet(h=2,magent="D")
{ 
  if(magent=="A")
  {
    /* For axial magnet */
    translate([0,0,-0.5])
    rotate([90,0,0])
    cylinder(d=magnet_diameter,h=h,center=false,$fn=30);    
  }else{
    /* For diametrical magnet */    
    translate([0,0,-h-3.4])
    cylinder(d=magnet_diameter,h=h+0.5,center=false,$fn=100);
  }
}

module chamfer_cylinder(d=20,h=20)
{
    chamfer_diam = 20;
    
    translate([0,0,8])
    rotate_extrude($fn=100)
    translate([8, 0, 0])
    rotate(55)
    square([chamfer_diam/2,chamfer_diam/2],center=true);
    cylinder(d=d,h=h-chamfer_diam/2+4.3,center=false,$fn=100);
    translate([0,0,h-5])
    cylinder(d=14,h=5,center=false,$fn=100);   
}


module circle_chamfer_cylinder(d=20,h)
{
    chamfer_diam = 8;
    inner_height = h-chamfer_diam/2;
    cylinder(d=d-chamfer_diam/2-4,h=h,center=false,$fn=100);
    translate([0,0,inner_height])
    rotate_extrude($fn=100)
    translate([11, 0, 0])
    circle(d=chamfer_diam);
    cylinder(d=d,h=h-chamfer_diam/2,center=false,$fn=100); 
}

module anemometer_cup()
{
     cylinder(d=4,h=20,$fn=25);
     rotate([195,90,i*120])
     translate([-3,43,10])
     //color(c=[0.9,0.6,0])
     difference(){
        sphere(d=30,$fn=50);
        translate([0,0,1])
        sphere(d=30,$fn=50);
     }
}


module anemometer_head(preview=false)
{
   difference(){
    union(){
        //cup_holder();
        rotate([0,180,0])
        translate([0,0,-head_height+3])
        chamfer_cylinder(d=stand_outer,h=head_height);
            rotate([0,180,0])
            translate([0,0,-5])
            cup_holder(preview);
    }
    translate([0,0,0])
    cylinder(d=bearing_outer,h=20,center=false,$fn=100);
    translate([0,0,-1.5])
    cylinder(d=bearing_outer-3,h=2,center=false,$fn=60);
    
    translate([-12,0,stand_height])
    magnet();
  }  
    
}


module anemometer_base(windvane=false){
      
   center_bolt_diameter = 3;
   center_bolt_len = 30;
    
  /* Stand */ 
  
  difference(){
  union(){
  cylinder(d=stand_outer,h=stand_height,center=false,$fn=100);
  translate([0,0,stand_height])
  cylinder(d=bearing_outer-2,h=head_bearing_stopper_h,center=false,$fn=100);
  translate([0,0,stand_height+head_bearing_stopper_h])
  cylinder(d=bearing_inner-0.5,h=bearing_height,center=false,$fn=100);
  }
  translate([0,0,-center_bolt_len+bearing_height+stand_height+head_bearing_stopper_h])
   cylinder(d=center_bolt_diameter,h=center_bolt_len,center=false,$fn=100);
  if(!windvane){
   translate([0,11,-50]) 
  cylinder(d=hallunit_outer,h=100,center=false,$fn=100);
  }else{
      cube([13,13,6],center=true);
      cylinder(d=7,h=14,center=true,$fn=100);
      }
  }
}

module windvane_base(){
      
   center_bolt_diameter = 3;
   center_bolt_len = 30;
    
  /* Stand */ 
  
  difference(){
  union(){
  cylinder(d=stand_outer,h=stand_height,center=false,$fn=100);
  }
  translate([0,0,stand_height-4.8]) 
  cylinder(d=stand_outer-6,h=5,center=false,$fn=100);
  translate([0,0,-10])
  cylinder(d=bearing_inner+0.7,h=100,center=false,$fn=100);
  translate([0,0,0]) 
  cylinder(d=bearing_outer-2,h=bearing_height+3,center=false,$fn=100);
  translate([0,0,-3])
  cylinder(d=bearing_outer+0.4,h=bearing_height+4,center=false,$fn=100);  
  }
}

module windvane_head(preview=false)
{
 difference(){   
 union(){   
   difference(){
    union(){
        rotate([0,180,0])
        translate([0,0,-head_height+3])
        chamfer_cylinder(d=stand_outer,h=head_height);
        arrow();
    }
    translate([0,0,10])
    cylinder(d=stand_outer+2,h=5,center=false,$fn=100);
    //translate([0,0,-1.5])
    //cylinder(d=bearing_outer-3,h=2,center=false,$fn=60);
   } 
  
  translate([0,0,10])
  cylinder(d=stand_outer-8,h=5,center=false,$fn=100);
  translate([0,0,15])
  cylinder(d=bearing_inner-0.5,h=10.2,center=false,$fn=100);

 }
  cylinder(d=2.5,h=80,center=false,$fn=100);
  }
  
  if(preview)
  {
    color([0.8,0.8,0.8])
    rotate([90,0,180])
    translate([10,-20,0])
    polygon(points=[[0,0],[40,0],[60,40],[30,40]]);
  }
  
}

if (model == "anemometer_base")
    anemometer_base();
else if (model == "anemometer_head")
    anemometer_head();
else if (model == "anemometer_head")
    anemometer_head();
else if (model == "anemometer_cup")
    anemometer_cup();
else if (model == "windvane_head")
    windvane_head();
else if (model == "windvane_base")
    windvane_base();




