import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Explosions extends PApplet {

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
int picked;
double thickness;
double twist;
boolean fade;
int intro;
double spin;
boolean fading;
double size;

ArrayList < Firework > fireworks;

public void setup() {
 
 picked = color(255, 255, 255);
 thickness = 0.5f;
 twist = 1;
 spin = 1;
 size = 0.2f;
 spot = new ColorPickSpot(1000, 1000);
 fire = new Firework(0, 0, picked, thickness, twist, spin, isClockwise, size);
 fireworks = new ArrayList < Firework > ();
 intro = 100;
}


public void whiteFadeIn() {
 background(0);
 color(0);
 clearButton = new Button(10, 10, 100, 20, 51, 255, 255, "CLEAR");
 directionToggle = new Toggle(10, 40, 100, 20, color(204, 255, 204), "RIGHT", "LEFT");
 fadingToggle = new Toggle(10, 70, 100, 20, color(200, 100, 230), "FADING: OFF", "FADING: ON");
 twistSlider = new Slider(10, 130, 100, 20, 0.0f, color(255, 0, 127), color(96, 96, 96), "TWIST");
 thicknessSlider = new Slider(10, 160, 100, 20, 0.5f, color(102, 102, 255), color(96, 96, 96), "THICKNESS");
 spinSlider = new Slider(10, 100, 100, 20, 0.0f, color(255, 255, 102), color(96, 96, 96), "SPIN");
 sizeSlider = new Slider(10, 190, 100, 20, 0.2f, color(255, 102, 255), color(96, 96, 96), "SIZE");

 colorPicker = new ColorPicker();
 spot.display();
 fill(255, 255, 255, intro);
 rect(0, 0, 750, 500);
 intro = intro - 6;


}

public void draw() {
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


public void mouseDragged() {
 mouseClicked();
}

public void mouseClicked() {
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
   int c = color(random(0, 255), random(0, 255), random(0, 255));
   double t1 = random(0.1f, 1.0f);
   double t2 = random(0.1f, 10.0f);
   double s1 = random(0.1f, 1.0f);
   boolean dir = false;
   if (random(1.0f) > 0.5f) {
    dir = true;
   }
   double s2 = random(0.1f, 1.0f);
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
 public void display() {
  colorMode(HSB, 1.0f);
  noStroke();
  for (int i = 0; i < 750; i++) {
   for (int j = 0; j < 30; j++) {
    fill(i / 750.0f, j / 30.0f, 1.0f);
    rect(i, 470 + j, 1, 1);
   }
  }
  colorMode(RGB, 255, 255, 255, 100.0f);
 }
}

class ColorPickSpot {
 int x;
 int y;

 ColorPickSpot(int x, int y) {
  this.x = x;
  this.y = y;
 }

 public void display() {
  fill(picked);
  stroke(255, 255, 255);
  strokeWeight(1);
  ellipse(x, y, 10, 10);
 }

 public int getX() {
  return x;
 }

 public int getY() {
  return x;
 }

 public int getColor() {
  return get(x, y);
 }

 public void setPosition(int x, int y) {
  this.x = x;
  this.y = y;
 }
}

class Firework {
 Particle[] particles = new Particle[11];
 int xPos;
 int yPos;
 int boomColor;
 double size;
 double thickness;
 double twist;
 double spin;
 Boolean isClockwise;
 int startTime;


 Firework(int x, int y, int c, double t, double twist, double spin, boolean isClockwise, double s) {
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


 public int getLife() {
  return (millis()) - startTime;
 }

 public void display() {
  for (int i = 0; i < 11; i++) {
   particles[i].update();
   particles[i].display();
  }

  fill(boomColor);
  ellipse((float) xPos, (float) yPos, (float) thickness, (float) thickness);
 }


 public void rotate() {

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
   o = 100.0f;
  }

  public void display() {
   update();
   stroke(boomColor, 0);
   ellipse(xPos, yPos, (float)(10 * thickness), (float)(10 * thickness));
  }

  public void update() {
   fill(boomColor, o);
   distance = distance + (3 * size);
   if (isClockwise) {
    angle += 0.01f * spin;
   } else {
    angle -= 0.01f * spin;

   }
   o = o - 1;
   xPos = originalX + (int)(cos((float) angle) * distance);
   yPos = originalY + (int)(sin((float) angle) * distance);

  }

  public void setDistance(int d) {
   distance = d;
  }
 }


}
// A class that represents a button on the canvas.

class Button {
  int x, y, w, h, c1, c2, c3;
  String text;

  // Constructor that doesn't take in color and sets default color
  Button(int x, int y, int w, int h, String t) {
    this(x, y, w, h, 150, 150, 150, t);
  }
  
  // Constructor that takes in all parameters
  // @param x the X position of the button
  // @param y the Y position of the button
  // @param w the width of the button
  // @param h the height of the button
  // @param c1 first value of RGB color
  // @param c2 second value of RGB color
  // @param c3 third value of RGB color
  // @param t text on the button
  Button(int x, int y, int w, int h, int c1, int c2, int c3, String t) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c1 = c1;
    this.c2 = c2;
    this.c3 = c3;
    text = t;
  }
  
  
  // Called in main class draw method to draw the button each frame.
  public void display() {
    stroke(0, 0, 0);
    strokeWeight(3);
    fill(c1, c2, c3);
    rect(x, y, w, h);
    highlight();
    drawButtonText();
  }
  
  // Called each frame from display() to highlight the button if it is selected or moused over.
  public void highlight() {
    if(isMouseOnButton()) {
      if (mousePressed) {
        fill(255, 255, 255, 150);
      } else {
        fill(255, 255, 255, 40);
      }
      rect(x, y, w, h);
    }
  }
  
  // Called each frame to draw the text on the button.
  public void drawButtonText() {
    textSize(12);
    fill(0);
    textAlign(CENTER);
    text(text, x + (w / 2), y + (h / 2) + 5);
  }
  
  // Helper method to quickly tell if the mouse is hovering over the button.
  // @return true if the mouse's coordinates is within the bounds of the button
  public boolean isMouseOnButton() {
    return (mouseX >= x && mouseY >= y && mouseX <= x + w && mouseY <= y + h);
  }
  
}
class Slider {
  int x, y, w, h;
  double current;
  int foreground;
  int background;
  String label;
  String outLabel;
  
  Slider(int x, int y, int w, int h, double c, int f, int b, String l) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    current = c;
    foreground = f;
    background = b;
    label = l;
  }


  public void display() {
    strokeWeight(1);
    update();
    fill(background);
    rect(x,y,w,h);
    fill(foreground);
    rect(x,y,(int)(current * w),h);
    drawButtonText();
  }
  
  public void update() {
   if(mousePressed && mouseX >= x && mouseY >= y && mouseX <= x + w && mouseY <= y + h) {
     current = (double)(mouseX - x) / (double) w;
   }
  
  }
  
  public void drawButtonText() {
    outLabel = label + ": " + (int) (current * 100);
    textSize(12);
    fill(0);
    textAlign(CENTER);
    text(outLabel, x + (w / 2), y + (h / 2) + 5);
  }
  
  public double getCurrent() {
    return current;
  }
  
  public boolean isMouseOnButton() {
    return (mouseX >= x && mouseY >= y && mouseX <= x + w && mouseY <= y + h);
  }
  
}
// A class that represents a toggle on the canvas.

class Toggle {
  int x, y, w, h;
  int c;
  String optionOne;
  String optionTwo;
  Boolean oneSelected = true;

  
  // Constructor that takes in all parameters
  // @param x the X position of the button
  // @param y the Y position of the button
  // @param w the width of the button
  // @param h the height of the button
  // @param c1 first value of RGB color
  // @param c2 second value of RGB color
  // @param c3 third value of RGB color
  // @param t text on the button
  Toggle(int x, int y, int w, int h, int c, String t, String s) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
    optionOne = t;
    optionTwo = s;
  }
  
  
  // Called in main class draw method to draw the button each frame.
  public void display() {
    stroke(0, 0, 0);
    strokeWeight(3);
    fill(c);
    rect(x, y, w, h);
    highlight();
    drawButtonText();
  }
  
  // Called each frame from display() to highlight the button if it is selected or moused over.
  public void highlight() {
    if(isMouseOnButton()) {
      if (mousePressed) {
        fill(255, 255, 255, 150);
      } else {
        fill(255, 255, 255, 40);
      }
      rect(x, y, w, h);
    }
  }
  
  // Called each frame to draw the text on the button.
  public void drawButtonText() {
    textSize(12);
    fill(0);
    textAlign(CENTER);
    if (oneSelected) {
      text(optionOne, x + (w / 2), y + (h / 2) + 5);
    } else {
      text(optionTwo, x + (w / 2), y + (h / 2) + 5);
    }
  }
  
  public void toggle() {
    oneSelected = !oneSelected;
  }
  
  // Helper method to quickly tell if the mouse is hovering over the button.
  // @return true if the mouse's coordinates is within the bounds of the button
  public boolean isMouseOnButton() {
    return (mouseX >= x && mouseY >= y && mouseX <= x + w && mouseY <= y + h);
  }
  
}
  public void settings() {  size(750, 500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Explosions" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
