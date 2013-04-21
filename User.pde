class User extends Drawable {
  PImage usrImg;
  String name;
  String role;
  
  User(String aName, String aRole) {
     usrImg = loadImage("usr.png");
      name = aName;
      role = aRole;
  }
  
  void render() {
    image(usrImg, 7, 7, 20, 20);
    fill(0);
    textFont(font12);        
    text(name + " (" + role + ")", 35, 23);
  }
}
