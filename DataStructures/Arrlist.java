package DataStructures;
import java.util.*;
public class Arrlist {
    public static void main(String[] args){
       int currentCapacity = 3;
       int[] arr = new int[currentCapacity];
       Scanner sc = new Scanner(System.in);

       

System.out.println("Enter 10 numbers:");
for (int i = 0; i < 10; i++) {
    if (i == currentCapacity) {
        System.out.println("The internal array is full! Scaling capacity...");
        currentCapacity = currentCapacity *2;
        int[] expandedarr=Arrays.copyOf(arr, currentCapacity); 
        arr=expandedarr;
        
    }
    arr[i]=sc.nextInt();
}
    System.out.println("Enter the location of the element then enter the element");
    int idx=sc.nextInt();
    int ele=sc.nextInt();
    int[] narr = new int[currentCapacity];
    for(int i=0;i<currentCapacity;i++){
      if(i<idx-1){
        narr[i]=arr[i];
      }
      if(i==idx-1){
          narr[i];
      }
      else{
        narr[i+1]=narr[i];
      }
    }
    arr=narr;
    System.out.println(arr);
    System.out.println("Enter the element to search:");
    int t=sc.nextInt();
    for(int i=0;i<currentCapacity;i++){
        if(i==currentCapacity){
            System.err.println("Element not found");
            break;
        }
        if(arr[i]==t){
            System.out.println("The first Occurence is"+i);
            break;
        }
        
    }
    System.out.println("Enter the index from where item to be removed");
    idx=sc.nextInt();

        if(idx>=0&&idx < currentCapacity){
            for (int i = idx; i < currentCapacity - 1; i++) {
        arr[i] = arr[i + 1];
    }
        currentCapacity--;
        System.out.println("Element removed successfully");
        }
        else{
            System.out.println("Invalid Index");
        }
    
    System.out.println("Enter the item to be removed");
    ele=sc.nextInt();
    for(int i=0;i<currentCapacity;i++){
        if(arr[i]==ele){
            for (int j = idx; j < currentCapacity - 1; j++) {
        arr[j] = arr[j + 1];
    }
        currentCapacity--;
        System.out.println("Element removed successfully");
            
            break;
        }
    }
    System.out.println("The Arraylist is being reversed");
    for(int i=0,j=currentCapacity-1;i<j;i++,j--){
      int temp = arr[i];
      arr[i] = arr[j];
      arr[j] =temp;
    }
    System.out.println(arr);
    }
    }
