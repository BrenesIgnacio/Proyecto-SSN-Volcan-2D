class Volcano {
  Crater crater;
  Vent vent;
  MagmaChamber magmaChamber;
  RockLayers rockLayers;

  void draw() {
    crater.draw();
    vent.draw();
    magmaChamber.draw();
    rockLayers.draw();
  }
}
