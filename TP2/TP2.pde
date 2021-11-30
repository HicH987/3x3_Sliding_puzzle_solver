import java.io.*;
import java.util.*;


class Cell {

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








class Node {

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
		for (int i = 0; i < matrix.length; i++) {
			this.matrix[i] = matrix[i].clone();
		}
		
		// Swap value
		this.matrix[x][y]       = this.matrix[x][y] + this.matrix[newX][newY];
		this.matrix[newX][newY] = this.matrix[x][y] - this.matrix[newX][newY];
		this.matrix[x][y]       = this.matrix[x][y] - this.matrix[newX][newY];

		// this.cost = Integer.MAX_VALUE;
		this.level = level;
		this.x = newX;
		this.y = newY;

	}
	
}

class Puzzle {
	
	int dimension = 3;
	
	// Bottom, left, top, right
	int[] row = { 1, 0, -1, 0 };
	int[] col = { 0, -1, 0, 1 };
	
	int calculateCost(int[][] initial, int[][] goal) {
		int count = 0;
		int n = initial.length;
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < n; j++) {
				if (initial[i][j] != 0 && initial[i][j] != goal[i][j]) {
					count++;
				}
			}
		}
		return count;
	}
	
	void printMatrix(int[][] matrix) {
		for (int i = 0; i < 3; i++) {
			for (int j = 0; j < 3; j++) {
				print(matrix[i][j] + " ");
			}
			println();
		}

        createGrid(matrix);

	}
	// void printMatrix(int[][] matrix) {
	// 	for (int i = 0; i < 3; i++) {
	// 		for (int j = 0; j < 3; j++) {
	// 			print(matrix[i][j] + " ");
	// 		}
	// 		println();
	// 	}
	// }
	
	boolean isSafe(int x, int y) {
		return (x >= 0 && x < dimension && y >= 0 && y < dimension);
	}
	
	void printPath(Node root) {
		if (root == null) {
			return;
		}
		printPath(root.parent);
		printMatrix(root.matrix);
        // path.addFirst(root.parent);
		println("");
	}

	boolean isSolvable(int[][] matrix) {

		int count = 0;

		List<Integer> array = new ArrayList<Integer>();
		
		for (int i = 0; i < matrix.length; i++) {
			for (int j = 0; j < matrix.length; j++) {
				array.add(matrix[i][j]);
			}
		}
		
		Integer[] anotherArray = new Integer[array.size()];
		array.toArray(anotherArray);
		
		for (int i = 0; i < anotherArray.length - 1; i++) {
			for (int j = i + 1; j < anotherArray.length; j++) {
				if (anotherArray[i] != 0 && anotherArray[j] != 0 && anotherArray[i] > anotherArray[j]) {
                    // println(anotherArray[i] , ">" , anotherArray[j]);
                    count++;
				}
			}
		}

		return count % 2 == 0;
	}
	
	void solve(int[][] initial, int[][] goal, int x, int y) {
        LinkedList<Node> path= new LinkedList();
		PriorityQueue<Node> pq = new PriorityQueue<Node>(10000000, (a, b) -> (a.cost + a.level) - (b.cost + b.level));
		Node root = new Node(initial, x, y, x, y, 0, null);
		root.cost = calculateCost(initial, goal);
		pq.add(root);
		
		while (!pq.isEmpty()) {
			Node min = pq.poll();
			if (min.cost == 0) {
				printPath(min);
				return;
			}
			
	    
			for (int i = 0; i < 4; i++) {
	            if (isSafe(min.x + row[i], min.y + col[i])) {
	            	Node child = new Node(min.matrix, min.x, min.y, min.x + row[i], min.y + col[i], min.level + 1, min);
	            	child.cost = calculateCost(child.matrix, goal);
	            	pq.add(child);
	            }
	        }
		}
	}

}


int cols = 3;//for x
int rows = 3;//for y
int h =  500 / cols;//for x
int w = 500 / rows;//for y
Cell[][] grid = new Cell[cols][rows];

int[][] initial = { {1, 8, 2}, {0, 4, 3}, {7, 6, 5} };
int[][] goal    = { {1, 2, 3}, {4, 5, 6}, {7, 8, 0} };
// int[][] goal    = { {1, 2, 3}, {8, 0, 4}, {7, 6, 5} };

// White tile coordinate
int x ,y;

// int[] row = { 1, 0, -1, 0 };
// int[] col = { 0, -1, 0, 1 };

Puzzle puzzle = new Puzzle();
// LinkedList<Node> path= new LinkedList();
// PriorityQueue<Node> pq = new PriorityQueue<Node>(10000000, (a, b) -> (a.cost + a.level) - (b.cost + b.level));
// Node root;



void setup(){
    size(500, 500);
    frameRate(20);
    setSxSy();
    // root =new Node(initial, x, y, x, y, 0, null);


    createGrid(initial);
	// root.cost = puzzle.calculateCost(initial, goal);
    // pq.add(root);

}


void draw() {

    showGrid();
	if (puzzle.isSolvable(initial)) {
	    puzzle.solve(initial, goal, x, y);
    } 
    else {
    	println("The given initial is impossible to solve");
    }
	
	//  if (puzzle.isSolvable(initial)){
	// 	if (!pq.isEmpty()) {
	// 		Node min = pq.poll();
	// 		if (min.cost == 0) {
	// 			puzzle.printPath(min);
    //             //  path.addFirst(min.parent);
	// 		}
			
	// 		for (int i = 0; i < 4; i++) {
	//             if (puzzle.isSafe(min.x + row[i], min.y + col[i])) {
	//             	Node child = new Node(min.matrix, min.x, min.y, min.x + row[i], min.y + col[i], min.level + 1, min);
	//             	child.cost = puzzle.calculateCost(child.matrix, goal);
	//             	pq.add(child);
	//             }
	//         }
    //         // root =new Node(initial, x, y, x, y, 0, null);
	// 	}
    //     else{
    //         if (path.size() > 0) {
    //             Node p = path.getLast();
    //             createGrid(p.matrix);
    //         }
    //     }

    // }
    
}
    




void createGrid(int[][] m) {
    for (int i = 0; i < cols; i++) 
        for (int j = 0; j < rows; j++) 
            grid[i][j] = new Cell(i * h, j * w, h, w, m[j][i], j + i * rows);

}

void showGrid() {
    for (int i = 0; i < cols; i++) 
        for (int j = 0; j < rows; j++) 
            grid[i][j].display();
}

void setSxSy(){
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            if(initial[i][j] == 0){
                x=i;
                y=j;
                break;
            }
        }
    
    }
}