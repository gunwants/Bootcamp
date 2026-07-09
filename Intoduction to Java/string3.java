import java.util.*;
public class string3 {
    public static void main(String[] args){
        System.out.println("Enter an email address:");
        Scanner sc= new Scanner(System.in);
        String email = sc.nextLine();
        for(int i=0; i<email.length();i++){
            if(email.charAt(i)=='@'){
                System.out.println("Username:"+email.substring(0,i));
            }
        
}
    }}
