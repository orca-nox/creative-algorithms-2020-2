/*
Project #6 by Kris Jung (Jung Seung Hyun)
  
  Title: Senko Hanabi (せんこうはなび、線香花火)
  
  Fireworks? Fireworks. Fireworks? Japan.
  The good old bubble days, the heydays of Japanese //Aesthetics//.
  In true 4:3 fashion.

  Processes:
    - The Particle class creates particle objects.
    - A Rod object is created whenever the mouse is clicked.
    - The Rod object constructs Particle objects.
    - The Rod object controls where particles are created, and when to stop.
    - Rods are drawn, with UI on top.
    
Press space to turn auto-mode on or off.
Press p to take a screenshot as a png file.
Hold control to posterize.
Hold shift to blur.

*/


let rods = [];
let rangeMin = 0;
let rangeMax = 10;
let phase = 0;
let auto = false;
let interval = 25;


function setup() {
  createCanvas(800, 600);
  background(100);
  colorMode(HSB, 100);
  smooth(8);
  textAlign(CENTER);
}

function draw() {
  textAlign(CENTER);
  noStroke();
  fill(70, 100, 10);
  rect(0, 0, width, height)
  if (phase == 0) {
    fill(100);
    textSize(32);
    text("せんこうはなび", width / 2, height / 2 - 50);
    textSize(12);
    text("クリス・テイ　１９９８", width / 2, height / 2 - 20)
    textSize(12);
    text("画面をクリックして下さい", width / 2, height / 2 + 70);
  } else {
    for (i = 0; i < rods.length; i++) {
      rods[i].draw();
    }
    fill(0);
    noStroke();
    rect(0, height - 30, width, height);
    if (auto == true) {
      if (frameCount % interval == 0) {
        rods[rods.length] = new Rod(rods.length, random(50, width - 50), random(100, height - 200));
      }
      fill(25, 100, 100);
      text("オートモード：オン", width / 2, height - 10);
    } else {
      fill(4, 100, 100);
      text("オートモード：オフ", width / 2, height - 10);
    }
    textAlign(LEFT);
    fill(100);
    text("スペースでオートモード転換", 10, height - 10);
    textAlign(RIGHT);
    text("ｐキーでスクリーンショット", width - 10, height - 10);
  }

  if (keyIsDown(CONTROL) === true) {
    filter(POSTERIZE, 2);
  }
  if (keyIsDown(SHIFT) === true) {
    filter(BLUR, 1);
  }
}

function mousePressed() {
  rods[rods.length] = new Rod(rods.length, mouseX, mouseY);
  if (phase == 0) {
    phase = 1;
  }

}

function keyPressed() {
  switch (key) {
    case 'p':
      save();
      break;
    case 'P':
      save();
      break;
    case ' ':
      if (auto == false) {
        auto = true;
      } else {
        auto = false;
      }
      if (phase == 0) {
        phase = 1;
      }
  }
}