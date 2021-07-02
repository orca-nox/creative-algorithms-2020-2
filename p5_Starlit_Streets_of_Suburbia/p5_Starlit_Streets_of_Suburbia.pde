/*
Project #5 by Kris Jung (Jung Seung Hyun)
 
 Title: Starlit Streets of Suburbia
 
 A simple program that shows urban population rates according to
 country and year, borrowing the design idea from Arimura's work.
 Data taken from an article from Our World in Data, "How urban is
 the world?" by Hannah Ritchie.
 
 Process 1: Loads and parses data from csv file.
 Process 2: Create two object arrays for stars and street lights.
 Process 3: If the urban population ratio (urban population / total population)
 is above 50%, draw street lights. If not, draw star lights.
 Process 4: Animate using sine waves and buffers.
 Process 5: Write text.
 
 Press p to take a screenshot.
 UP and DOWN to change country, and RIGHT and LEFT to change year. Note that this
 is not always consistent, as there are a few missing fields in the raw data.
 It is not a major problem, nonetheless.
 
 */

PFont font;

int row = 0; //World
Table table;

String country;
int year;
String code;
int rPop; //rural population
int uPop; //urban population
float perc;
float bPerc;

int rs;

int starNum = 8000;

Light[] light;
Light[] star;

void setup() {
  size(800, 1000);
  noStroke();
  font = createFont("sf.otf", 32);
  textFont(font);
  table = loadTable("data.csv", "header");

  light = new Light[starNum];
  star = new Light[starNum];

  for (int i = 0; i < starNum; i++) {
    light[i] = new Light(random(width), height + 20, height, 8);
    star[i] = new Light(random(width), -20, 0, 3);
  }

  update();
}

void draw() {

  background(15);
  bPerc = ((perc - bPerc)/10)+bPerc;
  fill(255);
  for (int i = 0; i < starNum; i++) {
    light[i].shine();
    star[i].shine();
  }

  fill(255);
  textAlign(CENTER);
  textSize(20);
  text(country + ", " + year, width/2, height/2 - 15);
  textSize(10);
  text(nf(bPerc, 0, 2) + "%", width/2, height/2 + 15);
}

void update() {
  country = table.getString(row, 0);
  code = table.getString(row, 1);
  year = table.getInt(row, 2);
  rPop = table.getInt(row, 3);
  uPop = table.getInt(row, 4);
  perc = (float(uPop)*100)/(float(rPop)+float(uPop));

  randomSeed(int(str(byte(code.charAt(0)))+str(byte(code.charAt(1)))+str(byte(code.charAt(2)))));

  for (int i = 0; i < starNum; i++) {
    star[i].pos.y = -20;
  }
  for (int i = 0; i < starNum; i++) {
    light[i].pos.y = height + 20;
  }

  if (perc < 50) {
    for (int i = 0; i < (100-perc)*30; i++) {
      star[i].pos.y = abs(randomGaussian())*150;
    }
  } else {
    for (int i = 0; i < perc*60; i++) {
      light[i].pos.y = height - abs(randomGaussian())*150;
      light[i].realsize = light[i].size * light[i].pos.y/1000;
    }
  }
}

void keyPressed() {
  switch(keyCode) {
  case UP:
    row += 58;
    break;
  case RIGHT:
    row += 1;
    break;
  case LEFT:
    row -= 1;
    break;
  case DOWN:
    row -= 58;
    break;
  }

  switch(key) {
  case 'p':
    saveFrame();
  }

  if (row < 0) {
    row = 0;
  } else if (row > table.getRowCount() - 1) {
    row = table.getRowCount() - 1;
  }

  update();
}
