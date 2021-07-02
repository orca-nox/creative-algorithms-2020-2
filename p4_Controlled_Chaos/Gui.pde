RadioButton r1, r2, r3, r4;

void gui() {


  cp5 = new ControlP5(this);

  Group g1 = cp5.addGroup("Color Picker")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(150)
    ;
  cp5.addColorWheel("col", 250, 100, 100 )
    .setRGB(color(255, 255, 254))
    .setPosition(10, 20)
    .setSize(100, 100)
    .moveTo(g1)
    ;

  Group g3 = cp5.addGroup("Gravity Controls")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(150)
    ;


  cp5.addSlider("verticalGravity")
    .setPosition(10, 20)
    .setSize(100, 20)
    .setRange(-0.1, 0.1)
    .setValue(0)
    .moveTo(g3)
    ;

  r1 = cp5.addRadioButton("verGravSwitch")
    .setPosition(10, 50)
    .setItemWidth(20)
    .setItemHeight(20)
    .addItem("Vertical Gravity Switch", 0)
    .setColorLabel(color(255))
    .activate(2)
    .moveTo(g3)
    ;
  cp5.addSlider("horizontalGravity")
    .setPosition(10, 80)
    .setSize(100, 20)
    .setRange(-0.1, 0.1)
    .setValue(0)
    .moveTo(g3)
    ;

  r2 = cp5.addRadioButton("horGravSwitch")
    .setPosition(10, 110)
    .setItemWidth(20)
    .setItemHeight(20)
    .addItem("Horizontal Gravity Switch", 0)
    .setColorLabel(color(255))
    .activate(2)
    .moveTo(g3)
    ;

  Group g4 = cp5.addGroup("Radial Gravity (experimental)")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(50)
    ;

  cp5.addSlider("centralGravity")
    .setPosition(10, 20)
    .setSize(100, 20)
    .setRange(0, 1)
    .setValue(0)
    .moveTo(g4)
    ;

  Group g5 = cp5.addGroup("Friction")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(20)
    ;

  cp5.addSlider("friction")
    .setPosition(10, 20)
    .setSize(100, 20)
    .setRange(0, 1)
    .setValue(1)
    .moveTo(g5)
    ;

  Group g6 = cp5.addGroup("Size Control")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(120)
    ;

  cp5.addSlider("size")
    .setPosition(10, 20)
    .setSize(100, 20)
    .setRange(1, 10)
    .setValue(0)
    .moveTo(g6)
    ;

  r3 = cp5.addRadioButton("multSpeed")
    .setPosition(10, 50)
    .setItemWidth(20)
    .setItemHeight(20)
    .addItem("Speed Multiplier", 0)
    .setColorLabel(color(255))
    .activate(2)
    .moveTo(g6)
    ;
    
  accordion = cp5.addAccordion("acc")
    .setPosition(0, 0)
    .setWidth(200)
    .addItem(g1)
    .addItem(g3)
    .addItem(g4)
    .addItem(g5)
    .addItem(g6)
    ;

  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.open(0, 1, 2, 3);
    }
  }
  , 'o');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.close(0, 1, 2, 3);
    }
  }
  , 'c');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.setWidth(300);
    }
  }
  , '1');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.setPosition(0, 0);
      accordion.setItemHeight(190);
    }
  }
  , '2'); 
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.setCollapseMode(ControlP5.ALL);
    }
  }
  , '3');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.setCollapseMode(ControlP5.SINGLE);
    }
  }
  , '4');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      cp5.remove("myGroup1");
    }
  }
  , '0');

  //accordion.open(0, 1, 2);
  accordion.setCollapseMode(Accordion.MULTI);
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(r1)) {
    if (verGravOn == true) {
      verGravOn = false;
    } else {
      verGravOn = true;
    }
  }
  if (theEvent.isFrom(r2)) {
    if (horGravOn == true) {
      horGravOn = false;
    } else {
      horGravOn = true;
    }
  }
    if (theEvent.isFrom(r3)) {
    if (multSpeed == true) {
      multSpeed = false;
    } else {
      multSpeed = true;
    }
  }
}

/*
void radio(int a) {
 switch(a) {
 case(0): 
 cpx = true; 
 break;
 default: 
 cpx = false; 
 break;
 }
 } 
 */
