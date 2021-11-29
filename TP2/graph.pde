import java.io.*;
import java.util.*;

class Graph {
  HashMap<Integer, Cell> vertices;
  
  Graph() {
      this.vertices = new HashMap<>();
  }
  void addCell(int index, Cell c) {
      vertices.put(index, c);
  }
  HashMap<Integer, Cell> getVertices() {
      return this.vertices;
  }
}
