import java.util.ArrayList;
import java.util.Iterator;
import java.util.Stack;

class ParticleSystem {
  ArrayList<Particle> particles;
  float emissionRate;
  String particleType;
  PVector pos;
  ParticlePool particlePool;
  int framesBetweenEmissions = 3; // Espaciar la emisión de partículas
  float countParticles;
  boolean cond = false; 
  


  ParticleSystem(float emissionRate, String particleType, float x, float y) {
    particles = new ArrayList<>();
    this.emissionRate = emissionRate;
    this.particleType = particleType;
    this.pos = new PVector(x, y);
    this.particlePool = new ParticlePool(); // Inicializar el pool de partículas
  }

  void update() {
    // Emisión en intervalos para reducir la carga
    if (frameCount % framesBetweenEmissions == 0) {
      emit();
    }

    // Actualizar las partículas existentes
    Iterator<Particle> it = particles.iterator();
    while (it.hasNext()) {
      Particle a = it.next();
      if (a.isDead()) {
        it.remove();
        particlePool.releaseParticle(a); // Regresar la partícula al pool
      } else {
        a.update();
      }
    }

    // Resolver colisiones usando una cuadrícula espacial
    if (particleType == "lava") resolveCollisions();
    
    
  }

  void emit() {
    for (int i = 0; i < emissionRate; i++) {
      addParticle();
    }
  }

  void draw() {
    update();
    for (Particle p : particles) {
      if (particleType == "lava"){
        if (p.position.y < 425 ) {
          cond = true;
          //p.addGravity(new PVector(0, 0.001));  // Simula la gravedad
          //p.applyDrag(0.01);
          p.addGravity(new PVector(0, 0.8));  // Simula la gravedad
          p.applyDrag(1.2);
          float dispersionFactor = random(-2, 3); // Factor de dispersión
          p.velocity.add(new PVector(random(-1, 1) * dispersionFactor * 2, -dispersionFactor));
          
          
        } else {
          p.addGravity(new PVector(0, 0.4));  
          p.applyDrag(1.5);                  
        }
        p.draw();
      }else if(particleType == "lavaOut"){
        p.addGravity(new PVector(0, 0.7));  
        p.applyDrag(2.5);
        p.applyFriction(3.4);
        p.draw();
      }
    }
    
  }
  
  void setControlValues(float temp,float mass){
    for (Particle p : particles){
      if (p.position.y < 425){
        p.temperature = temp;
        p.mass = mass;
      }
    }
  }

  void addParticle() {
    PVector pos_p = new PVector(pos.x, pos.y);
    PVector vel = new PVector(random(-0.5,0.5), -10);
    float temp;
    if(particleType == "lava"){
      temp = 2000;
    }else{
      temp = 1500;
    }

    // Obtener una partícula del pool en lugar de crear una nueva
    Particle newParticle = particlePool.getParticle(pos_p, vel, 9, temp, particleType);
    particles.add(newParticle);
  }

  void resolveCollisions() {
    // Uso de una cuadrícula simple para particionar el espacio y optimizar la detección de colisiones
    SpatialGrid grid = new SpatialGrid(width, height, 50); // Tamaño de celda 50
    for (Particle p : particles) {
      grid.insert(p);
    }

    // Revisión de colisiones entre partículas en las mismas celdas
    for (Particle p1 : particles) {
      ArrayList<Particle> neighbors = grid.getNeighbors(p1);
      for (Particle p2 : neighbors) {
        if (p1 != p2 && p1.checkCollision(p2)) {
          PVector dir = PVector.sub(p1.position, p2.position).normalize();
          float overlap = max((p1.d / 2 + p2.d / 2) - PVector.dist(p1.position, p2.position), 0);
          p1.position.add(dir.mult(overlap / 1.8));  // Mueve p1
          p2.position.sub(dir.mult(overlap / 1.8));  // Mueve p2
          p1.velocity.mult(0.1);
          p2.velocity.mult(0.1);
          p1.velocity.limit(0.5);
          p2.velocity.limit(0.5);
        }
      }
    }
  }
}

class ParticlePool {
  private Stack<Particle> pool = new Stack<>();

  Particle getParticle(PVector pos, PVector vel, float d, float temp, String type) {
    if (pool.isEmpty()) {
      return new Particle(pos, vel, d, temp, type);
    }
    Particle p = pool.pop();
    p.reset(pos, vel, d, temp, type); // Método para restablecer los valores
    return p;
  }

  void releaseParticle(Particle p) {
    pool.push(p);
  }
}

class SpatialGrid {
  ArrayList<ArrayList<Particle>> cells;
  int cols, rows;
  float cellSize;

  SpatialGrid(int width, int height, float cellSize) {
    this.cellSize = cellSize;
    this.cols = (int) ceil(width / cellSize);
    this.rows = (int) ceil(height / cellSize);
    cells = new ArrayList<>(cols * rows);
    for (int i = 0; i < cols * rows; i++) {
      cells.add(new ArrayList<>());
    }
  }

  void insert(Particle p) {
    int x = (int) (p.position.x / cellSize);
    int y = (int) (p.position.y / cellSize);
    int index = x + y * cols;
    if (index >= 0 && index < cells.size()) {
      cells.get(index).add(p);
    }
  }

  ArrayList<Particle> getNeighbors(Particle p) {
    int x = (int) (p.position.x / cellSize);
    int y = (int) (p.position.y / cellSize);
    ArrayList<Particle> neighbors = new ArrayList<>();
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        int col = x + i;
        int row = y + j;
        int index = col + row * cols;
        if (col >= 0 && col < cols && row >= 0 && row < rows && index >= 0 && index < cells.size()) {
          neighbors.addAll(cells.get(index));
        }
      }
    }
    return neighbors;
  }
}
