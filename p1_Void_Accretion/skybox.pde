class Skybox {
  float x, y, z;
  color c;
  Skybox(float _x, float _y, float _z, color _c) {
    x = _x;
    y = _y;
    z = _z;
    c = _c;
  }

  void shine() {
    stroke(c);
    point(x, y, z);
  }
}

void universate() {    //DRAWS THE SKYBOX
  b = new Skybox[10000];
  for (int i = 0; i < b.length; i++) { //HARD-CODED COLOURS
    color d;
    if (i < b.length/6) {
      d = color(255);
    } else if (i >= b.length/6 && i < b.length/3) {
      d = color(#FFF5F5);
    } else if (i >= b.length/3 && i < b.length/2) {
      d = color(#E8F9FF);
    } else if (i >= b.length/2 && i < b.length*2/3) {
      d = color(#D1D6FF);
    } else if (i >= b.length*2/3 && i < b.length*5/6) {
      d = color(#F2FFFF);
    } else {
      d = color(#FFFEF7);
    }
    b[i] = new Skybox(random(-width*4, width*4), random(-width*4, width*4), random(-width*4, width*4), d);
  }
}
