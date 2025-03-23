/*
  AC 自动机模板 with alter
  https://www.luogu.com.cn/problem/P3311
 */
#include <bits/stdc++.h>
using namespace std;
// 目标字符串的数量
const int MAXN = 1300;

// 待查找字符的数量
const int MAXS = 3005;

// AC 自动机所需结构
int Trie[MAXS][10];
int fail[MAXS];
int cnt = 0;

// 辅助结构 队列
int box[MAXS];

bool alter[MAXS];

vector<int> g[MAXS];

// 向AC自动机中加入目标字符串（构建前缀树）
void insert(std::string &s) {
    int cur = 0;
    for (int i = 0; i < s.size(); i++) {
        if (Trie[cur][s[i] - '0'] == 0) {
            Trie[cur][s[i] - '0'] = ++cnt;
        }
        cur = Trie[cur][s[i] - '0'];
    }
    // 不一定需要
    alter[cur] = true;
}

void setFailPtr() {
    int l = 0, r = 0;
    // 将 0 节点下的所有子节点加入队列，这些节点fail指针天然就得是 0
    for (int i = 0; i < 10; i++) {
        if (Trie[0][i] > 0) {
            box[r++] = Trie[0][i];
        }
    }

    while (l < r) {
        int u = box[l++];
        for (int i = 0; i < 10; i++) {
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

string num;
int n;
const int MOD = 1e9 + 7;

int memo[1301][3002][2][2];

int f(int i, int j, int free, int has) {
    if (alter[j])
        return 0;
    if (i == n)
        return has;
    if (memo[i][j][free][has] != -1)
        return memo[i][j][free][has];
    int ans = 0;
    int cur = num[i] - '0';
    if (has == 0) {
        if (free == 0) {
            ans = (ans + f(i + 1, 0, 1, 0)) % MOD;
            for (int pick = 1; pick < cur; pick++) {
                ans = (ans + f(i + 1, Trie[j][pick], 1, 1)) % MOD;
            }
            ans = (ans + f(i + 1, Trie[j][cur], 0, 1)) % MOD;
        } else {
            ans = (ans + f(i + 1, 0, 1, 0)) % MOD;
            for (int pick = 1; pick < 10; pick++) {
                ans = (ans + f(i + 1, Trie[j][pick], 1, 1)) % MOD;
            }
        }
    } else {
        if (free == 0) {
            for (int pick = 0; pick < cur; pick++) {
                ans = (ans + f(i + 1, Trie[j][pick], 1, 1)) % MOD;
            }
            ans = (ans + f(i + 1, Trie[j][cur], 0, 1)) % MOD;
        } else {
            for (int pick = 0; pick < 10; pick++) {
                ans = (ans + f(i + 1, Trie[j][pick], 1, 1)) % MOD;
            }
        }
    }
    return memo[i][j][free][has] = ans;
}

void solve() {
    cin >> num;
    n = num.size();
    string s;
    int m;
    cin >> m;
    for (int i = 0; i < m; i++) {
        cin >> s;
        insert(s);
    }
    for (int i = 0; i < 1301; i++)
        for (int j = 0; j < 3002; j++)
            memo[i][j][0][0] = -1, memo[i][j][0][1] = -1, memo[i][j][1][0] = -1,
                                                          memo[i][j][1][1] = -1;

    setFailPtr();

    cout << f(0, 0, 0, 0) << "\n";
}

int main() {
    ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);

    solve();
    return 0;
}
