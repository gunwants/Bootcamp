import java.util.*;
public class calculator {
    public static void main(String[] args){
        System.out.println("Calculator");
        System.out.print("Enter the first number: ");
        Scanner sc = new Scanner(System.in);
        int a = sc.nextInt();
        System.out.print("Enter the second number:\n");
        int b = sc.nextInt();
        System.out.println("Enter the operation : 1.Addition 2.Subtraction 3.Multiplication 4.Division 5.Modulus");
        int operation = sc.nextInt();
        switch(operation){
            case 1:
                System.out.println("The sum of " + a + " and " + b + " is: " + (a+b));
                break;
            case 2:
                System.out.println("The difference of " + a + " and " + b + " is: " + (a-b));
                break;
            case 3:
                System.out.println("The product of " + a + " and " + b + " is: " + (a*b));
                break;
            case 4:
                if(b!=0){
                    System.out.println("The quotient of " + a + " and " + b + " is: " + (a/b));
                }else{
                    System.out.println("Division by zero is not allowed.");
                }
                break;
            case 5:
                System.out.println("The modulus of " + a + " and " + b + " is: " + (a%b));
                break;
            default:
                System.out.println("Invalid operation selected.");
        }
    }
}
