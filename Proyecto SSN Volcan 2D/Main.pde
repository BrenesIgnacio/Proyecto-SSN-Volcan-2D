VolcanoSimulation simulation;

void setup() {
  size(800, 600);
  simulation = new VolcanoSimulation();
  simulation.setup();
}

void draw() {
  background(255);
  simulation.draw();
  simulation.update();
  simulation.handleControls();
}
