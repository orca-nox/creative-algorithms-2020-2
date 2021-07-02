/*
Project #2 by Kris Jung (Jung Seung Hyun)
 
 Title: Pulseworks
 
 They look like fireworks, and leaves a slight trace. Also, they repeat in different colors. Isn't that pretty?
 Heavily modified the code from Daniel Shiffman, who created the framework for the L-system.
 
 Process 1: A new ruleset is created, with 'F' as the axiom and "G[+F][-F]" as the rule.
 Process 2: The ruleset is used to create the next sentence via the L-system. A temporary stringBuffer variable named nextgen is used to
 replace the axiom with corresponding rules by appending. Here, ruleset[i].getA fetches the axiom, and ruleset[j].getB fetches the rule.
 Process 3: When the entire sentence is parsed, the nextgen stringBuffer replaces the sentence.
 Process 4: The new sentence is then fed to the Fire class, where it parses the sentence to draw via render(). In this work, it starts with a circle.
 Process 5: The circle becomes smaller by a coefficient of 0.8, but multiplies by two (because of the L-system), and translating upwards by 50,
 and rotating by a certain random theta. Then, the canvas is blurred by a gaussian coefficient of 1.
 Process 6: This step happens 12 times, until it is reset. While it is possible to do more steps, it becomes quite laggy. (14 steps: 8 FPS)
 
 Color process: The color starts at a rgb values of a random between 150 and 255 each. Then, three more random coefficients are generated for each value.
 Every time the next step is taken, every rgb value is added/subtracted by the coefficient multiplied by the step counter.
 
 Press p to take a screenshot.
 
 */

LSystem lsys;
Fire fire;
Rule[] ruleset = new Rule[1];

int frame = 0;
int counter = 0;

float rcolor = random(150, 255);
float gcolor = random(150, 255);
float bcolor = random(150, 255);

float rCof = random(-1, 1);
float gCof = random(-1, 1);
float bCof = random(-1, 1);

void setup() {
  size(1000, 1000, P2D);
  background(10);


  ruleset[0] = new Rule('F', "G[+F][-F]");
  lsys = new LSystem("F", ruleset);
  fire = new Fire(lsys.getSentence(), 50, radians(random(10, 20)), 100);
  smooth(8);
  stroke(255);
}



void draw() {
  //  background(0);
  println(frameRate);
  noStroke();
  fill(0, 10);
  rect(0, 0, width, height);

  translate(width/2, height-200);
  rotate(PI*3/2);


  fill(rcolor, gcolor, bcolor);
  fire.render();


  if (frame > 15) {
    if (counter < 13) {
      lsys.generate();
      rcolor = rcolor + rCof*counter;
      gcolor = gcolor + gCof*counter;
      bcolor = bcolor + bCof*counter;
      fire.setToDo(lsys.getSentence());
      fire.changeRad(0.8);
      counter++;
      filter(BLUR, 1);
    } else {
      lsys.resetTo("F", ruleset);
      fire.resetTo(lsys.getSentence(), 50, radians(random(25)), 100);
      counter = 0;

      rcolor = random(150, 255);
      gcolor = random(150, 255);
      bcolor = random(150, 255);

      rCof = random(-1, 1);
      gCof = random(-1, 1);
      bCof = random(-1, 1);
    }
    frame = 0;
  }

  frame++;

  //  filter(BLUR, 1);
}




void keyPressed() {
  if (key == 'p') {
    saveFrame();
  }
}
