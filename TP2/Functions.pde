///////////////////////////////
/////////   FUNCTIONS   ////////////////
////////////////////////////////////
void setSxSy(int[][] initial) {
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
////////////////////////////////////
void createGrid(int[][] m) {
    for(int i = 0; i < 3; i++){
        for(int j = 0; j < 3; j++){
            grid[i][j] = new Cell(i * h, j * w, h, w, m[i][j]);
        }
    }

}
////////////////////////////////////
void showGrid() {
    for(int i = 0; i < 3; i++)
        for(int j = 0; j < 3; j++)
            grid[i][j].display();
}
////////////////////////////////////
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
////////////////////////////////////
void swapEmpty(int i, int j){
    if (grid[i][j].nearEmptyCell) {
                int tmp = grid[i][j].num;
                grid[i][j].num =0;
                grid[empty_X][empty_Y].num=tmp;

                empty_X=i;
                empty_Y=j;
    }
}
////////////////////////////////////
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
////////////////////////////////////
void textInput(){
    PFont font = createFont("arial",20);
    cp5 = new ControlP5(this);
    cp5.addTextfield(btn_inputInitial)
    .setPosition(560, 90)
    .setSize(150, 40)
    .setFont(font)
    .setFocus(true)
    .setColor(150)
    .setColorBackground(color(50));
}
////////////////////////////////////
void printMat(int[][] mat){
    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++)
            print(mat[i][j]," ");
            
        println();
    }
}
////////////////////////////////////
void clickToMoveCell(){
    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {   
            if (grid[i][j].selected() && grid[i][j].nearEmptyCell) {
                swapEmpty(i,j);
                initEmptyAdjacents();
                completed = false;
                notSolvable = false;
            }
        }
    }
}
////////////////////////////////////
void onClick_confirmStart(){
    if (btn_confirmStartState.selected()){
        for (int i = 0; i < cols; i++) 
            for (int j = 0; j < rows; j++) 
                initial[i][j] = grid[i][j].num;
            
        setSxSy(initial);

        println("The initial state:");
        printMat(initial);

        println("The Goal state:");
        printMat(goal);

        if (!isSolvable(initial)){
            notSolvable = true;
            completed = false;
            println("The given initial is impossible to solve"); 
        }
        else{
            println("click on < launche search > to solve the puzzle"); 
            completed = false;
            notSolvable = false;
        }
        
    }
}
////////////////////////////////////
void onClick_launcheSearch(){
    if (btn_launcheSearch.selected()){
        if (isSolvable(initial)){
            startSearch = true;
            notSolvable = false;
            completed = false;
            println("research has started ...");
        }
        else{
            notSolvable = true;
            completed = false;
            println("The given initial is impossible to solve"); 
         }
    }
}