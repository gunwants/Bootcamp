import java.util.*;

public class ps3 {
    
    static class cart {
        public String owner_name;
        public long cart_number;
        public String type;
        private double balance; 
        private double cart_total; // Stores the cost of items added
       
        public void setbalance(double bal){
            this.balance = bal;
        }
        public double getbalance(){
            return this.balance;
        }
        
        cart() {
            Scanner sc = new Scanner(System.in);
            System.out.println("Please enter the owner name:");
            this.owner_name = sc.next().toLowerCase();
            System.out.println("Please enter the Cart Number:");
            this.cart_number = sc.nextLong();
            System.out.println("Please enter the account type (Premium/Regular):");
            this.type = sc.next().toLowerCase();
            
            if(type.equals("premium")) {
                setbalance(100.0);
                this.cart_total = 0.0;
            }
            else if (type.equals("regular")) {
                setbalance(50.0);  
                this.cart_total = 0.0;
            }
            else {
                throw new IllegalArgumentException("Please enter a supported type");
            }
        }
        
        public void remove_items(double item_cost) {
            this.cart_total -= item_cost;
            this.balance += item_cost; 
            System.out.println("Removed item costing $" + item_cost);
        }
        public void add_items(double item_cost) {
            if(this.balance >= item_cost) {
                this.cart_total += item_cost;
                this.balance -= item_cost; 
                System.out.println("Successfully added item costing " + item_cost);
            } else {
                System.out.println("Declined: Item costing $" + item_cost + " exceeds your remaining budget of " + this.balance);
            }
        }
        
        public void display() {
            System.out.println("\n--- Cart Invoice ---");
            System.out.println("Owner: " + this.owner_name);
            System.out.println("Cart ID: " + this.cart_number);
            System.out.println("Cart Total: $" + this.cart_total);
            System.out.println("Remaining Budget: $" + getbalance());
            System.out.println("--------------------\n");
        }
    }
    
    public static void main(String[] args) {
       
        cart c1 = new cart();
        c1.display();
        
        System.out.println("getbalance()");
        System.out.println(c1.getbalance());
       System.out.println("\nsetbalance() ---");
        
        c1.setbalance(150.0);
        c1.display();

        System.out.println("Adding items");
        c1.add_items(45.50);
        c1.add_items(120.00); 
        c1.display();

        System.out.println("--- remove_items() ---");
        c1.remove_items(15.50); // Removing a small item
        c1.display();
    }
}
