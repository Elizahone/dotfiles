/*
  AC 自动机模板
  https://www.luogu.com.cn/problem/P5357
 */
#include <bits/stdc++.h>
using namespace std;
// 目标字符串的数量
const int MAXN = 200001;

// 待查找字符的数量
const int MAXS = 200001;

// 目标字符串结尾字符的节点编号
int ends[MAXN];

// AC 自动机所需结构
int Trie[MAXS][26];
int fail[MAXS];
int cnt = 0;

// 辅助结构 队列
int box[MAXS];

// 具体题目所设数据结构
int times[MAXS];
bool alter[MAXS];

vector<int> g[MAXS];

// 向AC自动机中加入目标字符串（构建前缀树）
void insert(int i, std::string &s) {
    int cur = 0;
    for (int i = 0; i < s.size(); i++) {
        if (Trie[cur][s[i] - 'a'] == 0) {
            Trie[cur][s[i] - 'a'] = ++cnt;
        }
        cur = Trie[cur][s[i] - 'a'];
    }
    ::ends[i] = cur; // 该字符串以 cur 节点结尾
    // 不一定需要
    alter[cur] = true;
}

void setFailPtr() {
    int l = 0, r = 0;
    // 将 0 节点下的所有子节点加入队列，这些节点fail指针天然就得是 0
    for (int i = 0; i < 26; i++) {
        if (Trie[0][i] > 0) {
            box[r++] = Trie[0][i];
        }
    }

    while (l < r) {
        int u = box[l++];
        for (int i = 0; i < 26; i++) {
            if (Trie[u][i] == 0) {
                Trie[u][i] = Trie[fail[u]][i];
            } else {
                fail[Trie[u][i]] = Trie
            [fail[u]]
            [i]; // 如果这条路存在那么子节点的fail指针就时父节点的fail指针所指向的节点的
                // i号路，并且这条路一定已经是直达的，因此这个一定在该更上层
                box[r++] = Trie[u][i];
            }
        }
        // 不一定需要
        alter[u] |= alter[fail[u]];
    }
}

// 收集词频
void f1(int u) {
    for (auto ne : g[u]) {
        f1(ne);
        times[u] += times[ne];
    }
}

void solve() {
    int n;
    cin >> n;
    string s;
    for (int i = 0; i < n; i++) {
        cin >> s;
        insert(i, s);
    }
    cin >> s;
    setFailPtr();

    for (int i = 0, u = 0; i < s.size(); i++) {
        u = Trie[u][s[i] - 'a'];
        times[u]++;
    }

    // TODO 使用链式前向星建图
    for (int i = 1; i <= cnt; i++) {
        g[fail[i]].push_back(i);
    }
    f1(0);
    for (int i = 0; i < n; i++) {
        cout << times[::ends[i]] << "\n";
    }
}

int main() {
    ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);

    solve();
    return 0;
}
