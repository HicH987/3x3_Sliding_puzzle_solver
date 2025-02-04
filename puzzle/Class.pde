class Button {
  int x, y; // x,y location
  int w, h; // width and height
  String title;
  Button(int x, int y, int w, int h, String t) {
    this.x = x;
    this.y = y;
    this.h = h;
    this.w = w;
    title = t;
  }
  void display() {
    strokeWeight(1);
    stroke(255);
    fill(50);
    rect(x, y, w, h);
    textSize(h / 2);
    fill(160, 160, 160);
    text(title, x + 5, h / 2 + 8 + y);

  }
  boolean selected() {
    if (mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h)
      return true;
    else
      return false;
  }
}


class Cell {

  boolean nearEmptyCell = false;
  int x, y; // x,y location
  int w, h; // width and height
  int num;

  Cell(int tempX, int tempY, int tempW, int tempH, int n) {
    x = tempY;
    y = tempX;
    w = tempW;
    h = tempH;
    num = n;
  }

  void display() {
    int c = (num == 0) ? (150) : (50);
    strokeWeight(3);
    stroke(255);
    fill(c);
    rect(x, y, w, h);
    if (num != 0) {
      textSize(100);
      fill(160, 160, 160);
      String str = Integer.toString(num);
      // text(str, x - 20 + w / 2, y + 40 + h / 2);
      text(str, x - 20 + w / 2, y + 40 + h / 2);
    }
  }

  boolean selected() {
    if (mouseX >= x && mouseX <= x + h && mouseY >= y && mouseY <= y + h)
      return true;
    else
      return false;
  }

}


class Node {

  Node parent;
  int[][] matrix;

  // empty call cordinates
  int x, y;

  // Number of misplaced tiles //h
  int cost;

  // The number of moves so far //g
  int level;

  Node(int[][] matrix, int x, int y, int newX, int newY, int level, Node parent) {
    this.parent = parent;
    this.matrix = new int[matrix.length][];

    for (int i = 0; i < matrix.length; i++) {
      this.matrix[i] = matrix[i].clone();
    }

    // Swap value
    this.matrix[x][y] = this.matrix[x][y] + this.matrix[newX][newY];
    this.matrix[newX][newY] = this.matrix[x][y] - this.matrix[newX][newY];
    this.matrix[x][y] = this.matrix[x][y] - this.matrix[newX][newY];

    this.level = level;
    this.x = newX;
    this.y = newY;
  }

}