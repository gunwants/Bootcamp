import java.util.*;
public class array {
    public static void main(String[] args){
        String[] arr = new String[5];
        Scanner sc = new Scanner(System.in);
        for(int i=0; i<arr.length; i++){
            System.out.println("Enter Name:");
            arr[i] = sc.nextLine();
            
        }
        for(int i=0; i<arr.length; i++){
            System.out.print(arr[i]+" ");
        }
    }
    }
