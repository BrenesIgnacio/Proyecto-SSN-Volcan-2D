VolcanoSimulation simulation;
ArrayList<ParticleSystem> system;
ControlPanel controlPanel;
float i;
void setup() {
  int x = 800, y = 900;
  size(800, 900);
  
  simulation = new VolcanoSimulation();
  simulation.setup();
  
  system = new ArrayList();
  
  controlPanel = new ControlPanel(this);
  controlPanel.setup();

  float defaultTemp = 0;
  float defaultMass = 0;
  
  system.add(new ParticleSystem(20, "basaltic",400, 590));
  i = 0;
}


void draw() {
  background(135, 206, 235);
  if (system.get(0).cond && i == 0){
      system.add(new ParticleSystem(20, "basaltic",400, 150));
      i = 1;
  }
  simulation.draw();
  simulation.update();
  simulation.handleControls();

  if (controlPanel.slider1 != null && controlPanel.slider2 != null) {
    float XX = controlPanel.getTemperature();
    float YY = controlPanel.getMass();

    for (ParticleSystem p : system) {
      //p.temperature = XX;
      //p.mass = YY;
      
      p.setControlValues(XX,YY);
      p.draw();
    }
    
    
    
  }

  controlPanel.draw();
}
