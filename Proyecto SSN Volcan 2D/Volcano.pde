class Volcano {
  Crater crater;
  Vent vent;
  MagmaChamber magmaChamber;
  RockLayers rockLayers;
  VolcanicPipe volcanicPipe;

  Volcano() {
    crater = new Crater(new PVector(400, 105), 80);
    vent = new Vent(new PVector(400, 98), 155);
    magmaChamber = new MagmaChamber(new PVector(400, 550), 120, 150, 1200);
    rockLayers = new RockLayers(new PVector(400, 600), 700, -500, 50);
    volcanicPipe = new VolcanicPipe(new PVector(400, 480), 35, 380);
  }

  void draw() {
    rockLayers.draw();
    vent.draw();
    volcanicPipe.draw();
    crater.draw();
    magmaChamber.draw();
  }
}
