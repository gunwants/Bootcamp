import java.util.*;
public class prime {
    public static void main(String[] args){
        System.out.println("Enter a number to check if it is prime:");
        Scanner sc = new Scanner(System.in);
        int num = sc.nextInt();
        boolean isprime = true;
        
        for(int i=2; i<=num/2; i++){
            if(num % i == 0){
                isprime = false;
                break;
            }
        }
        if(isprime){
            System.out.println(num + " is a prime number.");
        } else {
            System.out.println(num + " is not a prime number.");
        }
    }
}
