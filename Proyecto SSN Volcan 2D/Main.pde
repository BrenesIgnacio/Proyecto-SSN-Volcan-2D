VolcanoSimulation simulation;
ArrayList<ParticleSystem> system;
void setup() {
  int x, y;
  x = 800;
  y = 600;
  size(800, 600);
  simulation = new VolcanoSimulation();
  simulation.setup();
  system = new ArrayList();
  system.add(new ParticleSystem(10, "basaltic",x/2, y/8));
}

void draw() {
  background(135, 206, 235);
  simulation.draw();
  simulation.update();
  simulation.handleControls();
  for(ParticleSystem p: system){
    p.draw();
  }
  
  

}
