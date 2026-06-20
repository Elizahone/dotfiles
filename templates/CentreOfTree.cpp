#include <iostream>
#include <cstring>
#include <algorithm>
using std::cin;
using std::cout;
const int MAXN = 5e4+1;
int size[MAXN]; // 以 i 为跟节点的向下子树的节点个数
int weight[MAXN]; // 以 i 为 根的所有子树的最大值
int cnt = 1;

int head[MAXN];
int to[MAXN << 1];
int next[MAXN<<1];

void add(int u, int v) {
    next[cnt] = head[u];
    to[cnt] = v;
    head[u] = cnt++;
}
int n;
int ans[2];
int m=0;

void dfs(int u, int fa) {
    size[u] = 1;
    weight[u] = 0;
    for (int ei = head[u], v; ei!=0; ei = next[ei]) {
        v = to[ei];
        if (v != fa) {
            dfs(v, u);
            size[u] += size[v];
            weight[u] = std::max(weight[u], size[v]);
        }
    }
    weight[u] = std::max(weight[u], n - size[u]);
    if (weight[u] <= n/2) {
        ans[m++] = u;
    }
}


void solve() {
    cin >> n; int u, v;
    cnt = 1;
    memset(head, 0, sizeof(head));
    for (int i = 1; i < n; i++) {
        cin >> u >> v;
        add(u, v), add(v, u);
    }
    dfs(1, 0);
    if (m == 1) {
        cout << ans[0] << "\n";
    } else {
        cout << ans[0] << " " << ans[1] << "\n";
    }
}

int main() {
    std::ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);
    solve();
    return 0;
}
