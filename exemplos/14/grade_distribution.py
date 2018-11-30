#!/usr/bin/env python3
# encoding: utf-8

# Grade Distribution
# Input: A list of integer values that represent grades, followed by a negative number
# Output: A distribution of grades, as a percentage for each of the categories 0-9, 10-19, ..., 90-100

import sys


def read_ints(min, max, stop, message):
    while True:
        try:
            s = input(message)
            i = int(s)
            if min <= i <= max:
                yield i
                continue
            elif i == stop:
                return
        except KeyboardInterrupt:
            return
        except:
            pass

        print("Invalid input:", s)


def distribute_grades(grades):
    frequency = [0] * 10
    for grade in grades:
        index = grade // 10 if grade < 100 else 9
        frequency[index] += 1
    return frequency


def print_frequency(frequency):
    print("%16s%8s" % ("Limits", "Freq"))
    for i in range(10):
        limit1 = 10 * i
        limit2 = limit1 + 9 if i < 9 else 100
        print("%8d%8d%8d" % (limit1, limit2, frequency[i]))


def main():
    grades = read_ints(0, 100, -1, "Grade (0-100 or -1 to end): ")
    frequency = distribute_grades(grades)
    print_frequency(frequency)


if __name__ == "__main__":
    main()
