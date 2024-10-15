import java.util.Iterator;

class ParticleSystem {
  ArrayList<Particle> particles;
  float emissionRate;
  String particleType;
  PVector pos;
  float temperature;
  float mass;
  

  ParticleSystem(float emissionRate, String particleType, float x, float y, float temperature, float mass) {
    particles = new ArrayList<Particle>();
    this.emissionRate = emissionRate;
    this.particleType = particleType;
    this.pos = new PVector(x, y);
    this.temperature = temperature;
    this.mass =  mass;
  }

  void update() {
    
    emit();  
    // Actualizar las partículas existentes
    Iterator<Particle> it = particles.iterator();
    while (it.hasNext()) {
      Particle a = it.next();
      if (a.isDead()) {
        it.remove();
      } else {
        a.update();
      }      
    }

    // Resolver colisiones
    resolveCollisions();
  }

  void emit() {
    
    for (int i = 0; i < emissionRate; i++) {
      addParticle();
    
    } 
  }

  void draw() {
    update();
    for (Particle p : particles) {
      if(p.position.y < 300){
       
        p.addGravity(new PVector(0, 0.001));  // Simula la gravedad
        p.applyDrag(0.01);
        float dispersionFactor = random(0.5, 1.5); // Factor aleatorio de dispersión
        p.velocity.add(new PVector(random(-1, 1) * dispersionFactor  * 2, -dispersionFactor)); // Desplazar hacia afuera
      }else{
        p.addGravity(new PVector(0, 0.6));  // Simula la gravedad
        p.applyDrag(1.5);                  // Simula la resistencia del aire
      }
      
      p.draw();
    }
  }
  
  void addParticle() {
    PVector pos_p = new PVector(pos.x, pos.y); // Posición de emisión (cerca del cráter)
    
    // Velocidad de caída inicial hacia abajo, con algo de aleatoriedad
    PVector vel = new PVector(random(-0.5, 0.5), random(0.5, 2));
    
    if (particleType != "basaltic") {
      temperature = 1500;
    }
    
    // Añadir la nueva partícula al sistema
    particles.add(new Particle(pos_p, vel, mass, temperature, this.particleType));
  }

 void resolveCollisions() {
    // Recorre todas las partículas y verifica colisiones
    for (int i = 0; i < particles.size(); i++) {
      Particle p1 = particles.get(i);
      for (int j = i + 1; j < particles.size(); j++) {  
        Particle p2 = particles.get(j);
        if (p1.checkCollision(p2)) {
          // Resolución de la colisión
          PVector dir = PVector.sub(p1.position, p2.position);
          dir.normalize();
          float overlap = max((p1.d / 2 + p2.d / 2) - PVector.dist(p1.position, p2.position), 0);
          //float overlap = (p1.d / 2 + p2.d / 2) - PVector.dist(p1.position, p2.position);
          p1.position.add(dir.mult(overlap / 2.2));  // Mueve p1 en la dirección del choque
          p2.position.sub(dir.mult(overlap / 2.2));  // Mueve p2 en la dirección opuesta
          
          // Amortiguar la velocidad de las partículas al colisionar
          p1.velocity.mult(0.1);
          p2.velocity.mult(0.1);
          
          float maxSpeed = 1.5;
          p1.velocity.limit(maxSpeed);
          p2.velocity.limit(maxSpeed);
        }
      }
    }
 }

}
