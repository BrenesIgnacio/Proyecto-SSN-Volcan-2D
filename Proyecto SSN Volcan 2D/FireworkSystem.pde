import java.util.Iterator;

class FireworkSystem{
  PVector g; 
  ArrayList<Particle2> particles;
  Rocket system;
  
  
  FireworkSystem(){
    g = new PVector(0,0.03);
    particles = new ArrayList<Particle2>();
    
    
  }
  
  void display(){
    
      
     if (system != null && !system.isDead()) {
        
        system.display();
      } else {
        for (Particle2 p : particles) {
            
            p.display();
        }
      }
  }
  void update(){
    if (system != null) {
      
      system.applyGravity(g);
      system.applyDrag(0.001);
      system.update();
      
      if (system.isDead()) {
          addExplosion(); 
          system = null;
      }
    } else {
        Iterator<Particle2> it = particles.iterator();
        while (it.hasNext()) {
            Particle2 p = it.next();
            if (p.isDead()) {
                it.remove();
            } else {
                p.applyGravity(g);
                p.applyDrag(0.08);
                p.update();
            }
        }
    }
        
    
  }
  
  void addExplosion(){
    if (system != null) { 
      int i = 0;
      PVector vel_p;
      color cp = color(230, 69, 0);
      while (i < system.nParticles) {
          vel_p = PVector.random2D();
          float mag = (float) (randomGaussian() * system.forceDev + system.forceMid);
          vel_p.setMag(mag);
          particles.add(new Particle2(system.pos.x, system.pos.y, cp, vel_p,'p'));
          i++;
      }
    }
  }
  
  void launchRocket(){
    PVector vel = new PVector(random(-15,15), -20);
    vel.setMag(80);
    system = new Rocket(400, 500 ,vel,30,2,4,this);
    particles.clear();
  }
}
