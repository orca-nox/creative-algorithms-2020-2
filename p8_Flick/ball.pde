class Ball {
  float pos;
  float vel;
  float grav;
  float m;

  Ball (float p, float v) {
    pos = p;
    vel = v;
    grav = 0.5;
  }

  void update() {
    vel -= grav;
    pos += vel;
    if (pos < 30 && pos > 0 && vel < 0) {
      if (flick == true) {
        bounce();
      }
    }
    if (-pos + height/2 + 150 > height) {
      gameover = true;
      sfxSwitch.play();
      
      if(score > hiscore){
        hiscore = score;
      }
    }
    m++;
  }

  void draw() {
    translate(0, -pos);
    rotateX(-m/10);
    sphere(7);
  }

  void bounce() {
    vel = -vel;
    vel += flickspeed;
    score++;
    sfxBounce.play();
  }

  void reset() {
    pos = 0;
    vel = 20;
    score = 0;
  }
}
