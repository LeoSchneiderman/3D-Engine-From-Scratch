
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
  
  void LoadPixels(){
    loadPixels();
  }
  
  void UpdatePixels(){
    updatePixels();
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
    Pixel tempPixel;
    tempPixel = findPointRender(point);
    drawPixel(tempPixel, 4);
    strokeWeight(5);
    //point(tempPixel.x, tempPixel.y);
    return tempPixel;
  }
  
  void renderCube(Cube cube){
    Point tempPoint = new Point(cube.x, cube.y, cube.z);
    if (findPointRender(tempPoint).z-cube.sideLength/2<screenDistance){
      return;
    }
    strokeWeight(1);
    /*drawQuad(cube.points.get(3), cube.points.get(7), cube.points.get(5), cube.points.get(1));//back
    drawQuad(cube.points.get(1), cube.points.get(0), cube.points.get(2), cube.points.get(3));//left
    drawQuad(cube.points.get(2), cube.points.get(6), cube.points.get(7), cube.points.get(3));//top
    drawQuad(cube.points.get(7), cube.points.get(5), cube.points.get(4), cube.points.get(6));//right
    drawQuad(cube.points.get(0), cube.points.get(1), cube.points.get(5), cube.points.get(4));//bottom
    drawQuad(cube.points.get(0), cube.points.get(2), cube.points.get(6), cube.points.get(4));//front*/
    renderPoint(cube.points.get(1));
    renderPoint(cube.points.get(2));
    //renderPoint(cube.points.get(3));
    connectPoints(cube.points.get(1), cube.points.get(2));
  }
  
  void connectPoints(Point point1, Point point2){
    Pixel pixel1 = findPointRender(point1);
    Pixel pixel2 = findPointRender(point2);
    connectPixels(pixel1, pixel2);
  }
  
  void connectPixels(Pixel pixel1, Pixel pixel2){
    int deltaX = pixel2.x - pixel1.x;
    int deltaY = pixel2.y - pixel1.y;
    float slope = deltaY / float(deltaX);
    for(int i = 0; i<abs(deltaX); i++){
      for(int j = 0; j < abs(slope); j++){
      Pixel tempPixel = new Pixel(pixel1.x+i, int(pixel1.y+i*slope+j), pixel1.z);
      drawPixel(tempPixel, 4);
      }
    }
  }
  
  void drawPixel(Pixel pixel, int strokeWeight){
    if (pixel.z > 0){
      for(int i = 0; i < strokeWeight; i++){
        for(int j = 0; j < strokeWeight; j++){
          if(pixel.y<=height&&pixel.y>0&&pixel.x>0&&pixel.x<=width){
            if((pixel.y-1+i)*width+pixel.x+j<pixels.length){
            pixels[(pixel.y-1+i)*width+pixel.x+j] = pixel.pixelColor;}
          }
        }
      }
    }
  }
  
  void drawQuad(Point point1, Point point2, Point point3, Point point4){
  //  connectPoints(point1, point2);
   // connectPoints(point2, point3);
    //connectPoints(point3, point4);
    //connectPoints(point4, point1);
  }
  
}
