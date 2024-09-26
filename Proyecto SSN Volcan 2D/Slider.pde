class Slider {
  float min;
  float max;
  float value;

  Slider(float min, float max) {
    this.min = min;
    this.max = max;
    this.value = (max - min) / 2;
  }

  void draw() {
    // logica
  }
}
