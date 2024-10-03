class ParticleSystem {
  ArrayList<Particle> particles;
  float emissionRate;
  String particleType;

  ParticleSystem(float emissionRate, String particleType) {
    particles = new ArrayList<Particle>();
    this.emissionRate = emissionRate;
    this.particleType = particleType;
  }

  void update() {
    for (Particle p : particles) {
      p.draw();
      p.update();
    }
  }

  void emit() {
    // logica
  }

  void draw() {
    for (Particle p : particles) {
      p.draw();
    }
  }
  
  void addParticle(float x, float y) {
    PVector pos_p = new PVector(x,y);
    PVector vel = PVector.random2D(); 
    vel.setMag(random(0,5));
    float temp;
    if(particleType == "basaltic"){
      temp = 2000;
    }else{
      temp = 1500;
    }
    particles.add(new Particle(pos_p, vel,random(1,5),temp,this.particleType));
    
  }
  
  
}
