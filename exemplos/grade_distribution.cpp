// Grade Distribution
// Input: A list of integer values that represent grades, followed by a negative number
// Output: A distribution of grades, as a percentage for each of the categories 0-9, 10-19, ..., 90-100

#include <iostream>
#include <iomanip>

using namespace std;

int main()
{
    class NegativeInputException {
        public: NegativeInputException() {
            cout << "End of input data reached" << endl;
        }        
    };

    int freq[10] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    try {
        while (true) {
            int new_grade;
            cout << "Please input a grade" << endl;
            cin >> new_grade;
            if (new_grade < 0) {
                throw NegativeInputException();
            }
            int index = new_grade / 10;
            try {
                if (index > 9) {
                    throw new_grade;
                }
                freq[index]++;
            } catch (int grade) {
                if (grade == 100) {
                    freq[9]++;
                } else {
                    cout << "Error -- new grade: " << grade << " is out of range" << endl;
                }
            } // catch
        }
    } catch (NegativeInputException& e) {
        cout << setw(16) << "Limits" << setw(8) << "Freq" << endl;
        for (int index = 0; index < 10; index++) {
            int limit_1 = 10 * index;
            int limit_2 = limit_1 + 9;
            if (index == 9) {
                limit_2 = 100;
            }
            cout << setw(8) << limit_1 << setw(8) << limit_2 << setw(8) << freq[index] << endl;
        }
    } // catch
}
