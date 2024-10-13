import java.util.ArrayList;
import java.util.List;

class Cube{
  float x;
  float y;
  float z;
  float sideLength;
  ArrayList<Point> points = new ArrayList<>();
  
  Cube(float X, float Y, float Z, float SideLength){
    x = X;
    y = Y;
    z = Z;
    sideLength = SideLength;
    for (int i = -1; i < 2; i+=2){
      for(int j = -1; j < 2; j+=2){
        for(int k = -1; k < 2; k+=2){
          points.add(new Point(x+sideLength*i/2,y+sideLength*j/2,z+sideLength*k/2));
        }
      }
    }
  } 
}
