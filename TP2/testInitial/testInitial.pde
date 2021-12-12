import java.io.*;
import java.util.*;


void setup(){
int[][] initial = { { 8, 4, 7 } , 
                    { 5, 0, 3 } , 
                    { 1, 2, 6 } };
                 
 print(isSolvable3(initial));
}



boolean isSolvable1(int[][] arr){
    int inv_count = 0;
    for (int i = 0; i < 3 - 1; i++)
        for (int j = i + 1; j < 3; j++)
            if (arr[j][i] > 0 && arr[j][i] > arr[i][j])
                inv_count++;
    return (inv_count % 2 == 0);
}

boolean isSolvable2(int[][] matrix) {
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
                count++;
            }
        }
    }
    return count % 2 == 0;
}


boolean isSolvable3(int[][] arr){
  
  int[] tmp = new int[9];
  int k= 0;
  for (int i = 0; i < 3; i++){
    for (int j = 0; j < 3; j++){
       tmp[k] = arr[i][j];
       k++;  
        }   
     }
     int s=0;
     for (int i=0; i<9; i++){
        for(int j=i+1; j<9; j++){
          if(tmp[j]!=0 && tmp[i]!=0 && tmp[i]> tmp[j])
            s++;
        }
     }
  return (s % 2 == 0);
}