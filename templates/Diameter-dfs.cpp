/*
 * 树的直径：两次dfs求法
 * 优点：两次遍历后可以得到直径长度、路径, 端点到其他节点的长度
 * 缺点：需要两次遍历，不能处理负边
 * https://www.luogu.com.cn/problem/U81904
*/

#include <bits/stdc++.h>
using std::cin, std::cout, std::string;

const int MAXN = 5e5+1;
int n;

int head[MAXN], next[MAXN << 1], to[MAXN << 1], weight[MAXN << 1], cnt=1;
void add(int u, int v, int w) { next[cnt] = head[u], to[cnt] = v, weight[cnt] = w, head[u] = cnt++; }

int diameter, start, end, dis[MAXN], prev[MAXN];

void dfs(int u, int fa) {
    for (int e = head[u], v; e; e = next[e]) {
        v = to[e];
        if (v != fa) {
            dis[v] = dis[u] + weight[e];
            prev[v] = u;
            dfs(v, u);  
        }
    }
}

void get_diameter() {
    start = 1;
    dis[1] = 0;
    dfs(1, 0);
    for (int i = 1; i <= n; i++) {
        if (dis[start] < dis[i]) start = i;
    }
    dis[start] = 0;
    dfs(start, 0);
    end = 1;
    for (int i = 1; i <= n; i++) {
        if (dis[end] < dis[i]) end = i;
    }
    diameter = dis[end];
}

void solve() {
    cin >> n;
    int u, v, w;
    for (int i = 1; i < n; i++) {
        cin >> u >> v >> w;
        add(u, v, w), add(v, u, w);
    }
    get_diameter();
    cout << diameter << "\n";
}

int main() {
    std::ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);

    solve();
    return 0;
}
