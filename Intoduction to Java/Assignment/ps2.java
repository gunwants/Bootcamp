package Assignment;

import java.util.*;
public class ps2 {
    public static void main(String[] args){
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter First Number :");
        int first= sc.nextInt();
        System.out.println("Enter Second Number :");
        int second= sc.nextInt();
        System.out.println("Enter Third Number :");
        int third= sc.nextInt();
        int arr[] ={first,second,third};
        Arrays.sort(arr);
        System.out.println("The Second Largest Number is :"+arr[arr.length-2]); // First Method
        int ans =Integer.MIN_VALUE;
        for(int i=0;i<arr.length;i++){
            if(arr[i]>ans && arr[i]!=Arrays.stream(arr).max().getAsInt()){
                ans = arr[i];
            }
        }
        System.out.println("The Second Largest Number is :"+ans); // Second Method
    }   
    }