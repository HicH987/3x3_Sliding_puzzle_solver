import java.io.*;
import java.util.*;
import controlP5.*;
ControlP5 cp5;


int cols = 3;// for x
int rows = 3;// for y
int h = 500 / cols;// for x
int w = 500 / rows;// for y
Cell[][] grid = new Cell[3][3];

// int[][] initial = { { 1, 8, 2 } , 
//                     { 0, 4, 3 } , 
//                     { 7, 6, 5 } };
// int[][] goal = { { 1, 2, 3 } , 
//                  { 4, 5, 6 } , 
//                  { 7, 8, 0 } };

// int[][] initial = { { 0, 2, 3 } , 
//                     { 1, 4, 5 } , 
//                     { 8, 7, 6 } };
int[][] initial = { { 0, 2, 5 } , 
                    { 1, 3, 4 } , 
                    { 8, 7, 6 } };

int[][] goal = { { 1, 2, 3 } , 
                 { 8, 0, 4 } , 
                 { 7, 6, 5 } };




// int val=0;
int empty_X, empty_Y;
LinkedList<Node> path;

Button btn_confirmStartState =new Button(560, 15, 150, 50, "Confirm Start");
Button btn_launcheSearch = new Button(555, 400, 166, 50, "launche search");
String btn_inputInitial  = "  input inital";


String inPut_Initial;
Boolean startSearch = false;
Boolean creatPath = false;
Boolean notSolvable = false;
Boolean completed = false;


void setup() {
    size(800, 500);
    frameRate(3);
    PFont font = createFont("arial",20);
    cp5 = new ControlP5(this);
    cp5.addTextfield(btn_inputInitial)
    .setPosition(560, 90)
    .setSize(150, 40)
    .setFont(font)
    .setFocus(true)
    .setColor(150)
    .setColorBackground(color(50));

    setSxSy();
    createGrid(initial);
    initEmptyAdjacents();
}

void draw() {
    background(150);
    btn_confirmStartState.display();
    btn_launcheSearch.display();

    showGrid();

    if (startSearch){
        path = solve(empty_X, empty_Y);
        creatPath = true;
        startSearch = false;
    }

    if(notSolvable){
        textSize(30);
        fill(50);
        text("The given initial is impossible to solve", 530, 300, 280, 320);
    }

    if (creatPath) {
        if (path.size() > 0) {
            Node w = path.getFirst();
            createGrid(w.matrix);
            // println(val++);
            path.removeFirst();
        } 
        else{
            creatPath = false;
            completed = true;
        }    
    }

    // if (completed){
    //     textSize(30);
    //     fill(50);
    //     text("Puzzle Soloved !!", 530, 300, 280, 320);
    // }
    
}

void mousePressed() {
    //for click to move cells
    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {   
            if (grid[i][j].selected() && grid[i][j].nearEmptyCell) {
                swapEmpty(i,j);
                initEmptyAdjacents();
                completed = false;
            }
        }
    }

    //for the click on "confirm Start State" button
    if (btn_confirmStartState.selected()){
        for (int i = 0; i < cols; i++) 
            for (int j = 0; j < rows; j++) 
                initial[i][j] = grid[i][j].num;
            
        setSxSy();

        println("The initial state:");
        for (int i = 0; i < cols; i++) {
            for (int j = 0; j < rows; j++) {   
                    print(initial[i][j]," ");
            }
            println();
        }
        println("The Goal state:");
        for (int i = 0; i < cols; i++) {
            for (int j = 0; j < rows; j++) {   
                    print(goal[i][j]," ");
            }
            println();
        }

        if (!isSolvable(initial)){
            notSolvable = true;
            println("The given initial is impossible to solve"); 
        }
    }

    //for the click on "launche search" button 
    if (btn_launcheSearch.selected()){
        if (isSolvable(initial))
            startSearch = true;
        else{
            notSolvable = true;
            println("The given initial is impossible to solve"); 
         }
    }
}   

//get INITIAL INPUT
void controlEvent(ControlEvent theEvent) {
    if (theEvent.isAssignableFrom(Textfield.class)) {
        println("initial = "
                // + theEvent.getName() + "': "
                + theEvent.getStringValue());

        inPut_Initial = theEvent.getStringValue();
        getInitialInput(inPut_Initial);
        setSxSy();
        createGrid(initial);
        initEmptyAdjacents();   
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

void getInitialInput(String s) {
    String[] str = s.split(" ");
    if (str.length == 9) {
        int k = 0;
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                initial[i][j] = Integer.valueOf(str[k]);
                k++;
            }
        }

    }
}
