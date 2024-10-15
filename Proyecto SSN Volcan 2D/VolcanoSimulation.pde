class VolcanoSimulation {
  Volcano volcano;
  ParticleSystem lavaSystem;
  ParticleSystem gasSystem;
  ControlPanel controls;

  void setup() {
    // logica
    volcano = new Volcano();
    //lavaSystem = new ParticleSystem(10, "lava");  // valores de relleno
    //gasSystem = new ParticleSystem(5, "gas");    // valores de relleno
    controls = new ControlPanel();
  }

  void draw() {
    volcano.draw();
    //lavaSystem.draw();
    //gasSystem.draw();
    controls.draw();
  }

  void update() {
    //lavaSystem.update();
    //gasSystem.update();
  }

  void handleControls() {
    controls.handleInput();
  }
}
