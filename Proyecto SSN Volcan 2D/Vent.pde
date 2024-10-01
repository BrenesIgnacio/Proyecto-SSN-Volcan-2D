class Vent {
  PVector position;
  float width;

  PFont boldFont;

  Vent(PVector position, float width) {
    this.position = position;
    this.width = width;

    boldFont = createFont("Arial-Bold", 19);
  }

  void draw() {
    fill(255, 69, 0);
    noStroke();

    float ventHeight = width / 2;

    triangle(position.x - width / 2, position.y,
      position.x + width / 2, position.y,
      position.x, position.y + ventHeight);

    fill(255);
    textAlign(CENTER);
    textFont(boldFont);
    textSize(19);
    text("Vent", 465, 150);
  }
}
