/*
* 异或空间线性基
*/

#include <bits/stdc++.h>
using std::cin, std::cout, std::string;
long long arr[100];
const int BIT = 60;

bool zero = false;

struct XorBase {
    std::vector<long long> arr, basis;
    int BIT;
    bool zero;
    XorBase(int n): BIT(60), zero(false) {
        arr.assign(n, 0);
    }
    void get_base() {
        basis.assign(BIT+1, 0);
        int n = arr.size();
        for (int i = 0; i < n; i++) {
            int num = arr[i];
            for (int j = BIT; j >= 0; j--) {
                if (num >> j == 1) {
                    if (basis[j] == 0) {
                        basis[j] = num;
                        break;
                    }
                    num ^= basis[j];
                }
            }
            zero = true;
        }
    }
};
int len;
void gauss_get_base(int n) {
    len = 0;
    for (int i = BIT; i >= 0 && len < n; i--) {
        for (int j = len; j < n; j++) {
            if ((arr[j] & (1LL << i)) != 0) {
                std::swap(arr[j], arr[len]);
                break;
            }
        }
        if ((arr[len] & (1LL << i)) == 0) continue;
        for (int j = 0; j < n; j++) {
            if (j != len && (arr[j] & (1LL << i)) != 0) {
                arr[j] ^= arr[len];
            }
        }
        len++;
    }
    zero = len != n;
}

void solve() {
    // XorBase x(4);
    arr[0] = 7, arr[1] = 10, arr[2] = 4, arr[3] = 33;
    gauss_get_base(3);
    for (int i = 0; i < len; i++) cout << arr[i] << " ";
    cout << "\nzero: " << zero << "\n";
}

int main() {
    std::ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);

    solve();
    return 0;
}
