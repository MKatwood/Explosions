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
  void display() {
    stroke(0, 0, 0);
    strokeWeight(3);
    fill(c1, c2, c3);
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
    text(text, x + (w / 2), y + (h / 2) + 5);
  }
  
  // Helper method to quickly tell if the mouse is hovering over the button.
  // @return true if the mouse's coordinates is within the bounds of the button
  boolean isMouseOnButton() {
    return (mouseX >= x && mouseY >= y && mouseX <= x + w && mouseY <= y + h);
  }
  
}