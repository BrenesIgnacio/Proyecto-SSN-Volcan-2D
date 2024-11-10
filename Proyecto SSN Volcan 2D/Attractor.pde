class Attractor extends Particle {
  float G;
  float radius; // Nuevo: radio de influencia
  Attractor(float x, float y, float mass, float r) {
    // Llamada al constructor de la clase padre Particle
    super(new PVector(x, y), new PVector(0, 0), mass, 1500, "lava"); 
    this.G = 1; // Constante de gravedad
    this.radius = r;
  }

  void update() {
    // Método update vacío si no hay necesidad de actualizar algo en el Attractor directamente.
  }

  void attract(ParticleSystem system) {
    for (Particle a : system.particles) {
      if (this != a) { // Evita la auto-atracción
        // Calcula la fuerza de atracción
        PVector r = PVector.sub(position, a.position); // Vector de distancia
        float distance = r.mag(); 
        if (distance <= radius) {
          float d2 = constrain(r.magSq(), 2, 50000); // Limita la distancia al rango especificado
          r.normalize();
          r.mult(G * mass * a.mass / d2); // Calcula la fuerza gravitacional
          a.addForce(r); // Aplica la fuerza a la partícula
        }
      }
    }
  }
}
