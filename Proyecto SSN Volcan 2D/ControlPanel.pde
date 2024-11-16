import controlP5.*;
import processing.core.PApplet;

class ControlPanel {

  ControlP5 cp5;
  controlP5.Slider slider1, slider2, slider3, slider4;
  PApplet parent;

  ControlPanel(PApplet parent) {
    this.parent = parent;
  }

  void setup() {
    cp5 = new ControlP5(parent);

    slider1 = cp5.addSlider("Velocidad flujo")
                 .setPosition(20, 20)
                 .setSize(280, 10)
                 .setRange(0, 8);
                 
    slider2 = cp5.addSlider("Emisión gases")
                 .setPosition(20, 50)
                 .setSize(280, 10)
                 .setRange(0, 30);
                 
   slider3 = cp5.addSlider("Emisión de lava izquierda")
                 .setPosition(20, 80)
                 .setSize(280, 10)
                 .setRange(0, 30);
                 
   slider4 = cp5.addSlider("Emisión de lava derecha")
                 .setPosition(20, 110)
                 .setSize(280, 10)
                 .setRange(0, 30);
  }

  void draw() {
    parent.fill(255);
    //parent.text("Temperature value: " + slider1.getValue(), 20, 140);
    //parent.text("Mass value: " + slider2.getValue(), 20, 160);
  }

  // Getter methods for slider values
  float getVelocity() {
    return slider1.getValue();
  }

  float getgasEmission() {
    return slider2.getValue();
  }
  
  float getLavaEmission1() {
    return slider3.getValue();
  }
  
  float getLavaEmission2() {
    return slider4.getValue();
  }
  
  
}
