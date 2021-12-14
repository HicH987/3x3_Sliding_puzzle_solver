class Node{
    
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
