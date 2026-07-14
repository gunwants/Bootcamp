package DataStructures;
import java.util.Collections;
import java.util.LinkedList;
import java.util.Scanner;
public class linked_list__assignment {


    public static void main(String[] args) {
        LinkedList<Integer> list = new LinkedList<>();
    list.add(1);
        list.add(2);
        list.add(3);
        list.add(4);
        Scanner sc = new Scanner(System.in);
        System.out.println("Initial LinkedList: " + list);
        System.out.println("Enter the index and then enter the index");
        int addIndex = sc.nextInt();
        int elementToAdd = sc.nextInt();
        if (addIndex >= 0 && addIndex <= list.size()) {
            list.add(addIndex, elementToAdd);
            System.out.println("After adding " + elementToAdd + " at index " + addIndex + ": " + list);
        }
        System.out.println("Enter the value to be removed");
        Integer val = sc.nextInt() ;
        System.out.println("After removing vale " + val + ": " + list);
        System.out.println("enter the index to be removed");
        int rIdx = sc.nextInt();
        if (rIdx >= 0 && rIdx < list.size()) {
            int removedItem = list.remove(rIdx);
            System.out.println("After removing item at index " + rIdx + " (Value: " + removedItem + "): " + list);
        }
        System.out.println("Enter the index");
        int idx = sc.nextInt();
        if (idx >= 0 && idx < list.size()) {
            int Item = list.get(idx)
            System.out.println("Item at index " + idx + ": " + Item);
        }

        Collections.reverse(list);
        System.out.println("After reversing: " + list);

        Collections.sort(list);
        System.out.println("After sorting: " + list);
    }
}

