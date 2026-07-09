package Assignment;
import java.util.*;
public class ps4to7 {
    public static boolean checkpalindrome(String num){
        for(int i=0,j=num.length()-1;i<num.length()/2;i++,j--){
            if(num.charAt(i)!=num.charAt(j)){
                return false;
            }
        }
        return true;
    }
    public static void generatepalindrome(int num){
        for(int i=0;i<num;i++){
           if(checkpalindrome(Integer.toString(i))){
               System.out.println(i);
           }
        }
    }
    public static void generate_npalindrone(int num){
        int count=0;
        int i=0;
        while(count<num){
            if(checkpalindrome(Integer.toString(i))){
                System.out.println(i);
                count++;
            }
            i++;
        }
    }
    public static void main(String[] args){
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter a number to check for palindrome");
        String num =sc.next();
        if(checkpalindrome(num)){
            System.out.println("This is a palindrome");
        }
        else{
            System.out.println("This is not a palindrome");
        }
        System.out.println("Enter a number to generate palindromes below n");
        int n = sc.nextInt();
        generatepalindrome(n);
        System.out.println("Enter a number to check for palindrome upto N");
        int N = sc.nextInt();
        generate_npalindrone(N);
    }
    
}
