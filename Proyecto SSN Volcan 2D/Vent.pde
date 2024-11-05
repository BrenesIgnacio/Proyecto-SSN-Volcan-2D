class Vent {
  PVector position;
  float width;

  PFont boldFont;

  Vent(PVector position, float width) {
    this.position = position;
    this.width = width;

    boldFont = createFont("Calibri Bold", 19);
  }

  void draw() {
    float inter = map(1, 0, height, 0, 1);
    int c = lerpColor(color(50, 50, 50), color(20, 20, 20), inter);
    fill(c);
    noStroke();

    float ventHeight = width / 2;

    triangle(position.x - width / 2, position.y,
      position.x + width / 2, position.y,
      position.x, position.y + ventHeight);

    fill(255);
    textAlign(CENTER);
    textFont(boldFont);
    textSize(19);
    text("Vent", 465, 450);
  }
}
