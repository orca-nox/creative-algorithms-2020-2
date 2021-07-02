class Fire {

  String todo;
  float dist;
  float rad;
  float theta;

  Fire(String s, float d, float t, float r) {
    todo = s;
    dist = d; 
    theta = t;
    rad = r;
  } 

  void render() {

    for (int i = 0; i < todo.length(); i++) {
      char c = todo.charAt(i);

      switch(c) {
      case 'F':
        circle(0, 0, rad);
        translate(dist, 0);
        break;
      case 'G':
        translate(dist, 0);
        break;
      case '+':
        rotate(theta);
        break;
      case '-':
        rotate(-theta);
        break;
      case '[':
        pushMatrix();
        break;
      case ']':
        popMatrix();
        break;
      }
    }
  }

  void setDist(float l) {
    dist = l;
  } 

  void changeRad(float percent) {
    rad *= percent;
  }

  void setToDo(String s) {
    todo = s;
  }

  void resetTo(String s, float d, float t, float r) {
    todo = s;
    dist = d; 
    theta = t;
    rad = r;
  }
}
