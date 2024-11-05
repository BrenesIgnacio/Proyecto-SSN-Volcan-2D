class Volcano {
  Crater crater;
  Vent vent;
  MagmaChamber magmaChamber;
  RockLayers rockLayers;
  VolcanicPipe volcanicPipe;

Volcano() {
    crater = new Crater(new PVector(400, 405), 80);          
    vent = new Vent(new PVector(400, 398), 155);          
    magmaChamber = new MagmaChamber(new PVector(400, 850), 120, 150, 1200);  
    rockLayers = new RockLayers(new PVector(400, 900), 700, -500, 50);      
    volcanicPipe = new VolcanicPipe(new PVector(400, 780), 35, 380);         
}

  void draw() {
    rockLayers.draw();
    vent.draw();
    volcanicPipe.draw();
    crater.draw();
    magmaChamber.draw();
  }
}
