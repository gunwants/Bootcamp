public class array2d {
    public static void main(String[] args){
        int[][] arr = new int[5][6];
        arr[0]=new int[]{1,5,7,9,10,11};
        arr[1]=new int[]{6,10,12,13,20,21};
        arr[2]=new int[]{9,25,29,30,32,41};
        arr[3]=new int[]{15,55,59,63,68,70};
        arr[4]=new int[]{40,70,79,81,95,105};
        
        int rowStart = 0, rowEnd = arr.length - 1;
        int colStart = 0, colEnd = arr[0].length - 1;
        
        while(rowStart <= rowEnd && colStart <= colEnd){
            // Print top row
            for(int i=colStart; i<=colEnd; i++){
                System.out.print(arr[rowStart][i]+" ");
            }
            rowStart++;
            
            // Print right column
            for(int i=rowStart; i<=rowEnd; i++){
                System.out.print(arr[i][colEnd]+" ");
            }
            colEnd--;
            
            // Print bottom row (if exists)
            if(rowStart <= rowEnd){
                for(int i=colEnd; i>=colStart; i--){
                    System.out.print(arr[rowEnd][i]+" ");
                }
                rowEnd--;
            }
            
            // Print left column (if exists)
            if(colStart <= colEnd){
                for(int i=rowEnd; i>=rowStart; i--){
                    System.out.print(arr[i][colStart]+" ");
                }
                colStart++;
            }
        }
    }
}
