class Particle {
  PVector position;
  PVector velocity;
  float temperature;
  float d;
  PVector acc;
  float mass;
  String type;
  //float solidificationTemp;
  float damp = 0.001;
  float top = 415;
  

  Particle(PVector position, PVector velocity, float mass, float temperature, String type) {
    this.position = position;
    this.velocity = velocity;
    this.temperature = temperature;
    this.acc = new PVector(0, 0);
    this.mass = mass;
    this.d = 4 * sqrt(mass / PI);
    this.type = type;
    
    
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
    
    
  }

  void update() {
    velocity.add(acc);
    position.add(velocity);
    acc.mult(0);
    velocity.limit(2);
    if(type == "lava"){
      
      if (position.y > top) {
        borders();
        mass -= 0.003;
      } else {
        mass -= 0.02;
        
      }
    }else if(type == "lavaOut"){
      mass -= 0.003;
    
    }else if (type == "ceniza"){
      mass -=0.01;
    }
    
    
    
  } 
  
  void borders() {
    float minX = 385;
    float maxX = 415;
    
    if (position.y > top){
      if (position.x <  minX + d / 2) {
        position.x = minX + d / 2; 
        velocity.x *= -damp; 
      } else if (position.x > maxX + d / 2) {
        position.x = maxX - d / 2; 
        velocity.x *= -damp;  
      }
      
      /*if (position.y < d / 2) {
        position.y = d / 2; 
        velocity.y *= -damp; 
      } else if (position.y > height - d / 2) {
        position.y = height - d / 2; 
        velocity.y *= -damp;  
      }*/
    }
    
  }

  void draw() {
    blendMode(BLEND);
     
    color hotColor = color(255, 0, 0);      // Color rojo caliente
    color warmColor = color(255, 165, 0);   // Color naranja cálido
    color coolColor = color(50, 50, 50);   // Color gris frío
    
    // Solo se aplica el color si está por debajo del umbral del cráter
    if(type == "lava"){
    // Colores solo aplicables cuando la partícula está en la parte superior
      if (position.y > top){
        float coolingFactor = map(position.y, 100, 900, 0, 1);  
        color currentColor;
        currentColor = lerpColor(hotColor, warmColor, map(coolingFactor, 0.5, 1, 0, 1));
        fill(currentColor, max(0, temperature));
      }
    } else if(type == "lavaOut" ){
      //float inter = map(i, 0, width, 0, 1);  // Interpolación entre 0 y 1
      //color currentColor = lerpColor(hotColor, warmColor, inter);  // Gradiente entre los colores
      fill(color(255, 140, 0), max(0, temperature));
    }else if (type == "ceniza"){
      fill(coolColor, max(0, temperature));
    }
    
    
    noStroke();
    ellipse(position.x, position.y, d, d);  // Dibuja la partícula
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

    
  

  
  
