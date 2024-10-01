class RockLayers {
  ArrayList<PShape> layers;
  PVector position;
  float baseWidth;
  float height;
  int numLayers;

  PFont boldFont;

  RockLayers(PVector position, float baseWidth, float height, int numLayers) {
    this.position = position;
    this.baseWidth = baseWidth;
    this.height = height;
    this.numLayers = numLayers;
    layers = new ArrayList<PShape>();

    float scale = 0.97;
    for (int i = 0; i < numLayers; i++) {
      float layerHeight = height / numLayers;
      float currentWidth = baseWidth * pow(scale, i);
      PShape layer = createShape();
      layer.beginShape();
      layer.fill(i % 2 == 0 ? color(169, 169, 169) : color(105, 105, 105));
      layer.noStroke();

      layer.vertex(position.x - currentWidth / 2, position.y + i * layerHeight);
      layer.vertex(position.x + currentWidth / 2, position.y + i * layerHeight);
      layer.vertex(position.x + currentWidth / 2, position.y + (i + 1) * layerHeight);
      layer.vertex(position.x - currentWidth / 2, position.y + (i + 1) * layerHeight);
      layer.endShape(CLOSE);
      layers.add(layer);

      boldFont = createFont("Calibri Bold", 19);
    }
  }

  void draw() {
    for (PShape layer : layers) {
      shape(layer);
    }

    fill(0);
    textAlign(CENTER);
    textFont(boldFont);
    textSize(19);
    text("Rock layers", 650, 400);
  }
}
