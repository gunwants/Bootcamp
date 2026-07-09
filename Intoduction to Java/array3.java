import java.util.*;
public class array3 {
    public static void main(String[] args){
       int arr[]=new int[10];
       boolean sorted = true;
       Scanner sc = new Scanner(System.in);
       for(int i=0; i<arr.length;i++){
              System.out.println("Enter Number:");
                arr[i] = sc.nextInt();
       }
       for(int i=1;i<arr.length;i++){
           if(arr[i]<arr[i-1]){
               sorted = false;
               break;
           }
       }
       if(sorted){
           System.out.println("The array is sorted.");
       }
       else{
           System.out.println("The array is not sorted.");
       }
    }
}
