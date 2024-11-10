VolcanoSimulation simulation;
ParticleSystem system0;
ParticleSystem system1;
ParticleSystem system2;
ControlPanel controlPanel;
ArrayList<Attractor> fixedAgents;


float i;
void setup() {
  size(800, 900);
  
  simulation = new VolcanoSimulation();
  simulation.setup();
  controlPanel = new ControlPanel(this);
  controlPanel.setup();
  system0 = new ParticleSystem(20, "lava", 400, 890);
  system1 = new ParticleSystem(20, "lavaOut", 320, 400);
  system2 = new ParticleSystem(20, "lavaOut", 480, 400);
  fixedAgents = new ArrayList();
  fixedAgents.add(new Repeller(220, 800, 30, 70));
  fixedAgents.add(new Repeller(210, 720, 30, 70));
  fixedAgents.add(new Repeller(220, 720, 40, 70));
  fixedAgents.add(new Repeller(230, 720, 40, 70));
  
  fixedAgents.add(new Repeller(210, 760, 40, 70));
  fixedAgents.add(new Repeller(215, 760, 40, 70));
  
  fixedAgents.add(new Repeller(205, 800, 30, 70));
  fixedAgents.add(new Repeller(200, 810, 30, 70));
  fixedAgents.add(new Repeller(195, 820, 30, 70));
  
  fixedAgents.add(new Repeller(220, 800, 30, 70));
  fixedAgents.add(new Repeller(225, 810, 30, 70));
  fixedAgents.add(new Repeller(230, 820, 30, 70));
  
  fixedAgents.add(new Repeller(580, 720, 50, 70));
  fixedAgents.add(new Repeller(580, 760, 50, 70));
  fixedAgents.add(new Repeller(585, 760, 50, 70));
  fixedAgents.add(new Repeller(590, 760, 50, 70));
  fixedAgents.add(new Repeller(575, 800, 50, 70));
  fixedAgents.add(new Repeller(570, 840, 50, 70));
  fixedAgents.add(new Repeller(595, 840, 50, 70));
  fixedAgents.add(new Repeller(565, 880, 50, 70));
  
  // Añadir repulsores en cada capa de roca
  
  for (PVector pos : simulation.volcano.getCornerRepellers()) {
    
    Repeller repeller = new Repeller(pos.x, pos.y, 30, 100);
    fixedAgents.add(repeller);
  }
}

void draw() {
  background(135, 206, 235);
  simulation.draw();
  simulation.update();
  simulation.handleControls();

  system0.draw();
  if(system0.cond){
    system1.draw();
    system2.draw();
  }
  for (Attractor a : fixedAgents) {
    //a.draw();
    a.attract(system1); // Utiliza la función de atracción que ahora será repulsión
    a.attract(system2);
  }

  if (controlPanel.slider1 != null && controlPanel.slider2 != null) {
    float XX = controlPanel.getTemperature();
    float YY = controlPanel.getMass();
  }

  controlPanel.draw();
}
