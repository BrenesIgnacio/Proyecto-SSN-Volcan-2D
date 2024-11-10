class Repeller extends Attractor {
  Repeller(float x, float y, float mass,float r) {
    super(x, y, mass,r);
    G *= -0.1;
  }
  void repel(ParticleSystem system) {
    attract(system);
  }
}
