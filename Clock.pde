class Clock extends Drawable {
  // Remaining time in seconds
  int value;
  
  Clock(int initialValue) {
     value = initialValue;
  }
  
  void setValue(int newValue) {
     value = newValue;
  }

  void render() {
    fill(255,0,0);
    textFont(font20);        
    text("Countdown : " + value + "s", 320, 23);
  }
}
