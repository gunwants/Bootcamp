package Assignment;
import java.util.*;
    import java.util.Scanner;

public class ps17 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();

        for(int i=1; i<=n; i++){
            for(int j=0; j<n-i; j++){ //spaces
                System.out.print(" ");
            }
            for(int j=1; j<=i; j++){
                System.out.print(j);
            }
            for(int j=i-1; j>=1; j--){
                System.out.print(j);
            }

            System.out.println(); 
        }
        for(int i=n-1;i>0;i--){
           for(int j=0; j<n-i; j++){
                System.out.print(" ");
            }
            for(int j=1; j<=i; j++){
                System.out.print(j);
            }
            for(int j=i-1; j>=1; j--){
                System.out.print(j);
            }
            System.out.println();
        }

        sc.close();
    }
}

