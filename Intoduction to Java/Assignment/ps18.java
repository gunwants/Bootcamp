package Assignment;
import java.util.*;
public class ps18 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int a = sc.nextInt();

        for (int n = a; n > 0; n--) {
            for (int i = n; i > 0; i--) {
                System.out.print(i);
            }

            for (int i = 0; i < a - n; i++) {
                System.out.print("  ");
            }

             for (int i = 1; i <= n; i++) {
                System.out.print(i);
            }
    System.out.println();
        }


    }
}

