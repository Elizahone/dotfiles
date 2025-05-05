/*

* https://www.luogu.com.cn/problem/P2455
* https://www.luogu.com.cn/problem/P3389
*/

#include <bits/stdc++.h>
using std::cin, std::cout, std::string;
const double eps = 1e-7;
int n;

double a[101][102];

// bool guass() {
//     for (int i = 1; i <= n; i++) {
//         int r = i;
//         for (int j = i; j <= n; j++) {
//             if (fabs(a[j][i]) >= eps) {
//                 r = j; break;
//             }
//         }
//         if (fabs(a[r][i]) < eps) return false;  // 无解或有无穷多解
//         if (r != i) std::swap(a[r], a[i]);
//         for (int j = n+1; j >= i; j--) {
//             a[i][j] /= a[i][i];
//         }
//         for (int j = i+1; j <= n; j++) {
//             for (int k = n+1; k >= i; k--) {
//                 a[j][k] -= a[j][i] * a[i][k];
//             }
//         }
//     }
//     // 从下向上回代求解
//     for (int i = n-1; i >= 0; i--) {
//         for (int j = i+1; j <= n; j++) {
//             a[i][n+1] -= a[i][j] * a[j][n+1];
//         }
//     }
//     return true;
// }

// 可严格区分无解、无穷解
bool guass() {
    for (int i = 1; i <= n; i++) {
        int r = i;
        for (int j = 1; j <= n; j++) {
            if (j < i && fabs(a[j][j]) >= eps) continue;  // 上方有主元的直接跳过
            if (fabs(a[j][i]) > fabs(a[r][i])) r = j;
        }
        
        std::swap(a[r], a[i]);
        if (fabs(a[i][i]) < eps) continue;
        for (int j = n+1; j >= i; j--) a[i][j] /= a[i][i];
        // 将主元上下全变成 0
        for (int j = 1; j <= n; j++) {
            if (j == i) continue;
            for (int k = n+1; k >= i; k--) {
                a[j][k] -= a[j][i] * a[i][k];
            }
        }
    }
    return true;
}

void solve() {
    cin >> n;
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n+1; j++) {
            cin >> a[i][j];
        }
    }
    cout.setf(std::ios::fixed);
    cout << std::setprecision(2);
    guass();
    // for (int i = 1;  i <= n; i++) {
    //     for (int j = 1; j <= n+1; j++) {
    //         cout << a[i][j] << " ";
    //     }
    //     cout << "\n";
    // }
    int flag = 1;
    for (int i = 1; i <= n; i++) {
        if (fabs(a[i][i]) < eps && fabs(a[i][n+1]) >= eps) {
            flag = -1;
            break;
        }
        if (fabs(a[i][i]) < eps) flag = 0;
    }
    if (flag == 1) {
        for (int i = 1; i <= n; i++) {
            cout << "x" << i << "=" << a[i][n+1] << "\n";
        }
    } else {
        cout << flag << "\n";
    }
}

int main() {
    std::ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);

    solve();
    return 0;
}
