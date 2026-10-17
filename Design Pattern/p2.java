public class p2 {
    public static void main(String[] args) {
        Pizza[] orders = {
            PizzaFactory.createPizza("cheese"),
            PizzaFactory.createPizza("veggie"),
            PizzaFactory.createPizza("clam"),
            PizzaFactory.createPizza("pepperoni")
        };

        for (Pizza pizza : orders) {
            if (pizza == null) {
                System.out.println("Unknown pizza type requested.");
                continue;
            }
            System.out.println("\n--- Making " + pizza.getName() + " ---");
            pizza.prepare();
            pizza.bake();
            pizza.cut();
            pizza.box();
        }
    }
}
