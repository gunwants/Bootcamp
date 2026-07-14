package DataStructures;

import java.util.*;

public class university {
    static class Student {
        String name;
        int id;
        List<String> preferences;
        int marks;
        String assignedUniversity;
        int tieBreaker;

        public Student(String name, int id, List<String> preferences, int marks) {
            this.name = name;
            this.id = id;
            this.preferences = preferences;
            this.marks = marks;
            this.assignedUniversity = "Unassigned";
            this.tieBreaker = new Random().nextInt(100);
        }
    }

    static class Univ {
        String name;
        int seats;

        public Univ(String name, int seats) {
            this.name = name;
            this.seats = seats;
        }
    }

    public static void main(String[] args) {
        List<Univ> seats = new ArrayList<>();
        seats.add(new Univ("National Institute of Technology", 4));
        seats.add(new Univ("Science and Technology Academy", 3));
        seats.add(new Univ("State University", 5));
        seats.add(new Univ("Commerce College", 1));
        seats.add(new Univ("Arts and Design University", 0));

        Map<String, Univ> seatMap = new HashMap<>();
        for (Univ u : seats) {
            seatMap.put(u.name, u);
        }

        List<Student> applicants = new ArrayList<>();
        applicants.add(new Student("Aisha Khan", 101, Arrays.asList("National Institute of Technology", "Science and Technology Academy", "State University", "Commerce College", "Arts and Design University"), 95));
        applicants.add(new Student("Rajan Patel", 102, Arrays.asList("Commerce College", "National Institute of Technology", "Arts and Design University", "Commerce College", "Science and Technology Academy"), 92));
        applicants.add(new Student("Mia Chen", 103, Arrays.asList("Science and Technology Academy", "National Institute of Technology", "State University", "Arts and Design University", "Commerce College"), 95));
        applicants.add(new Student("Noah Smith", 104, Arrays.asList("Commerce College", "Arts and Design University", "State University", "Science and Technology Academy", "National Institute of Technology"), 88));
        applicants.add(new Student("Sofia Lopez", 105, Arrays.asList("Arts and Design University", "Science and Technology Academy", "State University", "Commerce College", "National Institute of Technology"), 90));
        applicants.add(new Student("Ethan Gray", 106, Arrays.asList("National Institute of Technology", "State University", "Science and Technology Academy", "Arts and Design University", "Commerce College"), 92));
        applicants.add(new Student("Priya Sharma", 107, Arrays.asList("State University", "Commerce College", "Arts and Design University", "Science and Technology Academy", "National Institute of Technology"), 85));
        applicants.add(new Student("Liam Johnson", 108, Arrays.asList("Science and Technology Academy", "National Institute of Technology", "Commerce College", "State University", "Arts and Design University"), 88));

        System.out.println("ENTER CANDIDATE DETAILS");
        System.out.println("-1 to stop entering candidates)\n");
        Scanner scanner = new Scanner(System.in);
        while (true) {
            System.out.print("Enter Student Name: ");
            String name = scanner.nextLine();
            if (name.equals("-1")) {
                break;
            }

            System.out.print("Enter Student ID: ");
            int id = Integer.parseInt(scanner.nextLine().trim());

            System.out.print("Enter Student Marks: ");
            int marks = Integer.parseInt(scanner.nextLine().trim());
            System.out.println("Available Universities:");
            for (int i = 0; i < seats.size(); i++) {
                System.out.println("  " + (i + 1) + ". " + seats.get(i).name);
            }
            
            System.out.print("Enter preferred university numbers in order of preference (comma-separated, e.g., 1,3,2): ");
            String[] choices = scanner.nextLine().split(",");
            
            List<String> userPreferences = new ArrayList<>();
            for (String choice : choices) {
                int index = Integer.parseInt(choice.trim()) - 1;
                if (index >= 0 && index < seats.size()) {
                    userPreferences.add(seats.get(index).name);
                }
            }

            applicants.add(new Student(name, id, userPreferences, marks));
            System.out.println("-> Student Added Successfully!\n");
        }

        applicants.sort((a, b) -> {
            if (b.marks == a.marks) {
                return Integer.compare(b.tieBreaker, a.tieBreaker);
            }
            return Integer.compare(b.marks, a.marks);
        });

        for (Student student : applicants) {
            for (String choice : student.preferences) {
                Univ u = seatMap.get(choice);
                if (u != null && u.seats > 0) {
                    student.assignedUniversity = u.name;
                    u.seats--;
                    break;
                }
            }
        }

        System.out.println("=== COUNSELLING RESULTS ===");
        for (Student s : applicants) {
            System.out.println(s.id + " | " + s.name + " | Marks: " + s.marks + " -> " + s.assignedUniversity);
        }
        scanner.close();
    }
}