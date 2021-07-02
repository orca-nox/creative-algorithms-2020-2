//we can refactor this into one class to shorten the code (just draw all three tiles at once)
//but then we might want to make them special... so there's three separate classes for now.

class LaneTile {
  float xPos;
  float yPos;
  float zPos;
  float sizeX;
  float sizeY;
  float sizeZ;

  void update() {
    zPos -= speed;
    if (zPos < -300) {
      zPos = 690; //not exactly sure why there's a 10 pixel discrepancy...
    }
  }

  void display(color objectColor) {
    pushMatrix();
    stroke(110, 255, 214);
    fill(0);
    translate(xPos, yPos, zPos);
    box(sizeX, sizeY, sizeZ);
    popMatrix();
  }
}

class CenterLaneTile extends LaneTile {
  CenterLaneTile(float z) {
    zPos = z;
    yPos = 0;
    xPos = 0;
    sizeX = 100;
    sizeY = 10;
    sizeZ = 90;
  }
}

class LeftLaneTile extends LaneTile {
  LeftLaneTile(float z) {
    zPos = z;
    xPos = 50;
    yPos = -40;
    sizeX = 10;
    sizeY = 10;
    sizeZ = 90;
  }
}

class RightLaneTile extends LaneTile {
  RightLaneTile(float z) {
    zPos = z;
    xPos = -50;
    yPos = -40;
    sizeX = 10;
    sizeY = 10;
    sizeZ = 90;
  }
}
