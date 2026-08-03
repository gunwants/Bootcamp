import java.util.*;

public class ps2 {
    /*static HashMap<String, Integer> books = new java.util.HashMap<>();
    static {
        books.put("Aladin", 3);
    }
    public void add_book(){
        Scanner sc = new Scanner(System.in);
        String name=sc.next().toLowerCase();
        int count=sc.nextInt();
        books.put(name,count);
    }*/
    static class member{
        public String Name;
        public long ac_number;
        public String type;
        private int balance;
       
        public void setbalance(int bal){
            this.balance=bal;
        }
        public int getbalance(){
            return this.balance;
        }
        member(){
            Scanner sc = new Scanner(System.in);
            System.out.println("please enter the name");
            this.Name=sc.next().toLowerCase();
            System.out.println("please enter the Account Number");
            this.ac_number=sc.nextLong();
            System.out.println("please enter the type (Teacher/student)");
            this.type=sc.next().toLowerCase();
            if(type.equals("student")){
                setbalance(5);
            }
            else if (type.equals("teacher")) {
                setbalance(3);
            }
            else{
                throw new IllegalArgumentException("Please enter the supported type");
            }

        }
        public void deposit_back(int n){
            this.balance += n;
        }
        public void borrow(int n){
            if(this.balance>=n){
                this.balance-=n;
            }
        }
        public void display(){
            System.out.println(this.Name);
            System.out.println(getbalance());
        }

    }
    public static void main(String[] args) {
       
        member m1 = new member();
        m1.display();
        System.out.println(" getbalance()");
        System.out.println("Returned balance using getter: " + m1.getbalance());
        System.out.println("\nTesting setbalance()");
        m1.setbalance(10);
        m1.display();

        
        System.out.println("Borrowing...");
        m1.borrow(4);
        m1.display();

        System.out.println("\ndeposit_back()");
        System.out.println("Returning...");
        m1.deposit_back(2);
        m1.display();

       
        
        
       
    }
}
