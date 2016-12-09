// A class that represents a toggle on the canvas.

class Toggle {
  int x, y, w, h;
  color c;
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
  Toggle(int x, int y, int w, int h, color c, String t, String s) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
    optionOne = t;
    optionTwo = s;
  }
  
  
  // Called in main class draw method to draw the button each frame.
  void display() {
    stroke(0, 0, 0);
    strokeWeight(3);
    fill(c);
    rect(x, y, w, h);
    highlight();
    drawButtonText();
  }
  
  // Called each frame from display() to highlight the button if it is selected or moused over.
  void highlight() {
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
  void drawButtonText() {
    textSize(12);
    fill(0);
    textAlign(CENTER);
    if (oneSelected) {
      text(optionOne, x + (w / 2), y + (h / 2) + 5);
    } else {
      text(optionTwo, x + (w / 2), y + (h / 2) + 5);
    }
  }
  
  void toggle() {
    oneSelected = !oneSelected;
  }
  
  // Helper method to quickly tell if the mouse is hovering over the button.
  // @return true if the mouse's coordinates is within the bounds of the button
  boolean isMouseOnButton() {
    return (mouseX >= x && mouseY >= y && mouseX <= x + w && mouseY <= y + h);
  }
  
}