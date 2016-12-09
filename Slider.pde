class Slider {
  int x, y, w, h;
  double current;
  color foreground;
  color background;
  String label;
  String outLabel;
  
  Slider(int x, int y, int w, int h, double c, color f, color b, String l) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    current = c;
    foreground = f;
    background = b;
    label = l;
  }


  void display() {
    strokeWeight(1);
    update();
    fill(background);
    rect(x,y,w,h);
    fill(foreground);
    rect(x,y,(int)(current * w),h);
    drawButtonText();
  }
  
  void update() {
   if(mousePressed && mouseX >= x && mouseY >= y && mouseX <= x + w && mouseY <= y + h) {
     current = (double)(mouseX - x) / (double) w;
   }
  
  }
  
  void drawButtonText() {
    outLabel = label + ": " + (int) (current * 100);
    textSize(12);
    fill(0);
    textAlign(CENTER);
    text(outLabel, x + (w / 2), y + (h / 2) + 5);
  }
  
  double getCurrent() {
    return current;
  }
  
  boolean isMouseOnButton() {
    return (mouseX >= x && mouseY >= y && mouseX <= x + w && mouseY <= y + h);
  }
  
}