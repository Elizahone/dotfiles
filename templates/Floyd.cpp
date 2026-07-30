/*
* 佛洛伊德
*  https://www.luogu.com.cn/problem/P2910
*/


#include <bits/stdc++.h>
using std::cin, std::cout, std::string;

int n, m;

int path[100002];
int d[101][101];


void solve() {
    cin >> n >> m;
    for (int i = 1; i <= m; i++) cin >> path[i];
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++) cin >> d[i][j];
    }

    for (int k = 1; k <= n; k++) {
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= n; j++) {
                d[i][j] = std::min(d[i][j], d[i][k] + d[k][j]);
            }
        }
    }
    int ans = 0;
    for (int i = 1; i < m; i++) {
        ans += d[path[i]][path[i+1]];
    }
    cout << ans << std::endl;
}

int main() {
    std::ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);

    solve();
    return 0;
}
