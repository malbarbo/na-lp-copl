// Grade Distribution
// Input: A list of integer values that represent grades, followed by a negative number
// Output: A distribution of grades, as a percentage for each of the categories 0-9, 10-19, ..., 90-100

import java.io.*;

class NegativeInputException extends Exception {
    public NegativeInputException() {
        System.out.println("End of input data reached");
    }
}

public class GradeDistribution {
    int[] freq = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

    void buildDist() throws IOException {
        DataInputStream in = new DataInputStream(System.in);
        try {
            while (true) {
                System.out.println("Please input a grade");
                int newGrade = Integer.parseInt(in.readLine());
                if (newGrade < 0) {
                    throw new NegativeInputException();
                }
                int index = newGrade / 10;
                try {
                    freq[index]++;
                } catch (ArrayIndexOutOfBoundsException e) {
                    if (newGrade == 100) {
                        freq[9]++;
                    } else {
                        System.out.println("Error -- new grade: " + newGrade + " is out of range");
                    }
                } // catch
            }
        } catch (NegativeInputException e) {
            System.out.printf("%16s %8s\n", "Limits", "Freq");
            for (int index = 0; index < 10; index++) {
                int limit_1 = 10 * index;
                int limit_2 = limit_1 + 9;
                if (index == 9) {
                    limit_2 = 100;
                }
                System.out.printf("%8d%8d%8d\n", limit_1, limit_2, freq[index]);
            }
        } // catch
    }

    public static void main(String[] args) throws IOException {
        new GradeDistribution().buildDist();
    }
}
