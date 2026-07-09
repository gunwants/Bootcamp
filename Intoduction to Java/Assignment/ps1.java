package Assignment;
import java.util.*;
public class ps1 {
    public static void main(String[] args){
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter First Number :");
        int first= sc.nextInt();
        System.out.println("Enter Second Number :");
        int second= sc.nextInt();
        System.out.println("Enter Third Number :");
        int third= sc.nextInt();
        System.out.println("The Largest Number is :"+Math.max(first,Math.max(second,third))); // First Method
        
        int arr[] ={first,second,third};
        System.out.println("The Largest Number is :"+Arrays.stream(arr).max().getAsInt()); // Second Method
        
        if(first>second && first>third){                                                   // third Method
            System.out.println("The Largest Number is :"+first);
        }
        else if(second>first && second>third){
            System.out.println("The Largest Number is :"+second);
        }
        else{
            System.out.println("The Largest Number is :"+third);
        }
    }
}
