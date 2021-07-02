void oscEvent(OscMessage m) {
  if (m.checkAddrPattern("/wek/outputs")==true){
    if (m.checkTypetag("f")) {
      int value = (int)m.get(0).floatValue();
      player.setPlayerState(value);
    } 
  }
}

//for testing with keyboard
void keyPressed() {
  switch(keyCode) {
  case UP:
    player.setPlayerState(1);
    break;
  case DOWN:
    player.setPlayerState(2);
    break;
  case LEFT:
    player.setPlayerState(3);
    break;
  case RIGHT:
    player.setPlayerState(4);
    break;
  case ' ':
    genObstacle((int)random(3)+1);
    break;
    
    case ENTER:
    if(phase ==0){
    phase++;
    }
    if(phase==2){
    phase=1;
    }
  }
}
