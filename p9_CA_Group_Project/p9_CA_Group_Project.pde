/*
 Project #10
 
 Title: Let's Run
 
 A simple game that utilizes Wekinator and motionSender.
 */

import peasy.*;
import processing.sound.*;
import netP5.*;
import oscP5.*;
SoundFile file;
//Camera
PeasyCam cam;

//Osc
OscP5 oscP5;
NetAddress oscAddress;

PImage i1;
PImage i2;
int hue=163;
int a;

//UI
color UITextColor;
color titleTextColor;

//Game Mechanics
//colors
color bgColor = color(0);
color laneColor = color(192, 184, 166);
color sideLaneColor = color(237, 222, 201);
color playerColor = color(114, 113, 103);
color obstacleColor = color(114, 113, 103);

//variables
float speed = 5;

float life = 100;
float lifeBuffer = life; //for smooth transitions

int phase = 0; //for title screen, game over screen, etc. 0 = title, 1 = main game, 2 = game over
boolean phaseFlag = false;//phase moving buffer to show 

ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
int indexer = 0; 
int indexer_tail = -1;
int genrate = 60;
int gen = 0;
//assign this to obstacle objects to delete them later.
//obstacles arraylist will be used as a queue.
//indexer points output point of the queue, tail points the input point of the queue.

Player player;
CenterLaneTile[] centerLaneTiles = new CenterLaneTile[10];
LeftLaneTile[] leftLaneTiles = new LeftLaneTile[10];
RightLaneTile[] rightLaneTiles = new RightLaneTile[10];

void setup() {
  size(400, 800, P3D);
  background(bgColor);

  oscP5 = new OscP5(this, 12000);

  //Camera Setup
  cam = new PeasyCam(this, 100);
  cam.setActive(false); //set this to true if you want to move the camera with the mouse
  cam.lookAt(0, -20, 0); 
  cam.setRotations(-0.2, PI, 0);
  cam.setDistance(300);

  player = new Player();
  for (int i = 0; i < 10; i++) {
    centerLaneTiles[i] = new CenterLaneTile(i*100);
    leftLaneTiles[i] = new LeftLaneTile(i*100);
    rightLaneTiles[i] = new RightLaneTile(i*100);
  }
  smooth(8);
  /////yewon
  i1=loadImage("title.png");
  i2=loadImage("dead.png");
}

void draw() {
  a+=0.01;
  float o = sin(a);
  println(o);
  float mapped = map(hue, -1, 1, 0, 360);
  if (phase == 0) {
    pushMatrix();
    scale(0.5);
    rotateY(radians(180));
    image(i1, -width/2, -height/2, width, height);
    popMatrix();
  }

  if (phase == 1) {//in game
    background(bgColor);
    ///
    pushMatrix();
    noFill();
    translate(0, -100, 800);
    for (int i=0; i<100; i++) {
      translate(0, 0, -20);
      stroke(mapped, 255, 214);
      ellipse(0, 0, 250, 250);
    }
    popMatrix();
    strokeWeight(1);

    //draw background image
    pushMatrix();
    translate(0, 0, 500);
    fill(bgColor);
    box(1000, 1000, 1);
    popMatrix();

    if (!phaseFlag) {
      //lane tiles
      for (int i = 0; i < 10; i++) {
        centerLaneTiles[i].update();
        centerLaneTiles[i].display(laneColor);
        leftLaneTiles[i].update();
        leftLaneTiles[i].display(sideLaneColor);
        rightLaneTiles[i].update();
        rightLaneTiles[i].display(sideLaneColor);
      }

      //player
      player.update();
      player.display();

      //generate obstacles 
      //increase genrate to slow down, or decrease genrate to speed up
      if (gen == genrate) {
        genObstacle((int)random(1, 4));
        gen = 0;
      } else {
        gen++;
      }

      //obstacles - die checking
      if (indexer<=indexer_tail) {
        for (int i = indexer; i<=indexer_tail; i++) {
          //check alive obstacles
          obstacles.get(i).update();
          obstacles.get(i).display();
          if (obstacles.get(i).onHit(player.position)) {
            if (life>=20) {
              life -= 20;
            }
            if (life==0) {//die
              phaseFlag = true;
            }
          }
        }
      }
    } else {//if player died, do not update but display objects
      for (int i = 0; i < 10; i++) {
        centerLaneTiles[i].display(laneColor);
        leftLaneTiles[i].display(sideLaneColor);
        rightLaneTiles[i].display(sideLaneColor);
      }
      player.update();//update player due to the player buffer
      player.display();
      if (indexer<=indexer_tail) {
        for (int i = indexer; i<=indexer_tail; i++) {
          obstacles.get(i).display();
        }
      }
    }

    //HUD
    cam.beginHUD();
    noStroke();
    fill(playerColor);
    rect(30, height-40, 150, 10); //max life possible
    fill(230);
    lifeBuffer = ((life - lifeBuffer)/10) + lifeBuffer;
    rect(30, height-40, lifeBuffer*1.5, 10); //current life
    cam.endHUD();

    if (phaseFlag && (life - lifeBuffer <= 0.05) && (player.position - player.positionBuffer) <= 0.05) {
      phase++;
    }
  }

  if (phase == 2) {
    pushMatrix();
    scale(0.5);
    rotateY(radians(180));
    image(i2, -width/2, -height/2, width, height);
    popMatrix();

    for (int i = indexer_tail; i>=0; i--) {
      obstacles.remove(i);
    }

    indexer = 0;
    indexer_tail = -1;
    phaseFlag = false;
    gen = 0;
    life = 100;
  }
}

void genObstacle(int type) { //generate obstacle, push one Obstacle to arraylist obstacles
  indexer_tail++;
  obstacles.add(new Obstacle(type, indexer_tail));
}
