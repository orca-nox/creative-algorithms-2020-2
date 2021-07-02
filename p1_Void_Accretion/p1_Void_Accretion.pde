/*
Project #1 by Kris Jung (Jung Seung Hyun)
 
Title: Void Accretion
 
A massively simplified model of a black hole (without time-space dilation).
The shrinking and widening of the accretion disk creates the illusion of spinning.
Also, it pulsates due to the recursiveness.
 
This program uses recursive randoms (the random seed is used to create the next random seed).
The randoms take care of the width and color (gaussian) of the ellipses, and generates the next random seed (uniform).

While ellipses are technically arcs with a range of 0 to 2*PI, I have still left the version using arc() instead of ellipse().

Press p to take a screenshot.

Required external libraries:
- PeasyCam
 
 */

import peasy.*;
PeasyCam cam;
Skybox [] b; //skybox

int rs = 0;
float rand1;
float rand2;

float rX = 0;
float rY = 0;
float rZ = 0;

int planetSize = 0;

int ringNum = 200;
int arcNum = 100;

float arcRand;


void setup() {
  size(800, 800, P3D);
  background(0);
  noFill();
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(150);
  cam.setMaximumDistance(5000);

  universate();
  smooth(8);
}

void draw() {
  background(0, 2, 10);
  rs = int(random(0, 5000000));
  randomSeed(rs);
  rotateX(rX/800);
  rotateY(rY/900);
  rotateZ(rZ/1000);
  rX++;
  rY++;
  rZ++;

  for (int j = 0; j < ringNum; j++) {
    rand1 = randomGaussian();
    rand2 = randomGaussian();
    translate(0, 0, rand2/1000);
    stroke(200+100*rand1, 200+100*rand2, 200+100*rand2);
    arc(0, 0, 100 + rand1 * 5, 100 + rand1 * 5, 0, 2*PI);
    //ellipse(0, 0, 100 + rand1 * 5, 100 + rand1 * 5);
  }

  /*
  pushMatrix();
   planetSize = int(random(10, 40));
   for (int i = 0; i < arcNum; i++) {
   rotateX(random(0, 10));
   rotateY(random(0, 10));
   rotateZ(random(0, 10));
   arc(0, 0, planetSize, planetSize, 0, PI);
   }
   popMatrix();
   */
   
  fill(0);
  noStroke();
  sphere(10);
  noFill();
  
  for (int i = 0; i < b.length; i++) {    
    b[i].shine();
  }
}

void keyPressed() {
  if (key == 32) {
    rs = millis();
  } else if (key == 80 || key == 112) {
    saveFrame();
  }
}
