public class ps1 {
    static class ratio {
        private int p;
        private int q;

        ratio(int p, int q){
            
            if (q == 0){
                throw new IllegalArgumentException("q cannot be zero");
            }
            this.p = p;
            this.q = q;
        }
        public int getP(){
            return this.p;
        }
        public int getQ(){
            return this.q;
        }
        public ratio add(ratio b){
            int p = this.p * b.q + b.p * this.q;
            int q = this.q * b.q;
            return new ratio(p, q);
        }
        public ratio sub(ratio b){
            int p = this.p * b.q - b.p * this.q;
            int q = this.q * b.q;
            return new ratio(p, q);
        }
        public ratio multiply(ratio b){
            int p = this.p * b.p;
            int q = this.q * b.q;
            return new ratio(p, q);
        }
        public ratio divide(ratio b){
            int p = this.p * b.q;
            int q = this.q * b.p;
            return new ratio(p, q);
        }
        public boolean equals(ratio a, ratio b){
            return (a.p==b.p)&&(a.q==b.q);
        }
        public String display(){
            return p+"/"+q;
        }
        

    }

    public static void main(String[] args){
        /*Define an interface and implement abstract data type (ADT)  for “ratio” (P:Q, which could be taken as P/Q). 
        Where Data type:
        - P : integer;
        - Q : integer;
        Operations :
        Add, Sub, Multiply, Equal, Divide, Get P, Get Q
        Condition :
        Q should be different from zero
     */
    ratio r1 = new ratio(1, 2); 
    ratio r2 = new ratio(2, 4); 
    ratio r3 = new ratio(2, 3); 
    ratio sum = r1.add(r3);       
    ratio diff = r1.sub(r3);      
    ratio prod = r1.multiply(r3);  
    ratio quot = r1.divide(r3);    

        System.out.println("r1: " + r1);
        System.out.println("r2: " + r2);
        System.out.println("r3: " + r3);
        System.out.println("----------------------");
        System.out.println("Is r1 equal to r2? " + r1.equals(r2)); 
        System.out.println("Is r1 equal to r3? " + r1.equals(r3)); 
        System.out.println("Add: " + sum);          
        System.out.println("Sub: " + diff);         
        System.out.println("Multiply: " + prod);    
        System.out.println("Divide: " + quot);      
    }
}

