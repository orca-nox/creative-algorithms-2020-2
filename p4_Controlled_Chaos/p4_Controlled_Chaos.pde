/*
Project #4 Generative Design System
 Title: Controlled Chaos
 
 Everything is predestined, even chaos.
 
 Process 1: Generate 10000 balls.
 
 These balls follow certain rules that are parameterized.
 
 Parameters (GUI)
 - col: Color of the particles. Simple.
 - cenGrav: The strength of a single radian gravity point. Min 0, max 1000 (Scaled to 0 to 1).
 - verGrav: Vertical gravity. Min -1, max 1. Can be turned off with verGravOn.
 - horGrav: Horizontal gravity. Min -1, max 1. Can be turned off with horGravOn.
 - friction: Friction. Min 0, max 1.
 - ballSize: The size of each ball. Min 1, max 10.
 - multSpeed: When turned on, the size of each ball becomes proportionate to its speed. It is multiplied by ballSize.
 
 Press any key to reset, but press 'p' to take a screenshot, 'a' to hide GUI, and 's' to show GUI.
 
 Required external libraries:
 - ControlP5
 
 */

import controlP5.*;

ControlP5 cp5;

Accordion accordion;

color col = color(255, 255, 255);
boolean cpx = false;

float maxSpeed = 10;

float cenGrav = 500; //central gravity

boolean verGravOn = false;
float verGrav = 0.01; //vertical gravity

boolean horGravOn = false;
float horGrav = -0.01; //horizontal gravity

float friction = 0.05;

int ballNum = 100;
float ballSize = 3;
boolean multSpeed = false;

Ball[][] balls;

Ball b1;
Ball b2;
Ball b3;
Ball b4;

void setup() {
  //frameRate(5);
  size(1000, 1000);
  noStroke();
  fill(255);
  balls = new Ball[ballNum][ballNum];
  for (int i = 0; i < ballNum; i++) {
    for (int j = 0; j < ballNum; j++) {
      balls[i][j] = new Ball(i*(1000/ballNum) + 500/ballNum, j*(1000/ballNum) + 500/ballNum, maxSpeed - i*(maxSpeed/(ballNum-1)) - j*(maxSpeed/(ballNum-1)), -j*(maxSpeed/(ballNum-1))+i*(maxSpeed/(ballNum-1)), ballSize);
    }
  }

  smooth(8);
  gui();
  background(0);
}

void draw() {
  //background(0);
  fill(0, 10);
  rect(0, 0, width, height);

  fill(50);

  //background(10);
  fill(255, 0, 0);
  //  circle(width/2, height/2, 3);

  //get values from GUI
  cenGrav = cp5.getController("centralGravity").getValue();
  cenGrav = cenGrav * 1000;
  verGrav = cp5.getController("verticalGravity").getValue();
  horGrav = cp5.getController("horizontalGravity").getValue();
  friction = cp5.getController("friction").getValue();
  friction = friction/10;

  fill(col);



  for (int i = 0; i < ballNum; i++) {
    for (int j = 0; j < ballNum; j++) {
      balls[i][j].updatePosition();
      balls[i][j].drawBall();
    }
  }


  fill(col);
  println(cpx);
}

void resetBalls() {
  for (int i = 0; i < ballNum; i++) {
    for (int j = 0; j < ballNum; j++) {
      balls[i][j] = new Ball(i*(1000/ballNum) + 500/ballNum, j*(1000/ballNum) + 500/ballNum, maxSpeed - i*(maxSpeed/(ballNum-1)) - j*(maxSpeed/(ballNum-1)), -j*(maxSpeed/(ballNum-1))+i*(maxSpeed/(ballNum-1)), ballSize);
    }
  }
}

void keyPressed() {
  if (key == 'p') {
    saveFrame();
  } else if (key == 'a') {
    cp5.hide();
  } else if (key == 's') {
    cp5.show();
  } else {
    resetBalls();
  }
}
