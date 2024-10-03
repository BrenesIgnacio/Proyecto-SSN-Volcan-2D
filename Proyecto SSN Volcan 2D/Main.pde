VolcanoSimulation simulation;
ParticleSystem system;
void setup() {
  size(800, 600);
  //simulation = new VolcanoSimulation();
  //simulation.setup();
  system = new ParticleSystem(10,"basaltic");
}

void draw() {
  background(0);
  //simulation.draw();
  //simulation.update();
  //simulation.handleControls();
  system.update();
  if (mousePressed && mouseButton == LEFT) {
    system.addParticle(mouseX, mouseY);
  }
}
