#include <iostream>
#include <vector>
using namespace std;
const int MAXSIZE = 10000;
const int MAXN = 26;
int Trie[MAXSIZE][MAXN];
int sz = 0;

void f(string &s) {
    int cur = 0;
    for (int i = 0; i < s.size(); i++) {
        if (Trie[cur][s[i] - 'a'] == 0) {
            Trie[cur][s[i] - 'a'] = ++sz;
        }
        cur = Trie[cur][s[i] - 'a'];
    }
}

void build(vector<string> &strs) {
    for (auto &s : strs) {
        f(s);
    }
}

int main() {

    vector<string> strs{"abca", "bcb", "ca", "cc", "d"};

    build(strs);

    for (int i = 0; i <= sz; i++) {
        for (int j = 0; j < 4; j++) {
            cout << Trie[i][j] << " ";
        }
        cout << "\n";
    }

    return 0;
}
