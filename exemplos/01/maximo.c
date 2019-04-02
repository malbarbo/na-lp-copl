#include <assert.h>
#include <stddef.h>
#include <stdio.h>

int maximo(int lst[], size_t n)
{
    assert(n > 0);
    int max = lst[0];
    for (size_t i = 1; i < n; i++) {
        if (lst[i] > max) {
            max = lst[i];
        }
    }
    return max;
}

int main()
{
    assert(maximo((int[]){5, 4, 13, 0, 9}, 5) == 13);
    printf(".");
    assert(maximo((int[]){5, 4, 0, 9}, 4) == 9);
    printf(".");
    assert(maximo((int[]){5, 4, 0} , 3) == 5);
    printf(".");
    assert(maximo((int[]){4}, 1) == 4);
    printf(".\n");
    return 0;
}
