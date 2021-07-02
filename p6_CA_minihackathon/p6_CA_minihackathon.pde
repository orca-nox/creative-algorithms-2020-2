import peasy.*;
PeasyCam cam;

int rs;
float counter = 0;
float newRect = 0;

void setup() {
  size(1000, 1000, P3D);
  background(10);
  stroke(255);
  noFill();
  smooth(8);

  //instantiate camera

  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(5000);
  randomSeed(rs);
  rectMode(CENTER);
  frameRate(60);
}

void draw() {
  rotateX(3);
  rotateY(3);
  counter++;
  cam.setDistance(frameCount*10000);
  background(0);
  stroke(255);
  newRect = counter;
  
  for (int i = 0; i < 500; i++) {
    strokeWeight(5+i/10);
    rotateZ(counter/50000);
    rect(0, 0, 5 * i + newRect/50, 5 * i + newRect/50);
  }
  println(frameRate);
}

void keyPressed() {

  switch(key) {
  case 'p':
    saveFrame();
  }

}
