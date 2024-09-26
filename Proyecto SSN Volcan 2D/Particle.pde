class Particle {
  PVector position;
  PVector velocity;
  float temperature;
  color particleColor;

  Particle(PVector position, PVector velocity, float temperature, color particleColor) {
    this.position = position;
    this.velocity = velocity;
    this.temperature = temperature;
    this.particleColor = particleColor;
  }

  void update() {
    // logica
  }

  void draw() {
    // logica
  }
}
