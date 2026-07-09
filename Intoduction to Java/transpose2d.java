public class transpose2d {
    public static void main(String args[]){
        int[][] arr = new int[5][6];
        arr[0]=new int[]{1,5,7,9,10,11};
        arr[1]=new int[]{6,10,12,13,20,21};
        arr[2]=new int[]{9,25,29,30,32,41};
        arr[3]=new int[]{15,55,59,63,68,70};
        arr[4]=new int[]{40,70,79,81,95,105};
    
    for(int i=0;i<arr.length;i++){
        for(int j=0;j<arr[0].length/2;j++){
            int temp = arr[i][j];
            arr[i][j] = arr[i][arr[0].length-1-j];
            arr[i][arr[0].length-1-j] = temp;
        }
        System.out.println();
    }
}
}