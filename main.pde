import java.util.ArrayList;
import java.util.List;

Camera camera1 = new Camera(0.1, 0, 0, 0, 0, 1);
Point point1 = new Point(0, 0, 10);
ArrayList<Cube> cubes = new ArrayList<>();
int mousex = 0;
int mousey = 0;
int deltaMouseX;
int deltaMouseY;

void keyPressed() {
  camera1.pressedKey();
}

void mouseDragged(){
  camera1.changeAlpha(float(deltaMouseY) / height);
  camera1.changeTheta(float(deltaMouseX) / width);
  }


void setup(){
  fullScreen();
  frameRate(60);
  
  for(int i = 0; i<8; i++){
    for(int j = 0; j<8; j++){
      cubes.add(new Cube(i-4, -2, j+10, 1));
    }
  }
}

void draw(){
  deltaMouseY = mouseY - mousey;
  deltaMouseX = mouseX - mousex;
  
  background(255);
  camera1.renderPoint(point1);
  for(int i=0;i<64;i++){
    camera1.renderCube(cubes.get(i));
  }
  
  mousey = mouseY;
  mousex = mouseX;
}
