/*
 * 高斯消元求解异或方程组
 * https://www.luogu.com.cn/problem/P2962 该代码
 * https://www.luogu.com.cn/problem/P2447
*/

#include <bits/stdc++.h>
using std::cin, std::cout, std::string;
int a[400][401];
int n,m;
void guass_xor(int n) {
    for (int i = 1; i <= n; i++) {
        // 找到不为的主元
        for (int j = 1; j <= n; j++) {
            if (j < i && a[j][j] == 1) continue;
            if (a[j][i] == 1) {
                std::swap(a[i], a[j]);
                break;
            }
        }
        if (a[i][i] == 0) continue; // 无唯一解
        for (int j = 1; j <= n; j++) {
            // 消去每行的 1
            if (j == i || a[j][i] == 0) continue;
            for (int k = i; k <= n+1; k++) {
                a[j][k] ^= a[i][k];
            }
        }
    }
}

int op[40];
int ans = 0;

void dfs(int i, int num) {
    if (num >= ans) return ;
    if (i == 0) {
        ans = num;
        return;
    }
    if (a[i][i] == 1) {
        int cur = a[i][n+1];
        for (int j=i+1; j <= n; j++) if (a[i][j]) cur ^= op[j];
        dfs(i-1, cur + num);
    } else {
        op[i] = 0;
        dfs(i-1, num);
        op[i] = 1;
        dfs(i-1, 1+num);
    }
}

void solve() {

    cin >> n >> m; int u, v;
    for (int i = 1; i <= m; i++) {
        cin >> u >> v;
        a[u][v] = a[v][u] = 1;
    }
    for (int j = 1; j <= n; j++) a[j][n+1] = 1, a[j][j] =1;
    guass_xor(n);
    
    int flag = 1;
    for (int i = 1; i <= n; i++) {
        if (a[i][i] == 0) {
            flag = 0;
            break;
        }
        ans += a[i][n+1];
    }
    if (flag) {
        cout << ans << "\n";
    } else {
        ans = n;
        dfs(n, 0);
        cout << ans << "\n";
    }
}


int main() {
    std::ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);
    solve();
    return 0;
}
