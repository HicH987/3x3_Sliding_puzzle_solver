int cols = 3;//for x
int rows = 3;//for y
int h =  500 / cols;//for x
int w = 500 / rows;//for y

Integer[][] numCells = { {1, 2, 3} , {8, 0, 4} ,{7,6,5} };
Cell[][] grid = new Cell[cols][rows];


int emptyX = 1;
int emptyY = 1;
int currentGridNums[] = {1,2,3, 8,0,4, 7,6,5};
int endGridNums[] = {3,5,1,4,0,2,7,8,6};








//////////////////
//////////////////////
///////////////////////////
void setup() {
    size(500, 500);
    frameRate(60);
    
    createGrid();
    setGridNums();
    setEmptyAdjacents();

}

void draw() {

    showGrid(grid);
}

void mousePressed() {
    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {   
            if (grid[i][j].selected()) {
                clickMoveEmpty(i,j);
            }
        }
    }
}   

///////////////////////////////
///////////FUNCTIONS/////////////
///////////////////////////////////
void createGrid() {
    for (int i = 0; i < cols; i++) 
        for (int j = 0; j < rows; j++) 
            grid[i][j] = new Cell(i * h, j * w, h, w, numCells[j][i], j + i * rows);
    }

void showGrid(Cell[][] grid) {
    for (int i = 0; i < cols; i++) 
        for (int j = 0; j < rows; j++) 
            grid[i][j].display();
}

void setEmptyAdjacents() {
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

void initNearEmpty() {
    for (int ii = 0; ii < cols; ii++)
        for (int jj = 0; jj < rows; jj++) 
            grid[ii][jj].nearEmptyCell = false;
}

void setAjacents() {
    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
                if (j > 0)
                    grid[i][j].addAdjacent(grid[i][j - 1]);
                
                if (i > 0 )
                    grid[i][j].addAdjacent(grid[i - 1][j]);
                
                if (j < rows - 1)
                    grid[i][j].addAdjacent(grid[i][j + 1]);
                
                if (i < cols - 1)
                    grid[i][j].addAdjacent(grid[i + 1][j]);
        }
    }
}


void setGridNums(){
    for (int i = 0; i < cols; i++)
        for (int j = 0; j < rows; j++) 
               currentGridNums[grid[i][j].index] =(grid[i][j].num);
        
    // for (int i = 0; i < cols*rows; i++)
    //     println(currentGridNums[i]);
    // println("\n");
}
void clickMoveEmpty(int i, int j){
    if (grid[i][j].nearEmptyCell) {
        int tmp = grid[i][j].num;
        grid[emptyX][emptyY].num = tmp;
        grid[i][j].num = 0;

        int eX = grid[i][j].x / h;
        int eY = grid[i][j].y / w;

        emptyX = eX;
        emptyY = eY;

        initNearEmpty();
        setGridNums();
        setEmptyAdjacents();
    }
}

