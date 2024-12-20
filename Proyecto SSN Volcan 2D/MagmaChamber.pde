class MagmaChamber {
  PVector position;
  float width;
  float height;
  float temperature;

  PFont boldFont;

  MagmaChamber(PVector position, float width, float height, float temperature) {
    this.position = position;
    this.width = width;
    this.height = height;
    this.temperature = temperature;

    boldFont = createFont("SansSerif", 19);
  }

  void draw() {
    colorMode(RGB);
    for (int i = 0; i < height; i++) {
      float inter = map(i, 0, height, 0, 1);
      int c = lerpColor(color(50, 50, 50), color(20, 20, 20), inter);
      fill(c);
      noStroke();
      ellipse(position.x, position.y + (i / 2), width, height - i);
    }

    fill(255);
    textAlign(CENTER);
    textFont(boldFont);
    textSize(19);
    text("Magma Chamber", 250, 850);
  }
}
