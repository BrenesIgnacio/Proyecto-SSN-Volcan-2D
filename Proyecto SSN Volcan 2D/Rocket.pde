class Rocket  extends Particle2{
  int nParticles;
  float forceMid;
  float forceDev;
  float time;
  FireworkSystem system;
 
  
  
  
  Rocket(float x, float y, PVector vel, int nParticles,
  float forceMid, float forceDev, FireworkSystem system){
    super(x, y, color(230, 69, 0), vel,'r');
    this.nParticles = nParticles;
    this.forceMid = forceMid;
    this.forceDev = forceDev;
    this.time = 13;
    this.system = system;
  }
  
  
  void update(){
    super.update();
    if (isDead()) {
        system.addExplosion();
    }
    time -= 1;
  }
  
  boolean isDead(){
    return time <= 0;
  }
  
  void applyDrag(float d) {
    PVector drag = vel.copy();
    drag.normalize();
    drag.mult(pow(vel.mag(), 2));
    drag.mult(-d);
    super.applyForce(drag);
  }
}
