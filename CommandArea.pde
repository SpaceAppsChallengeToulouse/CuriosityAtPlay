class CommandArea extends Drawable
{
  Button goBttn;
  Button quitBttn;
  // height of the command area
  int h;
  color messageColor;
  List<String> messages; 
  String lastMessage;
  
  CommandArea() {
     messageColor = 0;
     h = BOTTOM_AREA_H;  
     y = H - h;
     messages = new ArrayList();
  }
  
  
  void displayMessage(String message) {
    messages.add(message);
//    messageColor = 0;
  }
 
   void displayError(String message) {
//    messageColor = color(255, 0, 0);;
    displayMessage(message);
  }
 
  void render() {
    // Top login info area
    fill(255);
    rect(0, 0, W, TOP_AREA_H);

    // Main page title     
    fill(0,0,255);
    textFont(createFont("arial",30));        
    text("Scientist step", 290, 27);

    // Bottom messages area
    fill(255);
    rect(0, y, W, h);
    rect(10 + 2*KNOB_RADIUS, y + 5, W - 130 - 2*KNOB_RADIUS, BOTTOM_AREA_H-10);

    // Messages to current user
    fill(messageColor); 
    textFont(font16);        

    int messageH = 17;
    int maxDisplayableMsg = (BOTTOM_AREA_H-10)/messageH;
    int firstMsgIndex = max(0, messages.size() - maxDisplayableMsg);
    int j = 0;
    for (int i = firstMsgIndex; i < messages.size(); i++) {
      text(messages.get(i), 25 + 2*KNOB_RADIUS, y + 20 + j * messageH);
      j++;
    }
  }
}
