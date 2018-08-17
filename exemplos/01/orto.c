#include <assert.h>
#include <stdio.h>

typedef struct par {
    int primeiro;
    int segundo;
} par;

void f(par x) {
    x.primeiro = 10;
}

void test_f() {
    par x = {1, 2};
    f(x);
    assert(x.primeiro == 1);
}

void g(int x[2]) {
    x[0] = 10;
}

void test_g() {
    int x[2] = {1, 2};
    g(x);
    // vetores não podem ser passados como parâmetro por valor!
    assert(x[0] == 10);
}

int main(int argc, char *argv[]) {
    test_f();
    test_g();
    return 0;
}
