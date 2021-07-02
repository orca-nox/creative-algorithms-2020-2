/*
Project #8 by Kris Jung (Jung Seung Hyun)

 Title: Flick
 
 There is one and one control only: flick your phone.
 Difficulty depends on either if you're using the accelerometer
 or the gyro.
 
 Process 1: Get osc messages from motion sender (iOS app).
 Process 2: Draw paddle according to received osc coordinates.
 Process 3: Forward motion sender osc message to wekinator to
 train what a 'flick' is.
 Process 4: Receive osc message if 'flick' is true.
 Process 5: Instantiate ball, and make it bounce if 'flick' is true
 at the right timing.
 Process 6: Decorate,
 
 Flick to start game.
 Flick to play game.
 Flick to restart game.
 Press p to take a screenshot.
*/

import processing.sound.*;
import oscP5.*;
import netP5.*;

SoundFile sfxSwitch;
SoundFile sfxBounce;
OscP5 motionSender;
OscP5 wekReceive;
NetAddress wekSendAddr;

float rotX;

int lenX = 30;
int lenY = 10;
int lenZ = 50;

float flickspeed;
boolean flick = false;
int counter = 0;

boolean gameover = false;

int score = 0;
int hiscore = 0;
int phase = 0;

Ball ball;

void setup() {
  size(360, 640, P3D);
  background(10);

  sfxSwitch = new SoundFile(this, "switch.mp3");
  sfxBounce = new SoundFile(this, "ballhit.mp3");

  motionSender = new OscP5(this, 6448);
  wekReceive = new OscP5(this, 12000);
  wekSendAddr = new NetAddress("127.0.0.1", 12001);

  ball = new Ball(0, 20);

  stroke(255);
  fill(0);
  sphereDetail(8, 8);

  textAlign(CENTER);
}

void draw() {

  if (phase == 0) {
    background(10);
    fill(255);
    text("Flick", width/2, height/2);
    text("By Seung Hyun (Kris) Jung", width/2, height - 20);
  } else if (phase == 1) {
    textAlign(CENTER);
    if (gameover == false) {
      background(255);

      pushMatrix();
      translate(width/2, height/2 + 150);

      pushMatrix();
      rotateX(rotX);
      rotateY(-0.2);
      stroke(255);
      fill(0);
      drawBox();

      popMatrix();
      translate(lenX/2, 0, -30);
      noStroke();
      ball.update();
      ball.draw();
      popMatrix();
      text(score, width/2, height/2);
    } else {
      background(10);
      stroke(255);
      fill(0);
      pushMatrix();
      translate(width/2, height/2 + 150);

      rotateX(rotX);
      rotateY(-0.2);
      drawBox();

      popMatrix();
      fill(255);
      text(score, width/2, height/2);
      textAlign(RIGHT);
      text("Hiscore: " + hiscore, width-20, height-20);
    }

    if (counter < 0) {
      flick = false;
    }
    counter--;
  }
}

void drawBox() {
  //Draw box
  beginShape(QUADS);
  //top
  if (flick == true) {
    fill(255, 0, 0);
  } else {
    fill(0);
  }
  vertex(-lenX/2, -lenY/2, 0);
  vertex(lenX/2, -lenY/2, 0);
  vertex(lenX/2, -lenY/2, -lenZ);
  vertex(-lenX/2, -lenY/2, -lenZ);
  //front
  fill(0);
  vertex(-lenX/2, -lenY/2, 0);
  vertex(lenX/2, -lenY/2, 0);
  vertex(lenX/2, lenY/2, 0);
  vertex(-lenX/2, lenY/2, 0);
  //right
  vertex(lenX/2, -lenY/2, 0);
  vertex(lenX/2, -lenY/2, -lenZ);
  vertex(lenX/2, lenY/2, -lenZ);
  vertex(lenX/2, lenY/2, 0);
  //bottom
  vertex(-lenX/2, lenY/2, 0);
  vertex(lenX/2, lenY/2, 0);
  vertex(lenX/2, lenY/2, -lenZ);
  vertex(-lenX/2, lenY/2, -lenZ);
  endShape();
}

void oscEvent (OscMessage m) {

  if (m.checkAddrPattern("/wek/inputs")) {
    OscMessage wekMessage = new OscMessage("/p5");
    wekMessage.add(m.get(3).floatValue());
    motionSender.send(wekMessage, wekSendAddr);
    rotX = - m.get(3).floatValue();
    flickspeed = m.get(0).floatValue();
  }
  if (m.checkAddrPattern("/output_1")) {
    if (phase == 0) {
      phase = 1;
      sfxSwitch.play();
    }
    if (counter < 0) {
      flick = true;
      counter = 10;
    }
    if (phase == 1 && gameover == true) {
      gameover = false;
      ball.reset();
      sfxSwitch.play();
    }
  }
}
