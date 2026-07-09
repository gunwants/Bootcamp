package Assignment;

import java.util.*;
public class ps3 {
    public static void main(String[] args){
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter First Number :");
        int first= sc.nextInt();
        System.out.println("Enter Second Number :");
        int second= sc.nextInt();
        System.out.println("Enter Third Number :");
        int third= sc.nextInt();
        int arr[] ={first,second,third};
        Arrays.sort(arr);
        System.out.println("The Smallest Number is :"+arr[0]); // First Method
        
        System.out.println("The Smallest Number is :"+Arrays.stream(arr).min().getAsInt()); // Second Method
    }
}
