VolcanoSimulation simulation;
ParticleSystem system0;
ParticleSystem system1;
ParticleSystem system2;
ParticleSystem system3;
ControlPanel controlPanel;
ArrayList<Attractor> fixedAgents;
float height_l;
float temperature;
Crater crater;

ArrayList<FireworkSystem> fireworks = new ArrayList<FireworkSystem>();
boolean condi = true;

float i;
void setup() {
  size(800, 900);
  
  simulation = new VolcanoSimulation();
  simulation.setup();
  controlPanel = new ControlPanel(this);
  controlPanel.setup();
  
  //Sistemas de particulas
  system0 = new ParticleSystem(20, "lava", 400, 890);
  system1 = new ParticleSystem(20, "lavaOut", 320, 400);
  system2 = new ParticleSystem(20, "lavaOut", 480, 400);
  system3 = new ParticleSystem(10, "ceniza", 400, 410);//
  
  //Repeledores de lava
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
  
   
   height_l = 0.01;
   temperature = 2000;
   crater = new CraterMag(new PVector(400, 405), 80);
   
  
}

void draw() {
  background(135, 206, 235);
  simulation.draw();
  simulation.update();
  simulation.handleControls();
  
  
  if(system0.cond == true){
    system0.particles.clear();
    crater.draw();
    system1.draw();
    system2.draw();
    system3.draw();
    
  }else{
    system0.draw();
  }
  
  
  
  
  
  for (Attractor a : fixedAgents) {
    //a.draw();
    a.attract(system1); // Utiliza la función de atracción que ahora será repulsión
    a.attract(system2);
  }

  
  
  if(system0.level(890- height_l)){
    if(height_l < 200){
      height_l += 0.3;
    }else{
      height_l += 0.5;
    }
     
    
    
  }
  
  
  
   // Colores para el gradiente
  color hotColor = color(255, 0, 0);      // Color rojo caliente
  color warmColor = color(255, 165, 0);   // Color naranja cálido
  color coolColor = color(50, 50, 50);    // Rojo oscuro
  
  // Dibujar el rectángulo con gradiente basado en la altura
  for (int i = 0; i < height_l; i++) {
    // Calcular el factor de enfriamiento en función de la altura
    float coolingFactor = map(890 -i, 100, 900, 0, 1);  
    color currentColor;
    currentColor = lerpColor(hotColor, warmColor, map(coolingFactor, 0.5, 1, 0, 1));
    fill(currentColor, max(0, temperature));
    
    // Dibujar el segmento del rectángulo
    fill(currentColor);
    noStroke();
    rect(400 - 55/2 , 900 - i, 55, 1);
    }

   

  controlPanel.draw();
  
    
   //Proyectiles
  for(FireworkSystem firework: fireworks){
    firework.update();
    firework.display();

  }
    
    
  
}



void keyPressed() {
    float drag = controlPanel.getVelocity();
    float em = controlPanel.getgasEmission();
    
    
    if(keyPressed && key == '1'){system1.setDrag(drag);}
    if(keyPressed && key == '2'){system2.setDrag(drag);}
    if(keyPressed && key == '3'){system3.setEmissionRate(em);}
    if (keyPressed && key == '4' && system0.cond == true) {
      FireworkSystem firework = new FireworkSystem();
      firework.launchRocket();  
      fireworks.add(firework);  
     
    }

}
