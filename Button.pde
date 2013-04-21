abstract class Button extends Drawable
{
  int x, y, h , w;
  String label;
  color currentColor;
  
  Button(int xPos, int yPos, String aLabel) {
    this.label = aLabel;
    int len = label.length();
    this.x = xPos;
    this.y = yPos;
    this.h = 20;
    this.w = 10 + len * 10;
    currentColor = 255;
  } 
  
  public void render() {
      fill(currentColor);
      rect(x, y, w, h);
      fill(0);
      text(label, x + 10, y + 15);
  }

  abstract void activate();
  
  void highlight() {
    currentColor = 204;
  }
  
  void unHighlight() {
    currentColor =255;
  }
  
  void tryToActivate() {
      // Check if cursor is over button
    if (mouseX >= x && mouseX <= x + w && 
        mouseY >= y && mouseY <= y + h) {
      activate();
    }
  }
  
  void tryToHighlight() {
      if (mouseX >= x && mouseX <= x + w && 
        mouseY >= y && mouseY <= y + h) {
      highlight();
    } else {
      unHighlight();
    }
  }

}

class QuitButton extends Button {
    QuitButton(int xPos, int yPos, String aLabel) {
      super(xPos, yPos, aLabel);
    }
    
    public void activate() {
//      println("quit!!");
      exit();
    }
}

class GoButton extends Button {
    GoButton(int xPos, int yPos, String aLabel) {
      super(xPos, yPos, aLabel);
    }
    
    public void activate() {
      println("Execution !!");
    }
}

