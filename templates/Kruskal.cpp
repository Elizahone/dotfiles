/*
* https://www.luogu.com.cn/problem/P3366
*/

#include <bits/stdc++.h>
using std::cin, std::cout, std::string;
const int MAXN = 5001;
const int MAXM = 2e5+1;

std::vector<std::vector<int>> edge(MAXM);

int fa[MAXN];

int find(int x) { return x == fa[x] ? x : fa[x] = find(fa[x]); }

int merge(int x, int y) {
    int fx = find(x), fy = find(y);
    if (fx == fy) return false;
    fa[fx] = fy;
    return true;
}


void solve() {
    int n, m; cin >> n >> m; int u, v, w;
    for (int i = 0; i <= n; i++) fa[i] = i;
    for (int i = 0; i < m; i++) {
        cin >> u >> v >> w;
        edge[i] = {u, v, w};
    }
    std::sort(edge.begin(), edge.begin()+m, [](auto& a, auto& b) { return a[2] < b[2]; });
    int ans = 0, cnt = 0;
    for (int i = 0; i < m; i++) {
        u = edge[i][0], v = edge[i][1], w = edge[i][2];
        if (merge(u, v)) {
            cnt++;
            ans += w;
        }
    }
    if (cnt != n-1) {
        cout << "orz\n";
    } else {
        cout << ans << "\n";
    }
}

int main() {
    std::ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);

    solve();
    return 0;
}
