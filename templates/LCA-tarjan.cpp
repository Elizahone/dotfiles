/*
  LCA Tarjan 使用并查集维护,将所有的查询也建成一张图
*/


#include <bits/stdc++.h>
using std::cin, std::cout, std::string;

const int MAXN = 5e5+1;
// 树的链式前向星
int ghead[MAXN], gnext[MAXN << 1], gto[MAXN<<1];
bool vis[MAXN];

// 询问的链式前向星
int qhead[MAXN], qnext[MAXN << 1], qto[MAXN<<1], qind[MAXN << 1];
int gcnt = 1, qcnt = 1;


// 并查集
int fa[MAXN];
int ans[MAXN];
// 递归版
// int find(int x) { return x == fa[x] ? x : fa[x] = find(fa[x]); }

int stack[MAXN];
// 非递归版
int find(int x) {
    int stsize = 0;
    while (x != fa[x]) {
        stack[stsize++] = x;
        x = fa[x];
    }
    while (stsize > 0) {
        fa[stack[--stsize]] = x;
    }
    return x;
}

int n, m, s;
void gadd(int u, int v) {
    gnext[gcnt] = ghead[u];
    gto[gcnt] = v;
    ghead[u] = gcnt++;
}

void qadd(int u, int v, int ind) {
    qnext[qcnt] = qhead[u];
    qto[qcnt] = v;
    qind[qcnt] = ind;
    qhead[u] = qcnt++;
}


// 递归版
void tarjan(int i, int fa) {
    vis[i] = true;
    for (int ei = ghead[i]; ei; ei = gnext[ei]) {
        if (gto[ei] != fa) {
            tarjan(gto[ei], i);
        }
    }
    // 处理节点对应的询问
    for (int ei = qhead[i]; ei; ei = qnext[ei]) {
        if (vis[qto[ei]]) {
            ans[qind[ei]] = find(qto[ei]);
        }
    }
    ::fa[i] = fa;
}

int ufe[MAXN][3];
int usize = 0;
int u, e, f;

void pop() {
    --usize;
    u = ufe[usize][0];
    f = ufe[usize][1];
    e = ufe[usize][2];
}

void push(int u, int f, int e) {
    ufe[usize][0] = u;
    ufe[usize][1] = f;
    ufe[usize][2] = e;
    usize++;
}

void tarjan(int i) {
    usize = 0;
    // 栈里存放三个信息
    // u : 当前处理的点
    // f : 当前点u的父节点
    // e : 处理到几号边了
    // 如果e==-1，表示之前没有处理过u的任何边
    // 如果e==0，表示u的边都已经处理完了
    push(i, 0, -1);
    while (usize > 0) {
        pop();
        if (e == -1) {  // 对应 int ei = ghead[u];
            vis[u] = true;
            e = ghead[u];
        } else {
            e = gnext[e]; // 对应 ei = gnext[ei];
        }
        if (e != 0) {  // 对应 ei != 0
            push(u, f, e);
            if (gto[e] != f) {
                push(gto[e], u, -1); // 对应 tarjan(ei, u);
            }
        } else {  // 对应 递归结束后的操作
            for (int ei = qhead[u]; ei; ei = qnext[ei]) {
                if (vis[qto[ei]]) {
                    ans[qind[ei]] = find(qto[ei]);
                }
            }
            fa[u] = f;
        }
    }
}

void solve() {
    cin >> n >> m >> s; int u, v;
    for (int i = 1; i <n; i++) {
        cin >> u >> v;
        gadd(u, v), gadd(v, u);
    }
    for (int i = 1; i <= n; i++) fa[i] = i;


    for (int i = 1; i <= m; i++) {
        cin >> u >> v;
        qadd(u, v, i), qadd(v, u, i);
    }

    tarjan(s);
    for (int i = 1; i <= m; i++) {
        cout << ans[i] << "\n";
    }
}

int main() {
    std::ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);
    
    solve();
    return 0;
}
