final boolean ADDING = true; // used for a helper function called indexFixer()
final boolean SUBTRACTING = false; // same as above

//linked list class useful for making graphs, adjacency lists, storing large datasets
// not good for speedy access
// but takes up less space
//Created by Harsimrat Singh Wadhawan, for the community of the world. 
//
//With lots of help frmo the internet and really good youtube videos! :)

class LinkedList {



  public node firstNode;  // init the first node, the first node of a linked list is also called the head
  // nodeA -->  nodeb --> nodeC --> ...
  // (head)    

  LinkedList() {

    this.firstNode = null; //assign null value to the head
  }

  public boolean isEmpty() { // method checks if the list is empty or not
    // if the first node has a null value, it means that nodes have not been appended (added to the last) to the list yet. 

    if (this.firstNode == null)
    {
      return(true);
    } else {
      return false;
    }
  }

  public void prepend(String data) { // this method adds a new head (aka firstNode) to the list 

    node newNode = new node(data);

    if (isEmpty()) {
      this.firstNode = newNode;
      this.firstNode.index = 0;
      return;
    } else {
      newNode.next = this.firstNode;
      this.firstNode = newNode;      
      indexFixer(this.firstNode, ADDING);
    }
  }

  public void append(String data) { // this method adds a new node to the end of the list

    node endNode = new node(data);
    node currentNode = this.firstNode;

    if (isEmpty()) {
      this.firstNode = endNode;
      endNode.index = 0;
      return;
    }

    while (currentNode.next != null) { // cycles until the last node has been reached then assigns the next node as a newly created node
      currentNode = currentNode.next;
    }

    currentNode.next = endNode;              
    endNode.index = currentNode.index + 1;
  }   

  public int removeWithValue(String data) {  //this method removes a specfic node with a given data value

    if (isEmpty()) {

      return 1;
    }

    if (this.firstNode.data == data) {

      this.firstNode = firstNode.next;
      firstNode.index= 0;
      indexFixer(this.firstNode, SUBTRACTING);
      return 1;
    } else {

      node currentNode = this.firstNode;
      while (currentNode.next.data != data) {
        currentNode = currentNode.next;
      }
      currentNode.next = currentNode.next.next;
      indexFixer(currentNode, SUBTRACTING);
      return 1;
    }
  }

  private void indexFixer(node nodeToStartFrom, boolean operation) { //this method is useful when a node has been removed and we want to fix the index values of the subsequent nodes
    // you enter the last correctly indexed node and then whether the indeces are being added or subtracted

    // index++ when let's say a node has been added to the head
    //    head --> A --> B --> C --> D
    //index 0        1     2     3     4

    // add a new head now

    //    new HEad -- > prevhead --> A -->   B -->   C -->   D --> null
    //index 0            0+1          1+1     2+1     3+1     4+1

    // index-- when let's say a node has been removed 

    //    head --> A --> B --> C --> D
    //index 0        1     2     3     4

    // remove a node now

    //     head --> A -->   (remove)B -->    C -->   D --> null
    //index 0       1                2        3       4

    //     head --> A --> C -->   D --> null
    //index 0       1      3-1     4-1


    if (operation == true) {
      node currentNode = nodeToStartFrom.next;   
      while (currentNode.next != null) {
        currentNode.index++;
        currentNode = currentNode.next;
      }
      currentNode.index++;
    } else if (operation == false) {  
      node currentNode; 
      if (nodeToStartFrom.next == null) {
        return;
      } else {  
        currentNode = nodeToStartFrom.next;
        while (currentNode.next != null) {
          currentNode.index--;
          currentNode = currentNode.next;
        }
        currentNode.index--;
      }
    }
  }


  public node removeHead() {  //removes the firsNode of the list, technically it assgins the firstNode's next node as the first node
    // the objects are disposed when program is closed and when Java's garbage collector executes
    //since the link is broken, the nodes are essentiall removed.

    node refNode = firstNode.next;
    if (!isEmpty()) {
      firstNode = firstNode.next;
      firstNode.index = 0;
    } else {
      println("List is empty:(");
    }
    indexFixer(this.firstNode, SUBTRACTING);
    return refNode;
  }

  public void getList() {   //debug only

    node ho;
    ho = this.firstNode;

    while (ho != null) {
      println(ho.index + " " + ho.display());
      println();      
      ho = ho.next;
    }
  }


  //*****************************************************************************************************************************************************************
  public node get(int index) {   // ***********Gets the specific node at a specific index, might NOT be that usesful for just iteration since to access all the elements, the loop must run many times
    // a better apraoch would be to just use a while loop and not worry about indeces *******************

    node currentNode = this.firstNode;

    if (index == 0) {
      return this.firstNode;
    } else {

      while (currentNode.next != null) {

        if (currentNode.next.index == index) {    
          return currentNode.next;
        }

        currentNode = currentNode.next;
      }

      return currentNode.next;
    }
  }
  //**********************************************************************88**********************************************************************88*******************************************

  public int search(String data) { // Returns the index of the node with the specified data, if it is present. Returns a negative number if not found.

    node sNode = this.firstNode;    

    while (sNode.next != null) {

      if (sNode.display() == data) {

        return(sNode.index);
      }

      sNode = sNode.next;
    }

    return -1;
  }

  public int length() {//returns the number of objects (nodes with filled data) in the list

    int incrementor = 1;

    node currentNode = this.firstNode;

    if (isEmpty()) return 0;

    while (currentNode.next != null) {

      currentNode = currentNode.next;
      incrementor = incrementor + 1;
    }

    return incrementor;
  }
}

class node {

  // Node is one singular unit of a linked list. It holds the data and the link to the next node. This way nodes are linked together to form linked lists.
  //These nodes hold a string
  //  nodeA --> nodeB --> nodeC --> ... --> null
  //  data       data      data
  //{          linkedList                          }
  protected String data;
  protected node next;
  protected int index = 0;

  node(String data) {
    this.data = data;
  }

  public String display() {      
    return this.data;
  }

  public node nextNode() {
    return this.next ;
  }
}

void setup() {

  size(700, 700);
}

void draw() {

  noLoop();
  LinkedList list = new LinkedList();    //Initialising the list.

  list.append("Data");                  //Basic functions to add data into the list. Append means add to the end.        
  list.append("FIND ME!");
  list.append("HELLO");
  list.prepend("Data2");                //Prepend means add to the last.
  list.append("More Data!");
  list.prepend("EVEN MORE DATAAAAA!");

  list.getList(); //A function that prints the contents of the entire list.

  list.removeWithValue("More Data!");    //Removes the node with the given data.
  list.removeHead();                    //Removes the first node of the list. The first node is also called the head.   

  int searchedNode = list.search("FIND ME!"); // ----> Search function enter the data and the index of the node will pop out, if found.


  node foundNode = list.get(searchedNode);// **************Function to get a node with a specified index. Not the useful since large list will longer time to ge the node. USE CAUTION**************  

  println(foundNode.data + " " + foundNode.index); //Some more functions for extracting more info from each node. 
  //                |                              |                              |
  //          get the data stored        get the node's index            get the next node and its data

  /*A note on the .next parameter
   
   The next parameter esentially gets the next node from the current node. This is a property of linked lists since they are made up of nodes whihc hold
   information to the next node in the list.
   
   So, you can basically go in forever with currentNode.next.next.next.next.next ...... and so on. Provided the list is long enough.
   
   */

  //FINALLY

  println(list.chainLength()); // Get the length of the list.

  println("******************************");

  list.getList();

  //TWO WAYS OF ITERATING THE LIST

  // FOR  LOOP

  for (int i = 0; i <= list.chainLength() - 1; i++) {
  
    println(list.get(i).data);
  
  }

// WHILE LOOP - This one is much better when your list is larger.
  node curr = list.firstNode;

  while (curr.next != null) {

    println(curr.display());

    curr = curr.next;
  }

  println(curr.data); // Don't forget this one!!!!
}
