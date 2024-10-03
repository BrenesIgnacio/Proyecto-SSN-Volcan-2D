class Particle {
  PVector position;
  PVector velocity;
  float temperature;
  float d;
  PVector acc;
  float mass;
  String type;
  float solidificationTemp;

  Particle(PVector position, PVector velocity,float mass, float temperature, String type) {
    this.position = position;
    this.velocity = velocity;
    this.temperature = temperature;
    this.acc = new PVector(0, 0);
    this.mass = mass;
    this.d = 4 * sqrt(mass / PI);
    this.type = type;
    
    if (type == "basaltic") {
      solidificationTemp = 1200;
    } else {//"rhyolitic" 
      solidificationTemp = 800;
    }
    
  }

  void update() {
    velocity.add(acc);
    position.add(velocity);
    acc.mult(0);
    temperature -= 5; // Disminuir la temperatura

    if (temperature <= solidificationTemp) {
        if (type == "basaltic") {
            mass -= 0.03; // Reducción de masa para lava basáltica
        } else {
            mass -= 0.05; // Reducción de masa para otros tipos
        }
    }
  } 
   
  void draw() {
    fill(255, 0, 0, temperature); 
    noStroke();
    ellipse(position.x, position.y, d, d); 
  }
  
  boolean isDead(){
    return mass <= 0;
  }
  
  void addForce(PVector f) {
    PVector dif = f.copy();
    dif.div(mass);
    acc.add(dif);
  }
  void addGravity(PVector g) {
    acc.add(g);
  }
  void applyFriction(float m) {
    PVector fric = velocity.copy();
    fric.normalize();
    fric.mult(-m);
    addForce(fric);
  }
  void applyDrag(float d) {
    PVector drag = velocity.copy();
    drag.normalize();
    drag.mult(pow(velocity.mag(), 2));
    drag.mult(-d);
    addForce(drag);
  }
  
 
}  
    
  

  
  
