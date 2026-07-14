package DataStructures;
import java.util.*;
public class Linked_list {
    public static void main(String args[]){
      LinkedList<Integer> lst= new LinkedList<>();
      Scanner sc = new Scanner(System.in);
    while(true){
        System.out.println("Enter elements,-1 to abort:");
        int a = sc.nextInt();
        if(a==-1){
            break;
        }
        lst.add(a);

    }
    
}
}
