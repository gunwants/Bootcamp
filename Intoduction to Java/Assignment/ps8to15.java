package Assignment;
public class ps8to15 {
    public static void fibonacci(int n){
        int a=0;
        int b=1;
        for(int i=0;i<n;i++){
            if(i<2){
                System.out.print(i+" ");
            }
            else{
                int c=a+b;
                System.out.print(c+" ");
                a=b;
                b=c;
            }
        }
    }
    public static void fibonacci_till_n(int n){
        int a=0;
        int b=1;
        for(int i=0;;i++){
            if(i<2){
                System.out.print(i+" ");
            }
            else{
                int c=a+b;
                if(c>n) break;
                System.out.print(c+" ");
                a=b;
                b=c;
            }
        }
    }
    public static boolean prime(int n){
        if(n<2){
            return false;
        }
        for(int i=2;i<Math.sqrt(n);i++){
            if(n%i==0){
                return false;
            }
        }
        return true;
    }
    public static void PrimeNfibo(int n) {
    int a = 0;
    int b = 1;

    for (int i = 0; n > 0; i++) {

            int c = a + b;

            if (prime(c)) {
                System.out.print(c + " ");
                n--;
            }

            a = b;
            b = c;
        
    }
}    
    public static void PrimeNfibo_lessN(int n) {
    int a = 0;
    int b = 1;

    for (int i = 0; i<n; i++) {

            int c = a + b;

            if (prime(c)) {
                System.out.print(c + " ");
                n--;
            }

            a = b;
            b = c;
        
    }
}
    public static void armstrong(int n){
        for (int i=0;i<n;i++){
            double sum=0;
            int num=i;
            while(num>0){
            int d=num%10;
            sum=sum+(d*d*d);
            num=num/10;
            }
            if(sum==i){
                System.out.print(i+" ");
            }
        }
    }
    public static void singledigit(int n){
        int num=n;
        while(num>10){
            int sum=0;
            while(num>0){
                sum+=num%10;
                num=num/10;
            }
            num=sum;
        }
        System.out.println(num);
    }
    public static int factorial(int n){
        if(n==0||n==1){
            return 1;
        }
    return (n*factorial(n-1));
    }
    public static void pr_armstrong(int n){
        for (int i=0;i<n;i++){
            double sum=0;
            int num=i;
            while(num>0){
            int d=num%10;
            sum=sum+(d*d*d);
            num=num/10;
            }
            if(sum==i&&prime(i)){
                System.out.print(i+" ");
            }
        }
    }
    public static void main(String[] args){
        fibonacci(10);
        System.out.println("\nTill N");
        fibonacci_till_n(100);
        System.out.println("\nPrime and fibonacci");
        PrimeNfibo(10);
        System.out.println("\nPrime and fibonacci less than N");
        PrimeNfibo_lessN(10);
        System.out.println("\nArmstrong");
        armstrong(10000);
        System.out.println("\n Single digit");
        singledigit(1245);
        System.out.println("\nFactorial");
        System.out.println(factorial(3));
        System.out.println("Prime and armstrong");
        pr_armstrong(1000000);
        

        
}
}
