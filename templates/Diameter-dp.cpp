/*
 * 树的直径：树型DP求
 * 优点：只需要一次遍历，可处理负边权
 * 缺点：只能得到直径的长度
 * 算法：维护每个节点以该节点为头节点，向下能走的最大边权和 dis[]
 *      维护每个节点必须以经过该节点的最大边权值 max_w[], 或 max_w
 *      max_w[u] = max(max_w[u], dis[u] + dis[v] + weight[u->v]) -: 维护左，枚举右
 *      dis[u] = max(dis[u], dis[v] + weight[u->v])
 * https://www.luogu.com.cn/problem/U81904
*/

#include <bits/stdc++.h>
using std::cin, std::cout, std::string;

const int MAXN = 5e5+1;
int n;

int head[MAXN], next[MAXN << 1], to[MAXN << 1], weight[MAXN << 1], cnt=1;
void add(int u, int v, int w) { next[cnt] = head[u], to[cnt] = v, weight[cnt] = w, head[u] = cnt++; }

int dis[MAXN], max_w[MAXN];

int diameter;

void get_diameter1(int u, int fa) {
    for (int e = head[u], v; e ; e = next[e]) { 
        v = to[e];
        if (v != fa) {
            get_diameter1(v, u);
        }
    }
    for (int e = head[u], v; e; e = next[e]) {
        v = to[e];
        if (v != fa) {
            max_w[u] = std::max(max_w[u], dis[u] + dis[v] + weight[e]);
            dis[u] = std::max(dis[u], dis[v] + weight[e]);
        }
    }
}

void get_diameter2(int u, int fa) {
    for (int e = head[u], v; e ; e = next[e]) { 
        v = to[e];
        if (v != fa) {
            get_diameter2(v, u);
        }
    }
    for (int e = head[u], v; e; e = next[e]) {
        v = to[e];
        if (v != fa) {
            diameter = std::max(diameter, dis[u] + dis[v] + weight[e]);
            dis[u] = std::max(dis[u], dis[v] + weight[e]);
        }
    }
}

void solve() {
    cin >> n;
    int u, v, w;
    for (int i = 1; i < n; i++) {
        cin >> u >> v >> w;
        add(u, v, w), add(v, u, w);
    }
    get_diameter2(1, 0);
    // for (int i = 1; i <= n; i++) {
    //     diameter = std::max(diameter, max_w[i]);
    // }
    cout << diameter << "\n";
}

int main() {
    std::ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);

    solve();
    return 0;
}
