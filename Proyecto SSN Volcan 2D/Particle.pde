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

  Particle(PVector position, PVector velocity,float mass, float temperature, String type) {
    this.position = position;
    this.velocity = velocity;
    this.temperature = temperature;
    this.acc = new PVector(0, 0);
    this.mass = mass;
    this.d = 4 * sqrt(mass / PI);
    //this.d = 20;
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
    velocity.limit(3);
    //temperature -= 1; // Disminuir la temperatura
    /*
    if (temperature <= solidificationTemp) {
        if (type == "basaltic") {
            mass -= 0.03; // Reducción de masa para lava basáltica
        } else {
            mass -= 0.05; // Reducción de masa para otros tipos
        }
    }*/
    
    if(position.y > 300){
      borders();
      mass -= 0.003;
    }else{
      mass -= 0.4;
    }
    
  } 
  
  void borders() {
      float minX = 300;  
      float maxX = width - 300;  
      
      // Verificar colisiones con los límites en X
      if (position.x < minX + d / 2) {
          position.x = minX + d / 2; 
          velocity.x *= -damp; 
      } else if (position.x > maxX - d / 2) {
          position.x = maxX - d / 2; 
          velocity.x *= -damp;  
      }
      
      // Verificar colisiones con los límites en Y
      if (position.y < d / 2) {
          position.y = d / 2; 
          velocity.y *= -damp; 
      } else if (position.y > height - d / 2) {
          position.y = height - d / 2; 
          velocity.y *= -damp;  
      }
  }

   
  void draw() {
    // Establecer el modo de mezcla
    blendMode(BLEND);  // Cambiar a BLEND para evitar brillo excesivo

   
    color hotColor = color(255, 0, 0);     // Rojo brillante (lava caliente)
    color warmColor = color(255, 165, 0);  // Naranja (lava tibia)
    color coolColor = color(50, 50, 50);   // Gris oscuro (lava fría)
  
    // Determinar el rango de altura en el cual la lava comienza a enfriarse
    float craterHeight = height * 0.04;  
    

   
    float coolingFactor = map(position.y, craterHeight , height, 0, 1);  // 1: caliente, 0: fría
  
 
    color currentColor;
    if (coolingFactor > 0.5) {
        currentColor = lerpColor(hotColor, warmColor, map(coolingFactor, 0.5, 1, 0, 1));  // Transición de rojo a naranja
    } else {
        currentColor = lerpColor(warmColor, coolColor, map(coolingFactor, 0, 0.5, 0, 1));  // Transición de naranja a gris
    }
  
    // Establecer alpha basado en la temperatura
    if (position.y <300){
      fill(coolColor,max(0, temperature));
    }else{
      fill(currentColor, max(0, temperature)); 
    }
    
    noStroke();
    ellipse(position.x, position.y, d, d);
  
    // Enfriar la partícula si está más cerca del cráter (parte superior de la pantalla)
    /*if (position.y < 300) {
        temperature = max(0, temperature - 5);  // Reducir la temperatura sin que sea negativa
    }*/
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
  
  boolean checkCollision(Particle other) {
    float dist = PVector.dist(this.position, other.position);
    return dist < (this.d / 2 + other.d / 2);  // Detecta colisión si las partículas están demasiado cerca
  }

  
 
}  
    
  

  
  
