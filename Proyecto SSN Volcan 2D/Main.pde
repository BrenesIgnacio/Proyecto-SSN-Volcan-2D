VolcanoSimulation simulation;
ArrayList<ParticleSystem> system;
ControlPanel controlPanel;

void setup() {
  int x = 800, y = 600;
  size(800, 600);
  
  simulation = new VolcanoSimulation();
  simulation.setup();
  
  system = new ArrayList();

  controlPanel = new ControlPanel(this);
  controlPanel.setup();

  float defaultTemp = 0;
  float defaultMass = 0;
  
  system.add(new ParticleSystem(10, "basaltic", x/2, y/4, defaultTemp, defaultMass));
}


void draw() {
  background(135, 206, 235);

  simulation.draw();
  simulation.update();
  simulation.handleControls();

  if (controlPanel.slider1 != null && controlPanel.slider2 != null) {
    float XX = controlPanel.getTemperature();
    float YY = controlPanel.getMass();

    for (ParticleSystem p : system) {
      p.temperature = XX;
      p.mass = YY;
      p.draw();
    }
  }

  controlPanel.draw();
}
