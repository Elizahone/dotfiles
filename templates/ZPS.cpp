/*
  左偏树  https://www.luogu.com.cn/problem/P3377
*/


#include <bits/stdc++.h>
using std::cin, std::cout, std::string;

const int MAXN = 1e5+1;
int v[MAXN], dis[MAXN], lc[MAXN], rc[MAXN];

int fa[MAXN];

// 合并两个小根堆
int merge(int x, int y) {
    if (!x || !y) return x+y;
    if (v[x] == v[y] ? x > y : v[x] > v[y]) std::swap(x, y); // 维护堆的性质
    rc[x] = merge(rc[x], y);

    if (dis[lc[x]] < dis[rc[x]]) std::swap(lc[x], rc[x]);  // 维护左偏性
    dis[x] = dis[rc[x]] + 1;  // 更新dis
    return x;
}

// 权重改变后调整堆
int weak(int x) {
    v[x] >>= 1;
    int rt = merge(lc[x], rc[x]);
    lc[x] = rc[x] = dis[x] = 0;
    return fa[x] = fa[rt] = merge(rt, x);
}

int find(int x) { return x == fa[x] ? x : fa[x] = find(fa[x]); }

void solve() {
    dis[0] = -1; // 空节点默认为 -1
    int n, m;
    cin >> n >> m;
    for (int i = 1; i <= n; i++) cin >> v[i], fa[i] = i;

    int op, x, y;
    while (m--) {
        cin >> op;
        if (op == 1) {
            cin >> x >> y;
            if (v[x] == -1 || v[y] == -1) continue ;
            int fx = find(x), fy = find(y);
            if (fx != fy) fa[fx] = fa[fy] = merge(fx, fy); // 代表节点为新根
            
        } else {
            cin >> x;
            if (v[x] == -1) {
                cout << "-1\n";
                continue;
            }
            x = find(x); // 堆中最小值
            cout << v[x] << "\n";
            v[x] = -1;
            fa[x] = fa[lc[x]] = fa[rc[x]] = merge(lc[x], rc[x]);
        }
        
    }
    
}

int main() {
    std::ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);

    solve();
    return 0;
}
