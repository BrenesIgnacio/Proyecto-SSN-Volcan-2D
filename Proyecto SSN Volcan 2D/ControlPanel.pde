import controlP5.*;

class ControlPanel {

  ControlP5 cp5;
  Slider slider1, slider2, slider3, slider4;

  void setup() {
    size(800, 600);
    cp5 = new ControlP5(this);

    slider1 = cp5.addSlider("Temperture").setPosition(20, 20).setSize(360, 10).setRange(0, 100);
    slider2 = cp5.addSlider("Mass").setPosition(20, 50).setSize(360, 10).setRange(0, 255);
    slider3 = cp5.addSlider("Emission Rate").setPosition(20, 80).setSize(360, 10).setRange(-10, 10);
  }

  void draw() {
    background(0);
    fill(255);
    text("Temperture value: " + slider1.getValue(), 20, 140);
    text("Mass value: " + slider2.getValue(), 20, 160);
    text("Emission Rate: " + slider3.getValue(), 20, 180);
  }

  void handleInput() {
    // logica
  }
}
