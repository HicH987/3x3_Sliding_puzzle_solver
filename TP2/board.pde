class Board{
    Cell[][] grid = new Cell[cols][rows];
    int h, g, f;  
    int[] currentCellsNums = new int[9];
    int[] endCellsNums= new int[9];
//     Board(Cell[][] b){
//         board=b;
//         for (int i = 0; i < cols; i++)
//             for (int j = 0; j < rows; j++) 
//                currentCellsNums[board[i][j].index] =(board[i][j].num);
//         g=0;
//         h=0;
//         for(int i=0;i<9; i++){
//             if (endCellsNums[i] == currentCellsNums[i]){
//                 h=h+1;
//             }
            
//         }
//     }
//     void setboard(Cell[][] b){
//         board=b;
//         for (int i = 0; i < cols; i++)
//             for (int j = 0; j < rows; j++) 
//                currentCellsNums[board[i][j].index] =(board[i][j].num);
//         g=0;
//         h=0;
//         for(int i=0;i<9; i++){
//             if (endCellsNums[i] == currentCellsNums[i]){
//                 h=h+1;
//             }
            
//         }
//     }

}
