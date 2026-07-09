import java.util.*;
public class array2 {
    public static void main(String[] args){
        int arr[]=new int[]{23,45,99,80,27};
        int max=Integer.MIN_VALUE;
        int min=Integer.MAX_VALUE;
        for(int i=0;i<arr.length;i++){
        max=Math.max(arr[i],max);
        min=Math.min(arr[i],min);
        }
        System.out.println("Maximum value: " + max);
        System.out.println("Minimum value: " + min);
    }
}
