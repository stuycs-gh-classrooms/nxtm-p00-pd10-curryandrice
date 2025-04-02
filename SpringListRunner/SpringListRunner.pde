/* ===================================
 SpringListDriver (No Work Goes Here)
 
 This program will work similarly to SpringArrayDriver,
 but it will use a linked list of OrbNodes instead of
 an array. This driver file is complete, all your work should
 be done in the OrbList class. When working, the program can
 be controlled as follows:
 
 Keyboard commands:
 1: Create a new list of orbs in a line.
 2: Create a new list of random orbs.
 =: add a new node to the front of the list
 -: remove the node at the front
 SPACE: Toggle moving on/off
 g: Toggle earth gravity on/off
 
 Mouse Commands:
 mousePressed: if the mouse is over an
 orb, remove it from the list.
 =================================== */


int NUM_ORBS = 10;
int MIN_SIZE = 10;
int MAX_SIZE = 60;
float MIN_MASS = 10;
float MAX_MASS = 100;
float G_CONSTANT = 1;
float D_COEF = 0.1;

int SPRING_LENGTH = 50;
float  SPRING_K = 0.005;

int MOVING = 0;
int BOUNCE = 1;
int GRAVITY = 2;
int DRAGF = 3;
int CUSTOM = 4;
int SPRINGS = 5;
boolean[] toggles = new boolean[6];
String[] modes = {"Moving", "Bounce", "Gravity", "Drag", "Custom", "Springs"};

FixedOrb earth;
int orbCount;
OrbList slinky;
OrbNode[] orbs;

boolean dragsim;

void setup() {//orbs = array -- slinky = linked list
  size(600, 600);

  earth = new FixedOrb(width/2, height * 200, 1, 20000);
  orbCount = NUM_ORBS;
  orbs = new OrbNode[NUM_ORBS];
  for (int i = 0; i < orbs.length; i++) {
    orbs[i] = new OrbNode();
    if (i != 0) {
      orbs[i].previous = orbs[i-1];
    }
    if ( i != orbs.length-1) {
      orbs[i].next = orbs[i+1];
    }
  }
  slinky = new OrbList();
  slinky.populate(NUM_ORBS, true);
}//setup

void draw() {
  background(255);
  displayMode();
  if (dragsim) {
    fill(#FA4C57);
    rect(0, 0, width/2, height);
    fill(#487AF5);
    rect(width/2, 0, width, height);
  }
  if (!dragsim) {
    slinky.display();
  }
  for (int i = 0; i < orbs.length; i++) {
    if (orbs[i] != null) {
      PVector sf;
      orbs[i].display();
      //  orbs[i].display(SPRING_LENGTH);
      if (toggles[MOVING]) {
        if (toggles[GRAVITY]) {
          orbs[i].applyForce(orbs[i].getGravity(earth, G_CONSTANT));
        }
        if (toggles[SPRINGS]) {
          if (orbs[i].next != null) {
            sf = orbs[i].getSpring(orbs[i].next, SPRING_LENGTH, SPRING_K);
            orbs[i].applyForce(sf);
          }
          if (orbs[i].previous != null) {
            sf = orbs[i].getSpring(orbs[i].previous, SPRING_LENGTH, SPRING_K);
            orbs[i].applyForce(sf);
          }
        }
        orbs[i].move(toggles[BOUNCE]);
        if (toggles[DRAGF]) {
          if (dragsim) {
            if (orbs[i].center.x > width/2) {
              orbs[i].applyForce(orbs[i].getDragForce(D_COEF+0.1));
            } else {
              orbs[i].applyForce(orbs[i].getDragForce(D_COEF));
            }
          } else {
            orbs[i].applyForce(orbs[i].getDragForce(D_COEF));
          }
        }
      }
    }
  }
  if (toggles[MOVING]) {
    if (toggles[SPRINGS]) {
      slinky.applySprings(SPRING_LENGTH, SPRING_K);
    }
    if (toggles[GRAVITY]) {
      slinky.applyGravity(earth, GRAVITY);
    }

    slinky.run(toggles[BOUNCE]);
  }//moving
}//draw

void mousePressed() {
  OrbNode selected = slinky.getSelected(mouseX, mouseY);
  if (selected != null) {
    slinky.removeNode(selected);
  }
}//mousePressed

void keyPressed() {
  if (key == ' ') {
    toggles[MOVING] = !toggles[MOVING];
  }
  if (key == 'g') {
    toggles[GRAVITY] = !toggles[GRAVITY];
  }
  if (key == 'b') {
    toggles[BOUNCE] = !toggles[BOUNCE];
  }
  if (key == 'd') {
    toggles[DRAGF] = !toggles[DRAGF];
  }
  if (key == 'c') {
    toggles[CUSTOM] = !toggles[CUSTOM];
  }
  if (key == 's') {
    toggles[SPRINGS] = !toggles[SPRINGS];
  }
  if (key == '=' || key =='+') {
    slinky.addFront(new OrbNode());
  }
  if (key == '-') {
    slinky.removeFront();
  }
  if (key == '1') {//gravity sim -- hard, work on this later
  }
  if (key == '2') { //spring simulation
    for (int i = 0; i < orbs.length; i++) {
      orbs[i] = null;
    }
    dragsim = false;
    toggles[MOVING] = true;
    toggles[SPRINGS] = true;
    toggles[BOUNCE] = true;
    toggles[DRAGF] = false;
    toggles[GRAVITY] = false;
    toggles[CUSTOM] = false;
    slinky = new OrbList();
    OrbNode  add = new OrbNode(width/2+100, height/2, MAX_SIZE, 100);
    add.velocity = new PVector(-0.1, 0);
    slinky.addFront(add);
    add = new OrbNode(width/2, height/2, MAX_SIZE, 100);
    slinky.addFront(add);
  }
  if (key == '3') {//drag simulation
    for (int i = 0; i < orbs.length; i++) {
      orbs[i] = new OrbNode(0+100*i, height/2, MAX_SIZE, 100);
    }
    dragsim = true;
    toggles[MOVING] = true;
    toggles[SPRINGS] = false;
    toggles[BOUNCE] = true;
    toggles[DRAGF] = true;
    toggles[GRAVITY] = true;
    toggles[CUSTOM] = false;
    slinky = new OrbList();
    slinky.populate(1, true);
    fill(#FA4C57);
    rect(0, 0, width/2, height);
    fill(#487AF5);
    rect(width/2, 0, width, height);
  }
}//keyPressed


void displayMode() {
  textAlign(LEFT, TOP);
  textSize(20);
  noStroke();
  int spacing = 85;
  int x = 0;

  for (int m=0; m<toggles.length; m++) {
    //set box color
    if (toggles[m]) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }

    float w = textWidth(modes[m]);
    rect(x, 0, w+5, 20);
    fill(0);
    text(modes[m], x+2, 2);
    x+= w+5;
  }
}//display
