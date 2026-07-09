package Assignment;
import java.util.*;
public class p19 {
        public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int a = sc.nextInt();

        for (int n = 1; n < a+1; n++) {
            for (int i = 1; i<n+1; i++) {
                System.out.print(i);
            }

            for (int i = a-n; i>0; i--) {
                System.out.print("  ");
            }

             for (int i = n; i>0; i--) {
                System.out.print(i);
            }
    System.out.println();
        }


    }
}
