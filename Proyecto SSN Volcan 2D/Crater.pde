class Crater {
  PVector position;
  float radius;

  PFont boldFont;

  Crater(PVector position, float radius) {
    this.position = position;
    this.radius = radius;

    boldFont = createFont("Arial-Bold", 19);
  }

  void draw() {
    colorMode(RGB);
    for (int i = 0; i < radius; i++) {
      float inter = map(i, 0, radius, 0, 1);
      int c = lerpColor(color(233, 138, 43), color(224, 93, 26), inter);
      fill(c);
      noStroke();
      float heightFactor = 0.5;
      ellipse(position.x, position.y, (radius - i) * 2, (radius - i) * heightFactor);
    }

    fill(0);
    textAlign(CENTER);
    textFont(boldFont);
    textSize(19);
    text("Crater", 290, 100);
  }
}
