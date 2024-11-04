class VolcanicPipe {
  PVector position;
  float width;
  float height;

  PFont boldFont;

  VolcanicPipe(PVector position, float width, float height) {
    this.position = position;
    this.width = width;
    this.height = height;

    boldFont = createFont("Calibri Bold", 19);
  }

  void draw() {
    colorMode(RGB);
    for (int i = 0; i < height; i++) {
      float inter = map(i, 0, height, 0, 1);
      int c = lerpColor(color(50, 50, 50), color(20, 20, 20), inter);
      fill(c);
      noStroke();
      rect(position.x - width / 2, position.y - i, width, 1);
    }

    fill(255);
    textAlign(CENTER);
    textFont(boldFont);
    textSize(19);
    text("Volcanic Pipe", 310, 300);
  }
}
