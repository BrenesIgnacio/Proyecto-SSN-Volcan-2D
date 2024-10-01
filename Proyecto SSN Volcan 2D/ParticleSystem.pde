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
    // logica
  }

  void emit() {
    // logica
  }

  void draw() {
    //logica
  }
}
