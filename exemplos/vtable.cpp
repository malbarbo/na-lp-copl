#include <cstdio>
#include <cmath>
#include <algorithm>

using namespace std;

class Base {
    public:
        int c1;
        long c2;
        void f1() { printf("Base.f1\n"); }
        virtual void f2() { printf("Base.f2\n"); }
        virtual void f3() { printf("Base.f3\n"); }
};

class Derivada: public Base {
    public:
        int c3;
        void f1() { printf("Derivada1.f1\n"); }
        virtual void f2() { printf("Derivada1.f2\n"); }
};

typedef long int * pointer;

void dump(const char* label, pointer m, int n) {
    for (int i = 0; i < n; i++) {
        printf("  %s[%d]: %lX\n", label, i, m[i]);
    }
}

int main(int argc, char* args[]) {
    Base b;
    b.c1 = 0x1234ABCD;
    b.c2 = 0x56789;    
    pointer pb = (pointer) &b;
    Derivada d;
    pointer pd = (pointer) &d;
    printf("Base\n");
    printf("  &f1: %p\n", (void *) &Base::f1);
    printf("  &f2: %p\n", (void *) &Base::f2);
    printf("  &f3: %p\n", (void *) &Base::f3);
    printf("Derivada\n");
    printf("  &f1: %p\n", (void *) &Derivada::f1);
    printf("  &f2: %p\n", (void *) &Derivada::f2);
    printf("  &f3: %p\n", (void *) &Derivada::f3);
    printf("b\n");
    printf("  tamanho  : %d\n", sizeof(b));
    printf("  &        : %lX\n", &b);
    printf("  &c1      : %lX\n", &b.c1);
    printf("  &c2      : %lX\n", &b.c2);
    printf("  c1       : %lX\n", b.c1);
    printf("  c2       : %lX\n", b.c2);
    dump("memoria", pb, max(1lu, sizeof(b) / 8));
    dump("vtable", (pointer)pb[0], 2);
    printf("d\n");
    printf("  tamanho  : %d\n", sizeof(d));
    printf("  &        : %lX\n", &d);
    printf("  &c1      : %lX\n", &d.c1);
    printf("  &c2      : %lX\n", &d.c2);
    printf("  &c3      : %lX\n", &d.c3);
    printf("  c1       : %lX\n", d.c1);
    printf("  c2       : %lX\n", d.c2);
    printf("  c3       : %lX\n", d.c3);
    dump("memoria", pd, max(1lu, sizeof(d) / 8));
    dump("vtable", (pointer)pd[0], 2);
}
