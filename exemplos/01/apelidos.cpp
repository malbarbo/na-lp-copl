#include <cassert>
#include <vector>

using namespace std;

int main(int argc, char *argv[]) {
    vector<int> v = {10, 20, 30};
    int soma = 0;
    for (int &x : v) {
        soma += x;
        if (x == 20) {
            v.push_back(1);
        }
    }
    assert(soma == 61);
    return 0;
}
