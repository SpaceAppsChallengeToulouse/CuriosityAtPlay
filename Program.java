import java.util.ArrayList;

class RobotPoint
{
  float x, y, angle;
 
  RobotPoint(float x, float y, float angle) {
    this.x = x;
    this.y = y;
    this.angle = angle;
  } 
}

abstract class Order 
{
  abstract RobotPoint execute(RobotPoint pt);
  abstract RobotPoint previewRender(RobotPoint pt);
}

class MoveOrder extends Order
{
  public float distance;
  
  MoveOrder(float distance) { this.distance = distance; }
  
  RobotPoint execute(RobotPoint pt)
  {
     float newX = pt.x + distance * (float) Math.cos(pt.angle);
     float newY = pt.y + distance * (float) Math.sin(pt.angle); 
     return new RobotPoint(newX, newY, pt.angle); 
  } 
  
  RobotPoint previewRender(RobotPoint pt)
  {
    return null; 
    //return execute();
  }
}

class RotateOrder extends Order
{
   public float angle;
   RotateOrder(float angle) { this.angle = angle; } 
   
   RobotPoint execute(RobotPoint pt)
   {
     return new RobotPoint(pt.x, pt.y, pt.angle + angle); 
   }
  
  RobotPoint previewRender(RobotPoint pt)
  {
     return null;
  } 
}

/*
class Program 
{
  ArrayList<Order> orders;
  
  public void preview(Robot robot)
  {  
      RobotPoint pt = new RobotPoint(robot.x, robot.y, robot.angle);
      
  }
  
}*/
