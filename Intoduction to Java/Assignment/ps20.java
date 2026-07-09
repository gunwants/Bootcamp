package Assignment;

public class ps20 {
    public static int factorial(int n){
        if(n==0||n==1){
            return 1;
        }
    return (n*factorial(n-1));
    }
    public static void main(String[] args){
        int N=5;
        double sum=0;
        for(int i=1;i<=N;i++){
        if(i%2!=0){
        sum=sum+(double)(i)/factorial(i);}
        else{
           sum=sum-((double) i/factorial(i)); 
        }
        }
        System.out.println(sum);
    }
    
}
