
//REMINDER: The "Up" type obstacle will be dodged by "crouch".

class Obstacle {
  int type; //1 = Up, 2 = Right, 3 = Left
  PVector position;//position of the obstacle
  int index;//index for obstacles arraylist
  float rotation = 0;

  Obstacle(int t, int i) {
    type = t;
    index = i;
    switch(t){
      case 1://Up
        position = new PVector(0, -60, 100);
        break;
      case 2://Right
        position = new PVector(-20, -40, 100);
        break;
      case 3://Left
        position = new PVector(20, -40, 100);    
    }
  }

  boolean onHit(float playerPosition) { //what happens when the player fails to dodge the obstacle?
  //bring playerPosition as an input parameter
  //if obstacle position equals to player position -> return true
  //else return false
  
    if(playerPosition == position.x){
      if(position.z == -200){
        if(type == 1){
          if(player.playerState == "crouch") return false;
          else return true;
        }else return true;
      }
    }
    return false;
  }

  void update(){
  //update position of obstacle
    position.z -= speed;
    rotation += 0.05;
    if (position.z < -300) {
      //if it passes over the player, delete
      delete();
    }
  }
  
  void display(){
    pushMatrix();
    fill(255, 233, 110);
    stroke(255);
    translate(position.x, position.y, position.z);
    rotateY(rotation);
    sphereDetail(2);//parameter : shape of sphere
    sphere(10); // this is the obstaclemodel (temporary), parameter : size of sphere
    popMatrix();
  }

  void delete() { //delete self
    if(indexer<indexer_tail){//if there is any element in arraylist
      //obstacles.remove(index);
      indexer++;
    }
  }
}
