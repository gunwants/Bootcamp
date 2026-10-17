public abstract class Pizza {
    protected String name;

    public void prepare() {
        System.out.println("Preparing " + name);
    }

    public void bake() {
        System.out.println("Baking " + name + " at 350 degrees for 25 minutes");
    }

    public void cut() {
        System.out.println("Cutting " + name + " into diagonal slices");
    }

    public void box() {
        System.out.println("Boxing " + name + "");
    }

    public String getName() {
        return name;
    }
}
