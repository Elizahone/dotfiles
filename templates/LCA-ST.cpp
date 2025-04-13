/*
* 树上倍增解 LCA 
*/


#include <bits/stdc++.h>
using std::cin, std::cout, std::string;

const int MAXN = 5e5+7;
int n, m, s;
int head[MAXN], next[MAXN << 1], to[MAXN << 1];
int cnt = 1;

int deep[MAXN];

int stjump[MAXN][20];

void dfs(int i, int fa) {
    deep[i] = deep[fa] + 1;
    stjump[i][0] = fa;
    for (int p = 1; p <= std::__lg(n); p++) {
        stjump[i][p] = stjump[stjump[i][p-1]][p-1];
    }
    for (int ei = head[i]; ei; ei = next[ei]) {
        if (to[ei] != fa) {
            dfs(to[ei], i);
        }
    }
}

int lca(int a, int b) {
    if (a == b) return a;
    if (deep[a] < deep[b]) {
        int tmp = a;
        a = b;
        b = tmp;
    }
    // 写法一：让 a 和 b 位于 同一层, 从 deep[a] 到 deep[b];
    // for (int p = std::__lg(n); p >= 0; p--) {
    //     if (deep[stjump[a][p]] >= deep[b]) {
    //         a = stjump[a][p];
    //     }
    // }
    // 写法二：显然，从 deep[a] 到 deep[b] 需要跳 deep[a] - deep[b] 下
    int k = deep[a] - deep[b];
    for (int p = 0; p <= std::__lg(k); p++) {
        if (k >> p & 1) {
            a = stjump[a][p];
        }
    }
    
    if (a == b) return b;

    for (int p = std::__lg(n); p >= 0; p--) {
        if (stjump[a][p] != stjump[b][p]) {
            a = stjump[a][p];
            b = stjump[b][p];
        }
    }
    // 一定会差一步到 公共祖先，原因同样是分析二进制
    return stjump[a][0];
}

void add(int u, int v) {
    next[cnt] = head[u];
    to[cnt] = v;
    head[u] = cnt++;
}



void solve() {
    cin >> n >> m >> s;
    int u, v;
    for (int i = 1; i < n; i++) {
        cin >> u >> v;
        add(u, v);
        add(v, u);
    }
    dfs(s, 0);
    for (int i = 0; i < m; i++) {
        cin >> u >> v;
        cout << lca(u, v) << "\n";
    }
}

int main() {
    std::ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);

    solve();
    return 0;
}
