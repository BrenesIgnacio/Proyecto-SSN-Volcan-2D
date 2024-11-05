import controlP5.*;
import processing.core.PApplet;

class ControlPanel {

  ControlP5 cp5;
  controlP5.Slider slider1, slider2;
  PApplet parent;

  ControlPanel(PApplet parent) {
    this.parent = parent;
  }

  void setup() {
    cp5 = new ControlP5(parent);

    slider1 = cp5.addSlider("Temperature")
                 .setPosition(20, 20)
                 .setSize(360, 10)
                 .setRange(1, 2000);
                 
    slider2 = cp5.addSlider("Mass")
                 .setPosition(20, 50)
                 .setSize(360, 10)
                 .setRange(0, 9);
  }

  void draw() {
    parent.fill(255);
    //parent.text("Temperature value: " + slider1.getValue(), 20, 140);
    //parent.text("Mass value: " + slider2.getValue(), 20, 160);
  }

  // Getter methods for slider values
  float getTemperature() {
    return slider1.getValue();
  }

  float getMass() {
    return slider2.getValue();
  }
}
