class Light {
  PVector pos;
  boolean v;
  int brightness;
  float offset;

  float bposy;
  float size;
  float realsize;

  Light (float bx, float by, float bp, int sl) {
    bposy = bp;
    pos = new PVector(bx, by);
    offset = by/100;
    realsize = random(sl);
    size = realsize;
    
  }

  void shine() {
    bposy = ((pos.y - bposy)/100)+bposy;
    circle(pos.x, bposy + sin(offset)*5, realsize);
    offset += 0.01;
  }
}
