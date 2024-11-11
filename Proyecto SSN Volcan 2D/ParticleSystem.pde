import java.util.ArrayList;
import java.util.Iterator;
import java.util.Stack;
import java.util.concurrent.ConcurrentLinkedDeque;

class ParticleSystem {
  ArrayList<Particle> particles;
  float emissionRate;
  String particleType;
  PVector pos;
  ParticlePool particlePool;
  int framesBetweenEmissions = 3; // Espaciar la emisión de partículas
  float countParticles;
  boolean cond = false;
  float limit = 415;
  int frameCounter = 0; // Variable para contar los frames
  float drag = 4;
  
  ParticleSystem(float emissionRate, String particleType, float x, float y) {
    particles = new ArrayList<>();
    this.emissionRate = emissionRate;
    this.particleType = particleType;
    this.pos = new PVector(x, y);
    this.particlePool = new ParticlePool(); // Inicializar el pool de partículas
  }

  void update() {
    // Emisión en intervalos para reducir la carga
    frameCounter++;
    if (frameCounter % framesBetweenEmissions == 0) {
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

    // Resolver colisiones usando una cuadrícula espacial si el tipo es "lava"
    if (particleType.equals("lava") ) resolveCollisions();
  }

  void emit() {
    for (int i = 0; i < emissionRate; i++) {
      addParticle();
    }
  }

  void draw() {
    update();
    for (Particle p : particles) {
      if (particleType.equals("lava")) {
        if (p.position.y < limit) {
          cond = true;
          p.addGravity(new PVector(0, 0.8)); // Simula la gravedad
          p.applyDrag(1.2);
          float dispersionFactor = random(-2, 3); // Factor de dispersión
          p.velocity.add(new PVector(random(-1, 1) * dispersionFactor * 2, -dispersionFactor));
        }
        p.draw();
      } else if (particleType.equals("lavaOut")) {
        p.addGravity(new PVector(0, 0.7));
        p.applyDrag(drag);
        p.applyFriction(2.5);
        p.draw();
      } else if (particleType.equals("ceniza")) {
        p.addGravity(new PVector(0, 0.001));
        p.applyDrag(0.01);
        float dispersionFactor = random(-2, 3); // Factor de dispersión
        p.velocity.add(new PVector(random(-1, 1) * dispersionFactor * 2, -dispersionFactor));
        
        //p.velocity.y *= -1;
        p.draw();
      }
    }
  }

  void setDrag(float f) {
    this.drag = f;
  }
  
  void setEmissionRate(float num){
    this.emissionRate = num;
  }

  void addParticle() {
    PVector pos_p = new PVector(pos.x, pos.y);
    PVector vel = new PVector(random(-0.5, 0.5), -10);
    float temp = 0;
    if (particleType.equals("lava")){
      temp = 2500;
    }else if(particleType.equals("lavaOut")){
      temp = 1500;
    }else if(particleType.equals("ceniza")){
      temp = 1000;
    
    }
    
    

    // Obtener una partícula del pool en lugar de crear una nueva
    Particle newParticle = particlePool.getParticle(pos_p, vel, 9, temp, particleType);
    particles.add(newParticle);
  }

  void resolveCollisions() {
    SpatialGrid grid = new SpatialGrid(width, height, 50); // Tamaño de celda 50
    for (Particle p : particles) {
      grid.insert(p);
    }

    for (Particle p1 : particles) {
      ArrayList<Particle> neighbors = grid.getNeighbors(p1);
      for (Particle p2 : neighbors) {
        if (p1 != p2 && p1.checkCollision(p2)) {
          PVector dir = PVector.sub(p1.position, p2.position).normalize();
          float overlap = Math.max((p1.d / 2 + p2.d / 2) - PVector.dist(p1.position, p2.position), 0);
          p1.position.add(dir.mult(overlap / 1.8));
          p2.position.sub(dir.mult(overlap / 1.8));
          p1.velocity.mult(0.1);
          p2.velocity.mult(0.1);
          p1.velocity.limit(0.5);
          p2.velocity.limit(0.5);
        }
      }
    }
  }

  boolean level(float num) {
    for (Particle p : particles) {
      if (p.position.y < num) {
        return true;
      }
    }
    return false;
  }
}

class ParticlePool {
  private ConcurrentLinkedDeque<Particle> pool = new ConcurrentLinkedDeque<>();

  Particle getParticle(PVector pos, PVector vel, float d, float temp, String type) {
    Particle p;
    if (pool.isEmpty()) {
      p = new Particle(pos, vel, d, temp, type);
    } else {
      p = pool.pop();
      p.reset(pos, vel, d, temp, type);
    }
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
    this.cols = (int) Math.ceil(width / cellSize);
    this.rows = (int) Math.ceil(height / cellSize);
    cells = new ArrayList<>(cols * rows);
    for (int i = 0; i < cols * rows; i++) {
      cells.add(new ArrayList<>());
    }
  }

  void insert(Particle p) {
    int x = (int) (p.position.x / cellSize);
    int y = (int) (p.position.y / cellSize);
    int index = x + y * cols;
    if (x >= 0 && x < cols && y >= 0 && y < rows && index < cells.size()) {
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
