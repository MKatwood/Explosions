// McKenzie Atwood
// A class that represents a button on the canvas.

class Button {
  int xPos, yPos, buttonWidth, buttonHeight;
  color buttonColor;
  String buttonText;

  // Constructor that uses default color.
  Button(int x, int y, int w, int h, String text) {
    this(x, y, w, h, color(150, 150, 150), text);
  }
  
  // Constructor that takes in all parameters
  // @param x the X position of the button
  // @param y the Y position of the button
  // @param w the width of the button
  // @param h the height of the button
  // @param c the color of the button
  // @param t text on the button
  Button(int x, int y, int w, int h, color c, String t) {
    xPos = x;
    yPos = y;
    buttonWidth = w;
    buttonHeight = h;
    buttonColor = c;
    buttonText = t;
  }
  
  // Called in main class draw method to draw the button each frame.
  void display() {
    clear();
    background(255);
    stroke(0, 0, 0);
    strokeWeight(3);
    fill(buttonColor);
    rect(xPos, yPos, buttonWidth, buttonHeight);
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
      rect(xPos, yPos, buttonWidth, buttonHeight);
    }
  }
  
  // Called each frame to draw the text on the button.
  void drawButtonText() {
    textSize(30);
    fill(0);
    textAlign(CENTER);
    text(buttonText, xPos + (buttonWidth / 2), yPos + (buttonHeight / 2));
  }
  
  // Helper method to quickly tell if the mouse is hovering over the button.
  // @return true if the mouse's coordinates is within the bounds of the button
  boolean isMouseOnButton() {
    return (mouseX >= xPos && mouseY >= yPos && mouseX <= xPos + buttonWidth 
          && mouseY <= yPos + buttonHeight);
  }
}