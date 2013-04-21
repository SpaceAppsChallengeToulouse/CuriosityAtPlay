import controlP5.*;

ControlP5 cp5;

static final int W = 800;
static final int H = 600;
static final int BOTTOM_AREA_H = 100;
static final int TOP_AREA_H = 35;
static final int KNOB_RADIUS = 40;
static final int MAX_SELECTABLE_IP = 3;
static final int NB_DISPLAYED_IPS = 7;
static final int GAME_DURATION = 600;

World world;
CommandArea cArea;
controlP5.Button quitBtn;
controlP5.Button goBtn;
controlP5.Button loginBtn;
controlP5.Button logoutBtn;
User usr;
Clock clk;
int pageIndex = 0;
CheckBox checkbox;
RadioButton radio;
PFont font10;
PFont font12;
PFont font16;
PFont font20;
ControlFont cf10;
ControlFont cf12;
ControlFont cf16;
ControlFont cf20;
Knob myKnobA;
// Start time in seconds
int startTime;

void setup()
{
   size(W, H);
   cp5 = new ControlP5(this);
  
   font10 = createFont("arial",10);
   font12 = createFont("arial",12);
   font16 = createFont("arial",16);
   font20 = createFont("arial",20);
   cf10 = new ControlFont(font10);
   cf12 = new ControlFont(font12);
   cf16 = new ControlFont(font16);
   cf20 = new ControlFont(font20);

   textFont(font16); 
   
   createLoginPage();
}

void createLoginPage() {
   fill(204);
   rect(0, 0, W , H);
  
   Textfield tf = cp5.addTextfield("Name")
     .setPosition(250,200)
     .setSize(200,30)
     .setFont(font16)
     .setFocus(true)
     .setColor(color(255,255,255))
    ;
    //color(2, 52, 77)
    
    tf.captionLabel().setControlFont(cf12);
        tf.captionLabel().hide();
        tf.captionLabel().setColor(0);
    radio = cp5.addRadioButton("radioButton")
         .setPosition(250, 280)
         .setSize(15,15)
         .setColorForeground(color(120))
         .setColorActive(color(255))
         .setColorLabel(color(255))
         .setItemsPerRow(5)
         .setSpacingColumn(120)
         .addItem("Geologist",1)
         .addItem("Meteorologist",2)
         .addItem("Mineralogist",3)
         .addItem("Chemist",4)
         ;
     
     for(Toggle t:radio.getItems()) {
 //      t.captionLabel().setColorBackground(color(204));
       t.captionLabel().setControlFont(cf12);
       t.captionLabel().style().moveMargin(-7,0,0,-3);
       t.captionLabel().style().movePadding(7,0,0,3);
       t.captionLabel().style().backgroundWidth = 45;
       t.captionLabel().style().backgroundHeight = 13;
     } 

    // By default, geologist role
    radio.activate(0);
    
     loginBtn = cp5.addButton("Login")
       .setPosition(250, 340)
       .setSize(100,25)
      ;
    loginBtn.captionLabel().setControlFont(cf16);
  
   quitBtn = cp5.addButton("Quit")
     .setPosition(450, 340)
     .setSize(100,25)
      ;
    quitBtn.captionLabel().setControlFont(cf16);
    showLoginPage();
    
 }
 
public void Login(int theValue) {
  String currentName = cp5.get(Textfield.class,"Name").getText();
  if ((currentName != null) && (!currentName.equals("")))  {
    int index = (int)cp5.get(RadioButton.class,"radioButton").getValue() - 1;
    String role = cp5.get(RadioButton.class,"radioButton").getItem(index).getLabel();
    hideLoginPage();
    createMainPage(currentName, role);
  }
  
}

void hideLoginPage() {
  quitBtn.hide(); 
  loginBtn.hide(); 
  cp5.controller("Name").hide(); 
  radio.hide();  
}

void showLoginPage() {
  PImage img;
  img = loadImage("welcome.jpg");
  image(img, 0, 0, 800, 600);

  fill(204,0,0,127);
  rect(50, 80, 700 , 350);
  
  fill(0,0,255);
  textFont(createFont("arial",36));        
  text("CURIOSITY@PLAY", 230, 150);

  quitBtn.show(); 
  loginBtn.show(); 
  cp5.controller("Name").show(); 
  radio.show(); 
  fill(255);
  textFont(font16);        
  text("Enter your name :", 100, 222);
  text("Choose your role :", 100, 292);
}

void createMainPage(String userName, String role) {
   pageIndex =  1;
   usr = new User(userName, role);
   startTime = millis() / 1000;
   
   clk = new Clock(GAME_DURATION);
   
   world = new World();
   cArea = new CommandArea();

   logoutBtn = cp5.addButton("Logout")
     .setPosition(690, 5)
     .setSize(100,25)
     ;
   logoutBtn.captionLabel().setControlFont(cf16);

   goBtn = cp5.addButton("Submit")
     .setPosition(690, 570)
     .setSize(100,25)
     ;
   goBtn.captionLabel().setControlFont(cf16);
   
   myKnobA = cp5.addKnob("Overall Rate")
               .setRange(0,300)
               .setValue(0)
               .setPosition(5, H - 2*KNOB_RADIUS - 17)
               .setRadius(KNOB_RADIUS)
               .setColorForeground(color(255, 255, 0))
               .setColorBackground(color(2, 52, 77))
               .setColorActive(color(255,255,0))
               .setDragDirection(Knob.VERTICAL)
               ;
               fill(0);
   myKnobA.captionLabel().setControlFont(cf10);
   myKnobA.captionLabel().setColor(color(2, 52, 77));

   cArea.displayMessage("Hi " + userName + " !");
}

void hideMainPage() {
   fill(204);
   rect(0, 0, W , H);
   logoutBtn.hide(); 
   goBtn.hide(); 
   myKnobA.hide();
}

public void Quit(int theValue) {
  println("Exiting application : "+theValue);
  exit();
}

public void Logout(int theValue) {
  pageIndex = 0;
  hideMainPage();
  showLoginPage();
}

public void GO(int theValue) {
  pageIndex = 2;
  hideMainPage();
  fill(0, 0, 255);
  PFont font36 = createFont("arial",36);
  textFont(font36);        
  text("Bye Bye ...", 320, 280); 
}

public void Submit(int theValue) {
  pageIndex = 2;
  hideMainPage();
  fill(0);
  textFont(font20);        
  int xPos = 50;
  int yPos = 20;
  PImage img;
  img = loadImage("chemist.png");
  image(img, xPos, yPos, 300, 174);
  text("Chemist interests", xPos, yPos + 200); 
  
  img = loadImage("geologist.png");
  image(img, W - xPos - 300, yPos, 300, 174);
  text("Geologist interests", W - xPos - 300, yPos + 200); 

  img = loadImage("meteorologist.png");
  image(img, xPos, yPos + 250, 300, 174);
  text("Meteorologist interests", xPos, yPos + 450); 

  img = loadImage("mineralogist.png");
  image(img, W - xPos - 300, yPos + 250, 300, 174);
  text("Mineralogist interests", W - xPos - 300, yPos + 450); 

  // Chat area
  fill(255);
  rect(0, H - BOTTOM_AREA_H, W, BOTTOM_AREA_H);

  img = loadImage("orange.png");
  image(img, 10, H - BOTTOM_AREA_H, 20, 25);

  img = loadImage("blue.png");
  image(img, 10, H - BOTTOM_AREA_H + 30, 20, 25);

  img = loadImage("green.png");
  image(img, 10, H - BOTTOM_AREA_H + 60, 20, 25);

  textFont(font16);        
  fill(0,0,255);
  text("(John) :", 40, H - BOTTOM_AREA_H + 20); 
  text("(Paul) :", 40, H - BOTTOM_AREA_H + 47); 
  text("(Mike) :", 40, H - BOTTOM_AREA_H + 74); 
  fill(0);
  text("Let's choose the best interest points !", 100, H - BOTTOM_AREA_H + 20); 
  text("Hi guys ! What about directly going to IP2 ?", 100, H - BOTTOM_AREA_H + 47); 
  text("Huumm, not sure wa can afford that...", 100, H - BOTTOM_AREA_H + 74); 

   goBtn = cp5.addButton("GO")
     .setPosition(690, 570)
     .setSize(100,25)
     ;
   goBtn.captionLabel().setControlFont(cf16);


}

void sleep(int nbMilis) {
  int start = millis();
  boolean spent = false;
  while (!spent) {
    int spentTime = millis()-start;
    if (spentTime>nbMilis) {
      spent = true;
    }
  }
  println("ended");
}     

void draw()
{
  if (pageIndex == 0) {
  } else if (pageIndex == 1) {
      update(mouseX, mouseY);  
      world.render();
      cArea.render();
      usr.render();
      int spentTime = millis() / 1000 -  startTime;
      int remainingTime = GAME_DURATION - spentTime;
         
      clk.setValue(remainingTime);
      clk.render();
      // If clock reached game duration limit, automatically submit main page
      if (remainingTime == 0) {
        Submit(0);
      }
   } else {
  }
}

void mousePressed(){
  if (pageIndex==0) {
  } else {
    world.tryToSelect();
  }
}

void update(int x, int y) {
  world.tryToHighlight();
}

abstract class Drawable
{
  public float  x, y;
  abstract void render(); 
}

abstract class Selectable extends Drawable
{
  boolean selected = false;
  void select() {
    selected = true;
  }

  void unSelect() {
    selected = false;
  }

  boolean isSelected() {
    return selected;
  }
}

class World extends Drawable
{
  PImage bgImg;
  
  ArrayList<InterestPoint> interestPoints;
  
  int nbSelecteIP = 0;
  int selectedValue = 0;
  
  World()
  {
     interestPoints = new ArrayList<InterestPoint>();
     
     // Interest Points creation
     for (int i = 1; i <= NB_DISPLAYED_IPS; i++) {
           int posX = (int)(random(0, W));
           int posY = (int)(random(TOP_AREA_H, H - BOTTOM_AREA_H));
           interestPoints.add(new InterestPoint(posX, posY, i));
      }     

/*     interestPoints.add(new InterestPoint(100, 100, 1));
     interestPoints.add(new InterestPoint(300, 50, 2));
     interestPoints.add(new InterestPoint(500, 300, 3));
     interestPoints.add(new InterestPoint(400, 200, 4));
     interestPoints.add(new InterestPoint(750, 500, 5));
     interestPoints.add(new InterestPoint(150, 350, 6));
     interestPoints.add(new InterestPoint(750, 110, 7));
*/

     bgImg = loadImage("back.png");
  }
  
  void render()
  {
     background(0); 
     image(bgImg, 0, 0, W, H);
     for (InterestPoint p : interestPoints)
     {
       p.render(); 
     }
     
  }
  
  List<InterestPoint> getInterestPoints() {
    return interestPoints;
  }
  
  // This method try to select an interest point around the mouse cursor
  void tryToSelect() {
    int epsilon = 7;
    
    for (InterestPoint ip : interestPoints) {
      if ((abs(ip.x - mouseX) < epsilon) && (abs(ip.y - mouseY) < epsilon)) {
        if (ip.isSelected()) {
          ip.unSelect();
          nbSelecteIP--;
          selectedValue -= ip.value;
          myKnobA.setValue(selectedValue);
          cArea.displayMessage("Current overall interest : " + selectedValue);
        } else {
          if (nbSelecteIP < MAX_SELECTABLE_IP) {
            ip.select();
            nbSelecteIP++;
            selectedValue += ip.value;
             myKnobA.setValue(selectedValue);
            cArea.displayMessage("Current overall interest : " + selectedValue);
          } else {
            cArea.displayError("Max number of interest points reached !");
          }
        }
      }
    }
  }
  
  void tryToHighlight(){
    int epsilon = 7;    
    for (InterestPoint ip : interestPoints) {
      ip.untooltip();
      if ((abs(ip.x - mouseX) < epsilon) && (abs(ip.y - mouseY) < epsilon)) {
        ip.tooltip();
      } 
    }
  }
  
  void displayError(String message) {
    println(message);
  }
  
}

class InterestPoint extends Selectable
{
    String name;
    String description;
    Action action;
    Job forJob;
    int index;
    boolean tooltipped = false;
    int value = 0;
  
    InterestPoint(float posx, float posy, int i) {
      x = posx;
      y = posy;
      index = i;
      value = (int)(random(1) * 100);
      description = usr.role + " interest of IP" + index + " : " + value + "%";
    }
    public void render()
    {
      // First render a star on IP location
      if (selected) {
          // Red
          fill(255, 0, 0);
      } else {
        if (tooltipped) {
          // Yellow
          fill(255, 255, 0);
        } else {
          // Green
          fill(0, 255, 0);
        }
      }
      star(5, x, y, 6, 3f);
  
      // If necessary, render a text tooltip
      if (tooltipped) {
        fill(255);
        int toolTipX = (int)x + 10;
        int toolTipY = (int)y - 30;
        int w = 10 + description.length() * 8;
        int h = 100;
        String graphName = "graphe1.png";
        if (value < 25) {
            h = 100;
            graphName = "graphe1.png";
        } else if ((value > 25) && (value < 50)) {
            h = 200;
            graphName = "graphe2.png";
        } else if ((value > 50) && (value < 75)) {
            h = 150;
            graphName = "graphe3.png";
        } else {
            h = 125;
            graphName = "graphe4.png";
        }
       
        // Case of the screen bottom
        if (toolTipY + h > H - BOTTOM_AREA_H) {
          toolTipY = H - BOTTOM_AREA_H - h;
        } 

        // Case of the screen right
        if (toolTipX + w > W) {
          toolTipX = (int)x - w - 20;
        } 

        textFont(font16);        

        rect(toolTipX, toolTipY, w, h);
        fill(0);
        text(description, toolTipX + 5, toolTipY + 20);
 
        PImage grpImg = loadImage(graphName);;
        image(grpImg, toolTipX + 20, toolTipY + 30 , w - 40, h - 40);

      }
      noFill();
  }
  

  void tooltip() {
    tooltipped = true;
  }

  void untooltip() {
    tooltipped = false;
  }
  
  int getIndex() {
    return index;
  }

  void star(int n, float cx, float cy, float r, float proportion)
  {
    star(n, cx, cy, 2.0 * r, 2.0 * r, 0.0, proportion);
  }


  void star(int n, float cx, float cy, float w, float h,
    float startAngle, float proportion)
  {
    if (n > 2)
    {
      float angle = TWO_PI/ (2 *n);  // twice as many sides
      float dw; // draw width
      float dh; // draw height
      
      w = w / 2.0;
      h = h / 2.0;
      
      beginShape();
      for (int i = 0; i < 2 * n; i++)
      {
        dw = w;
        dh = h;
        if (i % 2 == 1) // for odd vertices, use short radius
        {
          dw = w * proportion;
          dh = h * proportion;
        }
        vertex(cx + dw * cos(startAngle + angle * i),
          cy + dh * sin(startAngle + angle * i));
      }
      endShape(CLOSE);
    }
  }

}
