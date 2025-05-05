/*
 * 高斯消元求解同余方程组
 */
#include <bits/stdc++.h>
using std::cin, std::cout;

int inv[100];
const int MOD = 7;
void init() {
    for (int i = 1; i <= 7; i++) {
        inv[i] = ((int)std::pow(i, 5) % MOD);
    }
}

struct Guass {
    std::vector<std::vector<int>> mat;
    int n, MOD;
    Guass(int _n, int mod) : n(_n), MOD(mod) {
        mat.assign(_n+1, std::vector<int>(_n+2, 0));
    }

    void guass_mod() {
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= n; j++) {
                if (j < i && mat[j][j] != 0) continue;
                if (mat[j][i] != 0) {
                    std::swap(mat[i], mat[j]);
                    break;
                }
            }

            if (mat[i][i] == 0) continue;

            for (int j = 1, a, b; j <= n; j++) {
                if (i == j || mat[j][i] == 0) continue;
                int gcd = std::gcd(mat[i][i], mat[j][i]);
                a = mat[i][i] / gcd;
                b = mat[j][i] / gcd;
                if (j < i && mat[j][j] != 0) {
                    for (int k = 1; k < i; k++) mat[j][k] = (mat[j][k] * a) % MOD;
                }
                for (int k = i; k <= n+1; k++) {
                    mat[j][k] = ((mat[j][k] * a - mat[i][k] * b) % MOD + MOD) % MOD;
                }
            }
            
        }
        
    }
    
    void print() {
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= n+1; j++) cout << mat[i][j] << " ";
            cout << "\n";
        }
    }
};

int main() {
    int n; cin >> n;
    init();
    Guass g(n, 7);
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n+1; j++) cin >> g.mat[i][j];
    }
    g.guass_mod();
    g.print();
    return 0;
}
