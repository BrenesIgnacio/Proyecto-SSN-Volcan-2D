class RockLayers {
  ArrayList<PShape> layers;
  ArrayList<PVector> layerPositions; // Guardar las posiciones de cada capa

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
    layerPositions = new ArrayList<PVector>(); // Inicializa la lista de posiciones
    
    float scale = 0.97;
    for (int i = 0; i < numLayers; i++) {
      float layerHeight = height / numLayers;
      float currentWidth = baseWidth * pow(scale, i);
      PShape layer = createShape();
      layer.beginShape();
      layer.fill(i % 2 == 0 ? color(169, 169, 169) : color(105, 105, 105));
      layer.noStroke();

      float topY = position.y + i * layerHeight;
      float bottomY = position.y + (i + 1) * layerHeight;
      float leftX = position.x - currentWidth / 2;
      float rightX = position.x + currentWidth / 2;

      // Guardar los límites de esta capa en la lista
      layerPositions.add(new PVector(leftX, topY));  // Esquina superior izquierda
      layerPositions.add(new PVector(rightX, topY)); // Esquina superior derecha
      layerPositions.add(new PVector(leftX, bottomY)); // Esquina superior derecha
      layerPositions.add(new PVector(rightX, bottomY)); // Esquina superior derecha
      
      
      layer.vertex(leftX, topY);
      layer.vertex(rightX, topY);
      layer.vertex(rightX, bottomY);
      layer.vertex(leftX, bottomY);
      layer.endShape(CLOSE);
      layers.add(layer);

      boldFont = createFont("SansSerif", 19);
    }
  }

  // Método para obtener las posiciones de las capas
  ArrayList<PVector> getLayerPositions() {
    return layerPositions;
  }

  void draw() {
    for (PShape layer : layers) {
      shape(layer);
    }

    fill(255);
    textAlign(CENTER);
    textFont(boldFont);
    textSize(19);
    text("Rock layers", 650, 700);
  }
}
