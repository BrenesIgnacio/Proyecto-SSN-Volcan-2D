class Particle {
  PVector position;
  PVector velocity;
  float temperature;
  float d;
  PVector acc;
  float mass;
  String type;
  float solidificationTemp;
  float damp = 0.001;

  Particle(PVector position, PVector velocity, float mass, float temperature, String type) {
    this.position = position;
    this.velocity = velocity;
    this.temperature = temperature;
    this.acc = new PVector(0, 0);
    this.mass = mass;
    this.d = 4 * sqrt(mass / PI);
    this.type = type;
    
    if (type.equals("basaltic")) {
      solidificationTemp = 1200;
    } else {
      solidificationTemp = 800;
    }
  }

  // Método para reiniciar la partícula y prepararla para reutilización
  void reset(PVector position, PVector velocity, float mass, float temperature, String type) {
    this.position.set(position);
    this.velocity.set(velocity);
    this.temperature = temperature;
    this.acc.set(0, 0);
    this.mass = mass;
    this.d = 4 * sqrt(mass / PI);
    this.type = type;
    
    if (type.equals("basaltic")) {
      solidificationTemp = 1200;
    } else {
      solidificationTemp = 800;
    }
  }

  void update() {
    velocity.add(acc);
    position.add(velocity);
    acc.mult(0);
    velocity.limit(3);
    
    if (position.y > 300) {
      borders();
      mass -= 0.003;
    } else {
      mass -= 0.4;
    }
  } 
  
  void borders() {
    float minX = 370;
    float maxX = width - 370;
    if (position.y > 300){
      if (position.x < minX + d / 2) {
      position.x = minX + d / 2; 
      velocity.x *= -damp; 
      } else if (position.x > maxX - d / 2) {
        position.x = maxX - d / 2; 
        velocity.x *= -damp;  
      }
      
      if (position.y < d / 2) {
        position.y = d / 2; 
        velocity.y *= -damp; 
      } else if (position.y > height - d / 2) {
        position.y = height - d / 2; 
        velocity.y *= -damp;  
      }
    }
    
  }

  void draw() {
    blendMode(BLEND);

    color hotColor = color(255, 0, 0);     
    color warmColor = color(255, 165, 0);  
    color coolColor = color(50, 50, 50);
    
    float craterHeight = height * 0.04;
    float coolingFactor = map(position.y, craterHeight, height, 0, 1);  
  
    color currentColor;
    if (coolingFactor > 0.5) {
      currentColor = lerpColor(hotColor, warmColor, map(coolingFactor, 0.5, 1, 0, 1));
    } else {
      currentColor = lerpColor(warmColor, coolColor, map(coolingFactor, 0, 0.5, 0, 1));
    }

    if (position.y < 300) {
      fill(coolColor, max(0, temperature));
    } else {
      fill(currentColor, max(0, temperature)); 
    }
    
    noStroke();
    ellipse(position.x, position.y, d, d);
  }

  boolean isDead() {
    return mass <= 0;
  }

  void addForce(PVector f) {
    PVector force = f.copy();
    force.div(mass);
    acc.add(force);
  }

  void addGravity(PVector g) {
    acc.add(g);
  }

  void applyFriction(float m) {
    PVector friction = velocity.copy();
    friction.normalize();
    friction.mult(-m);
    addForce(friction);
  }

  void applyDrag(float d) {
    PVector drag = velocity.copy();
    drag.normalize();
    drag.mult(pow(velocity.mag(), 2));
    drag.mult(-d);
    addForce(drag);
  }

  boolean checkCollision(Particle other) {
    float distance = PVector.dist(this.position, other.position);
    return distance < (this.d / 2 + other.d / 2);
  }
}

    
  

  
  
