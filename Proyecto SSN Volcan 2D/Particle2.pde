import java.util.Queue;
import java.util.LinkedList;
import java.util.List;
import java.util.ArrayList;
import java.util.Collections;




class Particle2 {
  PVector pos;
  PVector vel;
  PVector acc;
  color c;
  float maxSpeed;
  float mass;
  float massLost;
  char type;
  Queue<PVector> part_tail;
  
  
  Particle2(float x, float y , color c, PVector vel,char type){
    this.pos = new PVector(x, y);
    this.c = c;
    this.vel = vel;
    this.acc = new PVector(0, 0);
    this.maxSpeed =random(2.8,3.5);
    this.mass = 9;
    this.massLost = 0.04;
    this.type = type;
    part_tail = new LinkedList<>();
   
  }
  
  float r(float m){
    float num = 4 * sqrt(m / PI);
    return  num;
  }
  
  boolean isDead(){
    return mass <= 0;
  }
  
  void display(){
    List<PVector> part_tail_inv = new ArrayList<>(part_tail);
    float mass_tail = this.mass;
    Collections.reverse(part_tail_inv);
    
    for (PVector ele : part_tail_inv){
       noStroke();
       fill(this.c, map(mass_tail, 0, this.mass, 0, 255));
       
       
       float r = r(mass_tail); 
       ellipse(ele.x, ele.y, r, r);
       
       if(type == 'r'){
         mass_tail -= 0.3 ;
       }else{
         
         mass_tail *= 0.9;
        
         
       }
       
       
       
       
    }
    
     
  }
  
  void update(){
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
    vel.limit(maxSpeed);
    if(type == 'p'){
      mass -= 0.08;
    }
    mass -= massLost * vel.mag() * 0.1;
    if(part_tail.size() == 20){
      part_tail.poll();
    }
    part_tail.add(pos.copy());
  }
  
  void applyForce(PVector f) {
    PVector dif = f.copy();
    dif.div(mass);
    acc.add(dif);
  }
  
  void applyGravity(PVector g) {
    acc.add(g);
  }
  void applyFriction(float m) {
    PVector fric = vel.copy();
    fric.normalize();
    fric.mult(-m);
    applyForce(fric);
  }
  void applyDrag(float d) {
    PVector drag = vel.copy();
    drag.normalize();
    drag.mult(pow(vel.mag(), 2));
    drag.mult(-d);
    applyForce(drag);
  }

}
