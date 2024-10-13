VolcanoSimulation simulation;
ArrayList<ParticleSystem> system;
void setup() {
  size(800, 600);
  //simulation = new VolcanoSimulation();
  //simulation.setup();
  system = new ArrayList();
}

void draw() {
  background(0);
  //simulation.draw();
  //simulation.update();
  //simulation.handleControls();
  for(ParticleSystem p: system){
    p.draw();
  }
  
  if (mousePressed && mouseButton == LEFT) {
    system.add(new ParticleSystem(10, "basaltic",mouseX, mouseY));
  }
}
