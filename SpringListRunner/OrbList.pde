/*===========================

  Class to represent a Linked List of OrbNodes.

  Instance Variables:
    OrbNode front:
      The first element of the list.
      Initially, this will be null.

 
  =========================*/

class OrbList {

  OrbNode front;

  /*===========================
    Contructor
    =========================*/
  OrbList() {
    front = null;
  }//constructor

  /*===========================
    addFront(OrbNode o)

    Insert o to the beginning of the list.
    =========================*/
  void addFront(OrbNode o) {
    if (front == null){
      front = o;
    }
    else{
     OrbNode current = front;
     front = o;
     front.next = current;
      while (current.next != null){
        current = current.next;
      }
     // current.next = o;
     
    }
    
  }//addFront


  /*===========================
    populate(int n, boolean ordered)

    Clear the list.
    Add n randomly generated  orbs to the list,
    using addFront.
    If ordered is true, the orbs should all
    have the same y coordinate and be spaced
    SPRING_LEGNTH apart horizontally.
    =========================*/
  void populate(int n, boolean ordered) {
    front = null;
    if (ordered){
     for (int i = 0; i < n; i++){
       OrbNode add = new OrbNode(i*SPRING_LENGTH,100,random(10, MAX_SIZE),random(10, 100)); 
       this.addFront(add);
     }
    }
    else{
           for (int i = 0; i < n; i++){
        OrbNode add = new OrbNode();
        this.addFront(add);
     }
    }
  }//populate

  /*===========================
    display(int springLength)

    Display all the nodes in the list using
    the display method defined in the OrbNode class.
    =========================*/
  void display() {
    OrbNode current = front;
    while(current.next != null){
      current.display();
     current = current.next; 
    }
    current.display();
  }//display

  /*===========================
    applySprings(int springLength, float springK)

    Use the applySprings method in OrbNode on each
    element in the list.
    =========================*/
  void applySprings(int springLength, float springK) {
 OrbNode current = front;
    while(current.next != null){
      current.applySprings(SPRING_LENGTH,SPRING_K);
     current = current.next; 
    }
    current.applySprings(SPRING_LENGTH,SPRING_K);
  }//applySprings

  /*===========================
    applyGravity(Orb other, float gConstant)

    Use the getGravity and applyForce methods
    to apply gravity crrectly.
    =========================*/
  void applyGravity(Orb other, float gConstant) {
  OrbNode current = front;
    while(current.next != null){
      current.applyForce(current.getGravity(other,gConstant));
     current = current.next; 
    }
    current.applyForce(current.getGravity(other,gConstant));
  }//applySprings
  
 void applyCustom(float cConstant,int x, int y) {
  OrbNode current = front;
    while(current.next != null){
      current.applyForce(current.getCustom(cConstant,x,y));
     current = current.next; 
    }
    current.applyForce(current.getCustom(cConstant,x,y));
  }//applySprings
  void applyDrag(float dConstant) {
  OrbNode current = front;
    while(current.next != null){
      if (current.center.x > width/2){
      current.applyForce(current.getDragForce(dConstant+0.2));
     current = current.next; 
      }
      else{
      current.applyForce(current.getDragForce(dConstant));
     current = current.next; }
    }
    current.applyForce(current.getDragForce(dConstant));
  }//applySprings
  /*===========================
    run(boolean bounce)

    Call run on each node in the list.
    =========================*/
  void run(boolean boucne) {
OrbNode current = front;
    while(current.next != null){
      current.move(boucne);
     current = current.next; 
    }
    current.move(boucne);
  }//applySprings

  /*===========================
    removeFront()

    Remove the element at the front of the list, i.e.
    after this method is run, the former second element
    should now be the first (and so on).
    =========================*/
  void removeFront() {
  OrbNode current = front;
    if(current.next != null){
      
     front = current.next; 
    }
  }//removeFront


  /*===========================
    getSelected(float x, float y)

    If there is a node at (x, y), return
    a reference to that node.
    Otherwise, return null.

    =========================*/
  OrbNode getSelected(int x, int y) {
  OrbNode current = front;
  if (current.isSelected(x,y)){
        return current;
      }
    while(current.next != null){
      if (current.isSelected(x,y)){
        return current;
      }
     current = current.next; 
    }
   
    return null;
  }//getSelected

  /*===========================
    removeNode(OrbNode o)

    Removes o from the list. You can
    assume o is an OrbNode in the list.
    You cannot assume anything about the
    position of o in the list.
    =========================*/
  void removeNode(OrbNode o) {
    OrbNode current = front;
    if (current == o){
     front = current.next; 
    }
    else{
    while(current.next != o){
     current = current.next; 
    }
    if (current.next.next != null){
    current.next = current.next.next;
  }
  else{
   current.next = null; 
  }
}
}
}//OrbList
