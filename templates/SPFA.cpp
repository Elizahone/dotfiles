/*
  Bellman-Ford + SPFA 单源最短路径，用 SPFA 优化常数时间，并且可以判断有无负环（松弛次数 >= n）
*/

#include <bits/stdc++.h>
using std::cin, std::cout, std::string;

const int MAXN = 2e3+1;
const int MAXM = 3e3+1;
int n, m;
int head[MAXN];
int next[MAXM << 1];
int to[MAXM << 1];
int weight[MAXM << 1];
int Updatecnt[MAXN];
int dis[MAXN];
int cnt = 1;

bool enter[MAXN];

void addEdge(int u, int v, int w) {
    next[cnt] = head[u];
    head[u] = cnt;
    to[cnt] = v;
    weight[cnt] = w;
    cnt++;
}

void solve() {
    cin >> n >> m;
    cnt=1;
    std::fill(head, head+n+1, 0);
    std::fill(Updatecnt, Updatecnt+n+1, 0);
    std::fill(enter, enter+n+1, 0);
    std::fill(dis, dis+n+1, INT_MAX);
    int u, v, w;
    for (int i = 1; i <= m; i++) {
        cin >> u >> v >> w;
        addEdge(u, v, w);
        if (w >= 0) addEdge(v, u, w);
    }
    std::queue<int> q;
    Updatecnt[1]++;
    q.push(1);
    dis[1] = 0;
    enter[1] = true;
    while (!q.empty()) {
        int u = q.front(); q.pop();
        enter[u] = false;
        for (int ei = head[u]; ei; ei = next[ei]) {
            int v = to[ei];
            int w = weight[ei];
            if (dis[u] + w < dis[v]) {
                dis[v] = dis[u] + w;
                if (!enter[v]) {
                    if (++Updatecnt[v] >= n) {
                        cout << "YES\n";
                        return;
                    }
                    enter[v] = true;
                    q.push(v);
                }
            }
        }
    }
    cout << "NO\n";
}

int main() {
    std::ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);
    int t;
    cin >> t;
    while (t--)solve();
    return 0;
}

