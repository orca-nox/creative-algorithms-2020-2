/*
Project #3 by Kris Jung (Jung Seung Hyun)
 
 Title: Mount Killmore 
 (Subtitle: Cumulative Apparition)
 
 What does evil look like? Merge and average the portraits of the most bloodthirsty villains of history.
 Uses copyright-free images from Wikimedia and other sources.
 Do note that this work only uses 17 portraits. There are controversies that revolve around many of these people,
 so please be aware that it may upset certain political ideologies.
 
 Process 1: Plane grid double arrays for 1. Single portraits (v), 2. Average (av), and 3. Buffers (bfv) are created.
 Process 2: Loads all the images and resizes them to 400*800.
 Process 3: Fills in the arrays for 1 and 2 through getValues() and getAverage().
 Process 4: The buffer array is the actually displayed grid, where buffer = (actual value - buffer)/10 + buffer. 
 This creates the animated effect of morphing.
 Process 5: The values are fed into draw(), where the colors and the size of the boxes depend on them.
 Process 6: 'a' to go to the next portrait, 'z' for previous, 's' for average, 'q' to start and quit slideshow mode (scroll).
 
 Press p to take a screenshot.
 
 Required external libraries:
 - PeasyCam
 
 */

import peasy.*;
PeasyCam cam;

PImage[] imgs; //picture array
int nPics = 18; //# of pictures
int[][] v; //values
int[][] av; //average values
int[][] bfv; //buffer values
int num = 0; //picture number

boolean averageMode = false;
boolean scroll = false;

void setup() {
  size(1000, 1000, P3D);
  background(10);
  stroke(255);
  fill(100);

  //load and resize images

  imgs = new PImage[nPics];
  for (int i = 0; i < nPics; i++) {
    imgs[i] = loadImage((i+1)+".jpg");
    imgs[i].resize(400, 800);
  }
  v = new int[imgs[0].height][imgs[0].width];
  bfv = new int[imgs[0].height][imgs[0].width];
  av = new int[imgs[0].height][imgs[0].width];

  //instantiate camera

  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(5000);

  //get v and average values;

  getValues(0);
  getAverage(0);

  noStroke();
}

void draw() {
  translate(-200, -375);
  background(10);
  randomSeed(123);

  if (averageMode == false) {
    for (int y = 0; y < imgs[num].height; y+=20) {
      for (int x = 0; x < imgs[num].width; x+=20) {
        pushMatrix();
        translate(x, y);
        bfv[y][x] = ((v[y][x] - bfv[y][x])/10)+bfv[y][x];
        fill(bfv[y][x]);
        box(bfv[y][x]/10);
        popMatrix();
      }
    }
  } else if (averageMode == true) {
    for (int y = 0; y < imgs[num].height; y+=20) {
      for (int x = 0; x < imgs[num].width; x+=20) {
        pushMatrix();
        translate(x, y);
        bfv[y][x] = ((av[y][x] - bfv[y][x])/10)+bfv[y][x];
        fill(bfv[y][x]);
        box(bfv[y][x]/10);
        popMatrix();
      }
    }
  }

  if (scroll == true && (frameCount % 60) == 0) {
    num++;
    if (num >= nPics) {
      num = 1;
    }
    getValues(num);
  }
}

void getValues(int img) {

  imgs[img].loadPixels();
  for (int y = 0; y < imgs[img].height; y++) {
    for (int x = 0; x < imgs[img].width; x++) {
      color pixel = imgs[img].pixels[y*imgs[img].width + x];
      v[y][x] = int(brightness(pixel));
    }
  }
}

void getAverage(int img) {

  for (int p = 1; p < nPics; p++) {
    for (int y = 0; y < imgs[p].height; y++) {
      for (int x = 0; x < imgs[p].width; x++) {
        color pixel = imgs[p].pixels[y*imgs[p].width + x];
        av[y][x] += int(brightness(pixel));
      }
    }
  }
  for (int y = 0; y < imgs[img].height; y++) {
    for (int x = 0; x < imgs[img].width; x++) {
      av[y][x] /= nPics;
    }
  }
}

void keyPressed() {

  switch(key) {
  case 'a':
    if (averageMode == false) {
      num++;
      if (num > nPics - 1) {
        num = 0;
      }
    }
    break;
  case 'z':
    if (averageMode == false) {
      num--;
      if (num < 0) {
        num = nPics - 1;
      }
    }
    break;
  case 's':
    if (averageMode == true) {
      averageMode = false;
    } else {
      averageMode = true;
    }
    break;
  case 'q':
    if (scroll == false) {
      scroll = true;
    } else {
      scroll = false;
    }
    break;
  case 'p':
    saveFrame();
  }

  getValues(num);
}
