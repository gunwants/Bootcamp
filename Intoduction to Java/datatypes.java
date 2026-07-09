import java.util.Scanner;
public class datatypes {
    public static void main(String[] args){
    int age = 78; // first question 
    final float pi = 3.14f;
    System.out.println("Enter The radius of the circle:"); // second question
    Scanner sc = new Scanner(System.in);
    double radius = sc.nextDouble();
    double area = pi * radius * radius;
    System.out.println("The area of the circle is: " + area);

    System.out.println("Enter the integer for table:"); // third question
    int n = sc.nextInt();
    System.out.println("The multiplication table of " + n + " is:");
    for(int i = 1; i <= 10; i++){       
        System.out.println(n + " * " + i + " = " + (n * i));
    }
}   
}
