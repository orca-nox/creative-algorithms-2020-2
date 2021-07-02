class Ball {
  PVector pos;
  PVector vel;
  float r;

  Ball (float bx, float by, float bvx, float bvy, float br) {
    pos = new PVector(bx, by);
    vel = new PVector(bvx, bvy);
    r = br;
  }

  int intXPos() {
    return int(pos.x);
  }

  int intYPos() {
    return int(pos.y);
  }

  /*
  void updateGrid(){
   bgrid[int(pos.y - 1)][int(pos.x - 1)] = 1;
   }
   */

  float distance(PVector ball, PVector grav) {
    return sqrt(((ball.x-grav.x)*(ball.x-grav.x))+((ball.y-grav.y)*(ball.y-grav.y)));
  }

  PVector pointGrav(PVector ball) {
    PVector direction = new PVector(width/2 - ball.x, height/2 - ball.y);
    direction.normalize();
    float d = distance(ball, new PVector(width/2, height/2));

    direction.mult(cenGrav/(d*d));

    return direction;
  }

  void updatePosition() {

    if (pos.x < 0) {
      vel.x = -vel.x;
      pos.x = 0;
    } else if (pos.x > width) {
      vel.x = -vel.x;
      pos.x = width;
    }
    if (pos.y < 0) {
      vel.y = -vel.y;
      pos.y = 0;
    } else if (pos.y > height) {
      vel.y = -vel.y;
      pos.y = height;
    }


    //vertical gravity
    if (verGravOn == true) {
      vel.y += verGrav;
    }

    //horizontal gravity
    if (horGravOn == true) {
      vel.x += horGrav;
    }



    /*
    //central gravity
     if (x < width/2) {
     xv += cenGrav;
     } else if (x > width/2) {
     xv -= cenGrav;
     }
     if (y < height/2) {
     yv += cenGrav;
     } else if (y > height/2) {
     yv -= cenGrav;
     }
     */

    //friction
    if (vel.x > 0) {
      vel.x -= friction;
    } else if (vel.x < 0) {
      vel.x += friction;
    }
    if (vel.y > 0) {
      vel.y -= friction;
    } else if (vel.y < 0) {
      vel.y += friction;
    }

    //limiter
    if (vel.x > maxSpeed) {
      vel.x = maxSpeed;
    }
    if (vel.y > maxSpeed) {
      vel.y = maxSpeed;
    }

    PVector gravity = pointGrav(pos);
    PVector velgrav = vel;
    velgrav.add(gravity);
    pos.add(velgrav);
  }

  void updateVelocity() {
  };

  void drawBall() {
    ballSize = cp5.getController("size").getValue();
    if (multSpeed == true){
    circle(pos.x, pos.y, (vel.x + vel.y)*ballSize/10);
    } else {
      circle(pos.x, pos.y, ballSize);
    }
  }

  void removeCheck() {
  }
}
