import java.io.*;
import java.util.*;
import controlP5.*;
ControlP5 cp5;
class Button{
    int x, y; // x,y location
    int w, h; // width and height
    String title;
    Button(int x, int y, int w, int h, String t){
        this.x=x;
        this.y=y;
        this.h=h;
        this.w=w;
        title = t;
    }
    void display() {
        strokeWeight(1);
        stroke(255);
        fill(50);
        rect(x, y, w, h);
        textSize(h/2);
        fill(160, 160, 160);
        text(title, x+5,h/2+8+y);

    // rect(560, 50, 150, 50);
    // text("Confirm Start", 565, 78);
    }
    boolean selected() {
        if(mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h)
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
        if(num != 0) {
            textSize(100);
            fill(160, 160, 160);
            String str = Integer.toString(num);
            // text(str, x - 20 + w / 2, y + 40 + h / 2);
            text(str, x - 20 + w / 2, y + 40 + h / 2);
        }
    }
    
    boolean selected() {
        if(mouseX >= x && mouseX <= x + h && mouseY >= y && mouseY <= y + h)
            return true;
        else
            return false;
    }
    
}

class Node{
    
    Node parent;
    int[][] matrix;
    
    // Blank tile cordinates
    int x, y;
    
    // Number of misplaced tiles //h
    int cost;
    
    // The number of moves so far //g
    int level;
    
    Node(int[][] matrix, int x, int y, int newX, int newY, int level, Node parent) {
        this.parent = parent;
        this.matrix = new int[matrix.length][];
        for(int i = 0; i < matrix.length; i++) {
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

int cols = 3;// for x
int rows = 3;// for y
int h = 500 / cols;// for x
int w = 500 / rows;// for y
Cell[][] grid = new Cell[3][3];

int[][] initial = { { 1, 8, 2 } , 
                    { 0, 4, 3 } , 
                    { 7, 6, 5 } };
int[][] goal = { { 1, 2, 3 } , 
                 { 4, 5, 6 } , 
                 { 7, 8, 0 } };

int dimension = 3;

// Bottom, left, top, right
int[] row = { 1, 0, -1, 0 };
int[] col = { 0, -1, 0, 1 };

int empty_X, empty_Y;
LinkedList<Node> path;

Button button1 = new  Button(560, 50,150, 50,"Confirm Start");
// Button button2 = new  Button(560, 300,150, 50,"Confirm goal");
String button2 = "Confirm goal";
String inPut;
Boolean startSearch = false; 
Boolean creatPath = false;


void setup() {
    size(800, 500);
    frameRate(3);
     PFont font = createFont("arial",20);
    cp5 = new ControlP5(this);
    cp5.addTextfield(button2)
    .setPosition(560, 300)
    .setSize(150, 40)
    .setFont(font)
    .setFocus(true)
    .setColor(150)
    // .setColorValue(150)   
    // .setColorActive(250)
    .setColorBackground(color(50));
    





    setSxSy();

    createGrid(initial);
    initEmptyAdjacents();


    // if(isSolvable(initial))
    //     path = solve(empty_X,empty_Y);
    // else
    //     println("The given initial is impossible to solve");
}

void draw() {
    background(150);
    if(startSearch){
        if(isSolvable(initial))
            path = solve(empty_X,empty_Y);
        else
            println("The given initial is impossible to solve");
        startSearch = false;
        creatPath=true;
    }
    // println(mouseX,":",mouseY);
    button1.display();
    // button2.display();

    showGrid();
    if (creatPath){
        if(path.size() > 0) {
            Node w = path.getFirst();
            createGrid(w.matrix);
            path.removeFirst();
        }
        else
            creatPath=false;
    }
    
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
      +theEvent.getName()+"': "
      +theEvent.getStringValue()
      );


      inPut=theEvent.getStringValue();
      getGoalInput(inPut);
              for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) { 
                    print(goal[i][j]);
            }
            println();
        }
        startSearch = true;

    if(isSolvable(initial))
        path = solve(empty_X,empty_Y);
    else
        println("The given initial is impossible to solve");
  }
}
void getGoalInput(String s){
        String[] str= s.split(" ");
        if(str.length==9){
            int k=0;
            for (int i = 0; i < 3; i++) {
                for (int j = 0; j < 3; j++) { 
                    goal[i][j]= Integer.valueOf(str[k]);
                    k++;
                }
            }
     
        }
}

void mousePressed() {

    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {   
            if (grid[i][j].selected() && grid[i][j].nearEmptyCell) {
                swapEmpty(i,j);
                initEmptyAdjacents();
            }
        }
    }
    if (button1.selected()){
        for (int i = 0; i < cols; i++) 
            for (int j = 0; j < rows; j++) 
                initial[i][j] = grid[i][j].num;
            
            setSxSy();
            createGrid(initial);
            initEmptyAdjacents();

        for (int i = 0; i < cols; i++) {
            for (int j = 0; j < rows; j++) {   
                    print(initial[i][j]);
            }
            println();
        }
    }

  
}   

///////////////////////////////
/////////FUNCTIONS////////////////
////////////////////////////////////
void setSxSy() {
    for(int i = 0; i < 3; i++) {
        for(int j = 0; j < 3; j++) {
            if(initial[i][j] == 0) {
                empty_X = i;
                empty_Y = j;
                break;
            }
        }
        
    }
}

void createGrid(int[][] m) {
    for(int i = 0; i < 3; i++){
        for(int j = 0; j < 3; j++){
            grid[i][j] = new Cell(i * h, j * w, h, w, m[i][j]);

        }
        println();
    }
        
}

void showGrid() {
    for(int i = 0; i < 3; i++)
        for(int j = 0; j < 3; j++)
            grid[i][j].display();
}

boolean isSolvable(int[][] matrix) {
    int count = 0;
    List<Integer> array = new ArrayList<Integer>();
    
    for(int i = 0; i < matrix.length; i++) {
        for(int j = 0; j < matrix.length; j++) {
            array.add(matrix[i][j]);
        }
    }
    
    Integer[] anotherArray = new Integer[array.size()];
    array.toArray(anotherArray);
    
    for(int i = 0; i < anotherArray.length - 1; i++) {
        for(int j = i + 1; j < anotherArray.length; j++) {
            if(anotherArray[i] != 0 && anotherArray[j] != 0 && anotherArray[i] > anotherArray[j]) {
                // println(anotherArray[i] , ">" , anotherArray[j]);
                count++;
            }
        }
    }
    return count % 2 == 0;
}

int calculateCost(int[][] initial, int[][] goal) {
    int count = 0;
    int n = initial.length;
    for(int i = 0; i < n; i++) {
        for(int j = 0; j < n; j++) {
            if(initial[i][j] != 0 && initial[i][j] != goal[i][j]) {
                count++;
            }
        }
    }
    return count;
}

boolean isSafe(int x, int y) {
    return(x >= 0 && x < dimension && y >= 0 && y < dimension);
}

LinkedList<Node> solve(int x, int y) {
    LinkedList<Node> path = new LinkedList();
    PriorityQueue<Node> pq = new PriorityQueue<Node>(10000000,(a, b) -> (a.cost + a.level) - (b.cost + b.level));
    Node root = new Node(initial, x, y, x, y, 0, null);
    root.cost = calculateCost(initial, goal);
    pq.add(root);
    int l = 0;
    
    Node min = pq.poll();
    while(min.cost != 0) {
        for(int i = 0; i < 4; i++) {
            if(isSafe(min.x + row[i], min.y + col[i])) {
                Node child = new Node(min.matrix, min.x, min.y, min.x + row[i], min.y + col[i], min.level + 1, min);
                child.cost = calculateCost(child.matrix, goal);
                pq.add(child);
            }
        }
        if(!pq.isEmpty()) {
            min = pq.poll();
        }
    }
    
    l = min.level;
    for(int i = 0; i < l; i++) {
        path.addFirst(min);
        min = min.parent;
    }
    return path;
}

void move(Cell neighbor){

        int tmp = neighbor.num;
        grid[empty_X][empty_Y].num = tmp;
        neighbor.num = 0;

        int eX = neighbor.x / h;
        int eY = neighbor.y / w;

        empty_X = eX;
        empty_Y = eY;

        // board.updateCN(grid);
}

void initEmptyAdjacents() {
    for (int i = 0; i < cols; i++) 
        for (int j = 0; j < rows; j++) 
            grid[i][j].nearEmptyCell = false;
    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
            if (j > 0 && grid[i][j - 1].num == 0)
                grid[i][j].nearEmptyCell = true;

            if (i > 0 && grid[i - 1][j].num == 0)
                grid[i][j].nearEmptyCell = true;  

            if (j < rows - 1 && grid[i][j + 1].num == 0)
                grid[i][j].nearEmptyCell = true;

            if (i < cols - 1 && grid[i + 1][j].num == 0)
                grid[i][j].nearEmptyCell = true;
        }
    }
}


void swapEmpty(int i, int j){
    if (grid[i][j].nearEmptyCell) {
                int tmp = grid[i][j].num;
                grid[i][j].num =0;
                grid[empty_X][empty_Y].num=tmp;

                empty_X=i;
                empty_Y=j;
    }
}
