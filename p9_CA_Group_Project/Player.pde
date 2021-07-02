class Player {
  String playerState;
  float position;//x position
  float positionBuffer;
  float yposition;
  float ypositionBuffer;
  float rotation;
  Player() {
    playerState = "idle";
    position = 0;
    rotation = 0;
    yposition = -40;
    ypositionBuffer = -60;
  }

  void setPlayerState(int state) {
    switch(state) {
    case 1:
      playerState = "idle";
      position = 0;
      yposition = -40;
      break;
    case 2:
      playerState = "crouch";
      position = 0;
      yposition = 0;
      break;
    case 3:
      playerState = "leftLunge";
      position = 20;
      yposition = 0;
      break;
    case 4:
      playerState = "rightLunge";
      position = -20;
      yposition = 0;
      break;
    }
  }

  void update() {
    rotation += 0.01;
    positionBuffer = ((position - positionBuffer)/10) + positionBuffer; //smooth position animation
    ypositionBuffer = ((yposition - ypositionBuffer)/10) + ypositionBuffer;
  }

  void display() {
    pushMatrix();
    fill(110, 255, 214);
    stroke(255);
    translate(positionBuffer, ypositionBuffer-20, -200);
    sphereDetail(2);
    rotateY(rotation);
    sphere(10); // this is the playermodel (temporary)
    popMatrix();
  }
}
