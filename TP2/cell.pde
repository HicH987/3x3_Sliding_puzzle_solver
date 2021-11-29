class Cell {
  LinkedList<Cell> adjacents;
  boolean nearEmptyCell = false;
  int x, y;   // x,y location
  int w, h;   // width and height
  int index;
  int num;

  Cell(int tempX, int tempY, int tempW, int tempH, int n, int i) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    num = n;
    index = i;
    this.adjacents = new LinkedList<>();
  }

  void addAdjacent(Cell adjacentCell) {
    adjacents.add(adjacentCell);
  }
  LinkedList<Cell> getAdjacents() {
    return this.adjacents;
  }

  void display() {
    int c = (num == 0) ? (150):(50);
    stroke(255);
    fill(c);
    rect(x, y, w, h);
    if(num != 0){
      textSize(100);
      fill(160, 160, 160);
      String str=Integer.toString(num);
      text(str,x-20+w/2, y+40+h/2);
    }
  }

  boolean selected() {
    if (mouseX >= x && mouseX <= x+h && mouseY >= y && mouseY <= y+h)  return true;
    else return false;
  }

}


