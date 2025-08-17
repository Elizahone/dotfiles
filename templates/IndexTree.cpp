/*
  树状数组
 */

#include <iostream>
#include <vector>
using namespace std;
class IndexTree {
    // sum di
    vector<long long> info1;
    // sum (i-1) * di;
    vector<long long> info2;
    int n;

public:
    // 数据范围
    IndexTree(int n) : info1(n + 3), info2(n+3), n(n) {};

    // 
    void add(vector<long long>& tree, int i, long long v) {
        while (i <= n) {
            tree[i] += v;
            i += i & -i;
        }
    }
    // 范围增加
    void add(int l, int r, long long v) {
        add(info1, l, v);
        add(info1, r + 1, -v);
        add(info2, l, (l-1) * v);
        add(info2, r+1, -(r * v));
    }
    // 返回 [1，r] 的累加和
    long long sum(vector<long long>& tree, int r) {
        long long ans = 0;
        while (r > 0) {
            ans += tree[r];
            r -= r & -r;
        }
        return ans;
    }

    long long query(int l, int r) {
        return r * sum(info1, r) - (l-1) * sum(info1, l-1) - sum(info2, r) + sum(info2, l-1);
    }
};

int main() {
    ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);
    int n, m; long long x;
    cin >> n >> m;
    IndexTree tree(n);
    for (int i = 1; i <= n; i++) {
        cin >> x;
        tree.add(i, i, x);
    }
    long long  a, b, c;
    for (int i = 0; i < m; i++) {
        cin >> x;
        if (x == 1) {
            cin >> a >> b >> c;
            tree.add(a, b, c);
        } else {
            cin >> a >> b;
            cout << tree.query(a, b) << "\n";
        }
    }
    return 0;
}
