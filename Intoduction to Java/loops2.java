import java.util.*;
public class loops2 {
    public static void main(String[] args){
        boolean n = true;
        do{
            System.out.println("Enter 0 to stop and 1 to continue");
            Scanner sc = new Scanner(System.in);
            n = sc.nextBoolean();
            
            if(n){
                System.out.println("enter Marks :");
                int marks = sc.nextInt();
                if(marks>=90 && marks<101){
                    System.out.println("This is Good");
                }
                else if(marks<90 && marks>=60){
                    System.out.println("This is also Good");
                }
                else if(marks<60 && marks>=0){
                    System.out.println("This is Good as well");
                }
                else{
                    System.out.println("Please enter valid marks");
                }
            }
        } while(n);
    }
}
