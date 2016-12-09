// McKenzie Atwood
// LMC 2700 Project 2: Creative Tooling

Firework fire;
Button clearButton;
Button fader;
ColorPicker colorPicker;
ColorPickSpot spot;
Slider twistSlider;
Slider thicknessSlider;
Slider spinSlider;
Slider sizeSlider;
Toggle directionToggle;
Toggle fadingToggle;
Boolean isClockwise = true;
color picked;
double thickness;
double twist;
boolean fade;
int intro;
double spin;
boolean fading;
double size;

ArrayList < Firework > fireworks;

void setup() {
 size(750, 500);
 picked = color(255, 255, 255);
 thickness = 0.5;
 twist = 1;
 spin = 1;
 size = 0.2;
 spot = new ColorPickSpot(1000, 1000);
 fire = new Firework(0, 0, picked, thickness, twist, spin, isClockwise, size);
 fireworks = new ArrayList < Firework > ();
 intro = 100;
}


void whiteFadeIn() {
 background(0);
 color(0);
 clearButton = new Button(10, 10, 100, 20, color(51, 255, 255), "CLEAR");
 directionToggle = new Toggle(10, 40, 100, 20, color(204, 255, 204), "RIGHT", "LEFT");
 fadingToggle = new Toggle(10, 70, 100, 20, color(200, 100, 230), "FADING: OFF", "FADING: ON");
 twistSlider = new Slider(10, 130, 100, 20, 0.0, color(255, 0, 127), color(96, 96, 96), "TWIST");
 thicknessSlider = new Slider(10, 160, 100, 20, 0.5, color(102, 102, 255), color(96, 96, 96), "THICKNESS");
 spinSlider = new Slider(10, 100, 100, 20, 0.0, color(255, 255, 102), color(96, 96, 96), "SPIN");
 sizeSlider = new Slider(10, 190, 100, 20, 0.2, color(255, 102, 255), color(96, 96, 96), "SIZE");

 colorPicker = new ColorPicker();
 spot.display();
 fill(255, 255, 255, intro);
 rect(0, 0, 750, 500);
 intro = intro - 6;


}

void draw() {
 if (intro > 0) {
  whiteFadeIn();
 }
 if (fading) {
  for (int i = 0; i < fireworks.size(); i++) {
   if (fireworks.get(i).getLife() > 1000) {
    fireworks.remove(fireworks.get(i));
   }
  }
  clear();
 }
 for (Firework each: fireworks) {

  each.display();
 }
 clearButton.display();
 colorPicker.display();
 spot.display();
 twistSlider.display();
 thicknessSlider.display();
 spinSlider.display();
 directionToggle.display();
 fadingToggle.display();
 sizeSlider.display();
}


void mouseDragged() {
 mouseClicked();
}

void mouseClicked() {
 if (mouseY >= 470) { //Clicked on color picker.
  picked = get(mouseX, mouseY);
  spot = new ColorPickSpot(mouseX, mouseY);
 } else if (twistSlider.isMouseOnButton()) {
  twist = twistSlider.getCurrent();
 } else if (spinSlider.isMouseOnButton()) {
  spin = spinSlider.getCurrent() * 10;
 } else if (thicknessSlider.isMouseOnButton()) {
  thickness = thicknessSlider.getCurrent();
 } else if (sizeSlider.isMouseOnButton()) {
  size = sizeSlider.getCurrent();
 } else if (directionToggle.isMouseOnButton()) {
  directionToggle.toggle();
  isClockwise = directionToggle.oneSelected;
 } else if (fadingToggle.isMouseOnButton()) {
  fading = !fading;
  fadingToggle.toggle();
 } else if (!clearButton.isMouseOnButton() && intro <= 0) {
  if (mouseButton == LEFT) {
   Firework x = new Firework(mouseX, mouseY, picked, thickness, twist, spin, isClockwise, size);
   fireworks.add(x);
  } else {
   int x = (int) random(0, 750);
   int y = (int) random(0, 270);
   color c = color(random(0, 255), random(0, 255), random(0, 255));
   double t1 = random(0.1, 1.0);
   double t2 = random(0.1, 10.0);
   double s1 = random(0.1, 1.0);
   boolean dir = false;
   if (random(1.0) > 0.5) {
    dir = true;
   }
   double s2 = random(0.1, 1.0);
   Firework random = new Firework(x, y, c, t1, t2, s1, dir, s2);
   fireworks.add(random);

  }
 } else if (clearButton.isMouseOnButton()) {
  fireworks.clear();
  fireworks = null;
  fireworks = new ArrayList < Firework > ();
  setup();
 }
}



class ColorPicker {

 ColorPicker() {}
 void display() {
  colorMode(HSB, 1.0);
  noStroke();
  for (int i = 0; i < 750; i++) {
   for (int j = 0; j < 30; j++) {
    fill(i / 750.0, j / 15.0, j / 15.0, 1.0);
    rect(i, 470 + j, 1, 1);
   }
  }
  colorMode(RGB, 255, 255, 255, 100.0);
 }
}

class ColorPickSpot {
 int x;
 int y;

 ColorPickSpot(int x, int y) {
  this.x = x;
  this.y = y;
 }

 void display() {
  fill(picked);
  stroke(255, 255, 255);
  strokeWeight(1);
  ellipse(x, y, 10, 10);
 }

 int getX() {
  return x;
 }

 int getY() {
  return x;
 }

 color getColor() {
  return get(x, y);
 }

 void setPosition(int x, int y) {
  this.x = x;
  this.y = y;
 }
}

class Firework {
 Particle[] particles = new Particle[11];
 int xPos;
 int yPos;
 color boomColor;
 double size;
 double thickness;
 double twist;
 double spin;
 Boolean isClockwise;
 int startTime;


 Firework(int x, int y, color c, double t, double twist, double spin, boolean isClockwise, double s) {
  startTime = millis();
  this.spin = spin;
  float angle = 0;
  this.isClockwise = isClockwise;
  this.twist = twist;
  xPos = x;
  yPos = y;
  boomColor = c;
  thickness = t;
  size = s;
  for (int i = 0; i < 11; i++) {
   Particle particle = new Particle(xPos, yPos, angle, size);
   particles[i] = particle;
   angle += 36 * twist;
  }
 }


 int getLife() {
  return (millis()) - startTime;
 }

 void display() {
  for (int i = 0; i < 11; i++) {
   particles[i].update();
   particles[i].display();
  }

  fill(boomColor);
  ellipse((float) xPos, (float) yPos, (float) thickness, (float) thickness);
 }


 void rotate() {

 }

 class Particle {
  int originalX;
  int originalY;
  int xPos;
  int yPos;
  float angle;
  double distance;
  float o;
  int fade;
  double size;

  Particle(int x, int y, float a, double s) {
   originalX = x;
   originalY = y;
   xPos = x;
   yPos = y;
   angle = a;
   size = s;
   distance = 0;
   o = 100.0;
  }

  void display() {
   update();
   stroke(boomColor, 0);
   ellipse(xPos, yPos, (float)(10 * thickness), (float)(10 * thickness));
  }

  void update() {
   fill(boomColor, o);
   distance = distance + (3 * size);
   if (isClockwise) {
    angle += 0.01 * spin;
   } else {
    angle -= 0.01 * spin;

   }
   o = o - 1;
   xPos = originalX + (int)(cos((float) angle) * distance);
   yPos = originalY + (int)(sin((float) angle) * distance);

  }

  void setDistance(int d) {
   distance = d;
  }
 }


}