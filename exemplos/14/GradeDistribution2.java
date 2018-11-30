// Grade Distribution
// Input: A list of integer values that represent grades, followed by a negative number
// Output: A distribution of grades, as a percentage for each of the categories 0-9, 10-19, ..., 90-100

import java.util.Scanner;

public class GradeDistribution2 {
    private Scanner in;
    private int[] frequency;

    public GradeDistribution2() {
        in = new Scanner(System.in);
        frequency = new int[10];
    }

    int readInt(int min, int max, String message) {
        while (true) {
            System.out.print(message);
            String s = in.nextLine();
            try {
                int i = Integer.parseInt(s);
                if (min <= i && i <= max) {
                    return i;
                }
            } catch (NumberFormatException e) {
            }
            System.out.println("Invalid input: " + s);
        }
    }

    void readAndDistributeGrades() {
        while (true) {
            int grade = readInt(-1, 100, "Grade (0-100 or -1 to end): ");
            if (grade < 0) {
                break;
            }
            distributeGrade(grade);
        }
    }

    void distributeGrade(int grade) {
        int index = grade < 100 ? grade / 10 : 9;
        frequency[index] += 1;
    }

    void printFrequency() {
        System.out.printf("%16s %8s\n", "Limits", "Freq");
        for (int index = 0; index < 10; index++) {
            int limit1 = 10 * index;
            int limit2 = limit1 + 9;
            if (index == 9) {
                limit2 = 100;
            }
            System.out.printf("%8d%8d%8d\n", limit1, limit2, frequency[index]);
        }
    }

    public static void main(String[] args) {
        GradeDistribution2 g = new GradeDistribution2();
        g.readAndDistributeGrades();
        g.printFrequency();
    }
}
