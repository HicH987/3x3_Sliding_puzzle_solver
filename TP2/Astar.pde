boolean isSolvable(int[][] arr){
    int invCount = 0;
    for (int i = 0; i < 3 - 1; i++)
        for (int j = i + 1; j < 3; j++)
            if (arr[j][i] > 0 && arr[j][i] > arr[i][j])
                invCount++;
    return (invCount % 2 == 0);
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
    return(x >= 0 && x < 3 && y >= 0 && y < 3);
}

LinkedList<Node> solve(int x, int y) {
    // Bottom, left, top, right
    int[] row = { 1, 0, -1, 0 };
    int[] col = { 0, -1, 0, 1 };
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