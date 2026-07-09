import java.util.*;
public class string2 {
    public static void main(String args[]){
    Scanner sc = new Scanner(System.in);
    System.out.println("Enter the original String");
    String org = sc.nextLine();
    String res = "";
    for(int i=0;i<org.length();i++){
        if(org.charAt(i)=='e'){
            res += "i";
        }
        else{
        res += org.charAt(i);
        }
    }
    System.out.println("Modified String: " + res);
    }
}
