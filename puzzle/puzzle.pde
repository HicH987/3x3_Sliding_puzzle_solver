import java.io.*;
import java.util.*;
import controlP5.*;

ControlP5 cp5;
int cols = 3; // for x
int rows = 3; // for y
int h = 500 / cols; // for x
int w = 500 / rows; // for y
Cell[][] grid = new Cell[3][3];

int[][] initial = { { 0, 2, 5 } , 
                    { 1, 3, 4 } , 
                    { 8, 7, 6 } };
                    
// int[][] initial = { { 4, 6, 8 } , 
//                     {5, 0, 3 } , 
//                     { 7, 1, 2 } };


int[][] goal = { { 1, 2, 3 } , 
                 { 8, 0, 4 } , 
                 { 7, 6, 5 } };

int empty_X, empty_Y;
LinkedList < Node > path;

Button btn_confirmStartState = new Button(560, 15, 150, 50, "Confirm Start");
Button btn_launcheSearch = new Button(555, 400, 166, 50, "launche search");
String btn_inputInitial = "  input inital";
String inPut_Initial;

Boolean startSearch = false;
Boolean creatPath = false;
Boolean notSolvable = false;
Boolean completed = false;

void setup() {
  size(800, 500);
  frameRate(3);
  textInput();
  setSxSy(initial);
  createGrid(initial);
  initEmptyAdjacents();
}

void draw() {
  background(150);
  btn_confirmStartState.display();
  btn_launcheSearch.display();
  showGrid();

  if (startSearch) {
    path = solve(empty_X, empty_Y);
    creatPath = true;
    startSearch = false;
    notSolvable = false;
    completed = false;
  }

  if (creatPath) {
    if (path.size() > 0) {
      Node w = path.getFirst();
      createGrid(w.matrix);
      path.removeFirst();
      completed = false;
    } else {
      creatPath = false;
      completed = true;
    }
    notSolvable = false;
  }

  if (notSolvable) {
    textSize(30);
    fill(50);
    text("The given initial is impossible to solve", 530, 300, 280, 320);
  }

  if (completed) {
    setSxSy(goal);
    createGrid(goal);
    initEmptyAdjacents();
    textSize(30);
    fill(50);
    text("Puzzle Soloved !!", 530, 300, 280, 320);
    notSolvable = false;
  }

}

void mousePressed() {
  //for click to move cells
  clickToMoveCell();

  //for the click on "confirm Start State" button
  onClick_confirmStart();

  //for the click on "launche search" button 
  onClick_launcheSearch();

}

//get INITIAL INPUT from user
void controlEvent(ControlEvent theEvent) {
  if (theEvent.isAssignableFrom(Textfield.class)) {
    println("initial = " + theEvent.getStringValue());
    inPut_Initial = theEvent.getStringValue();
    getInitialInput(inPut_Initial);
    setSxSy(initial);
    createGrid(initial);
    initEmptyAdjacents();
  }
}