class VolcanoSimulation {
  Volcano volcano;
  ParticleSystem lavaSystem;
  ParticleSystem gasSystem;
  ControlPanel controls;

  void setup() {
    // logica
  }

  void draw() {
    volcano.draw();
    lavaSystem.draw();
    gasSystem.draw();
    controls.draw();
  }

  void update() {
    lavaSystem.update();
    gasSystem.update();
  }

  void handleControls() {
    controls.handleInput();
  }
}
