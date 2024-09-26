class Volcano {
  Crater crater;
  Vent vent;
  MagmaChamber magmaChamber;
  RockLayers rockLayers;
  VolcanicPipe volcanicPipe;

  void draw() {
    crater.draw();
    vent.draw();
    magmaChamber.draw();
    rockLayers.draw();
  }
}
