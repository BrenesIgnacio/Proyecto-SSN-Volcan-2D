class CraterMag extends Crater {

  CraterMag(PVector position, float radius) {
    super(position, radius);
  }
  
  void draw() {
    colorMode(RGB);
    for (int i = 0; i < radius; i++) {
      float inter = map(i, 0, radius, 0, 1);
      int c = color(255, (int)(255 * inter), 0); // Transición de color de rojo a naranja
      fill(c);
      noStroke();
      float heightFactor = 0.5;
      ellipse(position.x, position.y, (radius - i) * 2, (radius - i) * heightFactor);
    }
  }
}
