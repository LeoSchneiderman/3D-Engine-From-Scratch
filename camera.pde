
class Camera {
  float x;
  float y;
  float z;
  float theta;
  float alpha;
  float screenDistance;
  float sinTheta;
  float sinAlpha;
  float cosTheta;
  float cosAlpha;

  Camera(float X, float Y, float Z, float Theta, float Alpha, float ScreenDistance){
    x = X;
    y = Y;
    z = Z;
    theta = Theta;
    alpha = Alpha;
    screenDistance = ScreenDistance;
    sinTheta = sin(theta);
    cosTheta = cos(theta);
    sinAlpha = sin(alpha);
    cosAlpha = cos(alpha);
    
  }
  
  void changeTheta(float deltaTheta){
    theta+=deltaTheta;
    sinTheta=sin(theta);
    cosTheta=cos(theta);
  }
  
  void changeAlpha(float deltaAlpha){
    alpha+=deltaAlpha;
    sinAlpha=sin(alpha);
    cosAlpha=cos(alpha);
  }
  
  void pressedKey() {
  if (key == 'w' || keyCode == UP) {
    z += 0.1;
  } else if (key == 's' || keyCode == DOWN) {
    z -= 0.1;
  } else if (key == 'a' || keyCode == LEFT) {
    x -= 0.1;
  } else if (key == 'd' || keyCode == RIGHT) {
    x += 0.1;
  }
    else if (key == ' '){
      y += 0.01;
    }
    else if (keyCode == SHIFT){
      y -= 0.01;
    }
}
  
  Point transcribe(Point point){
    return new Point(point.x - x, point.y - y, point.z - z);
  }
  
  Point rotateAboutY(Point point){
    return new Point(point.x*cosTheta-point.z*sinTheta,point.y,
    point.x*sinTheta+point.z*cosTheta);
 //return point;
  }
  
  Point rotateAboutX(Point point){
    Point tempPoint = new Point(point.x,point.y*cosAlpha+point.z*sinAlpha,
    -point.y*sinAlpha+point.z*cosAlpha);
    return tempPoint;
  }
  
  Point transcribeAndRotate(Point point){
    Point tempPoint = point;
    tempPoint = transcribe(tempPoint);
    tempPoint = rotateAboutY(tempPoint);
    tempPoint = rotateAboutX(tempPoint);
    return tempPoint;
  }
  
  Pixel project(Point point){
    Pixel tempPixel = new Pixel(int(width*point.x*screenDistance/point.z)+width/2,
    int(-height*point.y / point.z * screenDistance) + height / 2, point.z);
    return tempPixel;
  }
  
  Pixel findPointRender(Point point){
    Pixel tempPixel;
    Point tempPoint;
    tempPoint = transcribeAndRotate(point);
    tempPixel = project(tempPoint);
    return tempPixel;
  }
  
  Pixel renderPoint(Point point){
    strokeWeight(5);
    Pixel tempPixel;
    tempPixel = findPointRender(point);
    point(tempPixel.x, tempPixel.y);
    return tempPixel;
  }
  
  void renderCube(Cube cube){
    Point tempPoint = new Point(cube.x, cube.y, cube.z);
    if (findPointRender(tempPoint).z-cube.sideLength/2<screenDistance){
      return;
    }
    strokeWeight(1);
    renderQuad(cube.points.get(3), cube.points.get(7), cube.points.get(5), cube.points.get(1));//back
    renderQuad(cube.points.get(1), cube.points.get(0), cube.points.get(2), cube.points.get(3));//left
    renderQuad(cube.points.get(2), cube.points.get(6), cube.points.get(7), cube.points.get(3));//top
    renderQuad(cube.points.get(7), cube.points.get(5), cube.points.get(4), cube.points.get(6));//right
    renderQuad(cube.points.get(0), cube.points.get(1), cube.points.get(5), cube.points.get(4));//bottom
    renderQuad(cube.points.get(0), cube.points.get(2), cube.points.get(6), cube.points.get(4));//front
  }
  
  void renderQuad(Point point1, Point point2, Point point3, Point point4){
    fill(0, 0, 255, 0);
    quad(findPointRender(point1).x, findPointRender(point1).y, findPointRender(point2).x, findPointRender(point2).y, findPointRender(point3).x, findPointRender(point3).y, findPointRender(point4).x, findPointRender(point4).y);
  }
}
