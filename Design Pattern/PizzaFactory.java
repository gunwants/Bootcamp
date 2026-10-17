public class PizzaFactory {
    public static Pizza createPizza(String type) {
        if (type == null) {
            return null;
        }
        switch (type.toLowerCase()) {
            case "cheese":
                return new CheesePizza();
            case "veggie":
                return new VeggiePizza();
            case "clam":
                return new ClamPizza();
            case "pepperoni":
                return new PepperoniPizza();
            default:
                return null;
        }
    }
}
