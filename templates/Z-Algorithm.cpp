/*
 * Z 从某以字符开始的字符串和整体字符串的最大前缀匹配长度 O(n)
 * E
 * https://www.luogu.com.cn/problem/P5410
 */

#include <bits/stdc++.h>
using namespace std;

vector<int> zArray(string &s) {
    int n = s.size();
    vector<int> z(n);
    z[0] = n;
    for (int i = 1, r = 1, c = 1, len; i < n; i++) {
        len = r > i ? min(z[i - c], r - i) : 0;
        while (i + len < n && s[i + len] == s[len]) {
            len++;
        }
        if (i + len > r) {
            r = i + len;
            c = i;
        }
        z[i] = len;
    }
    return z;
}

vector<int> eArray(string &a, string &b, vector<int> &z) {
    int n = a.size(), m = b.size();
    vector<int> e(n);
    for (int i = 0, r = 0, c = 0, len; i < n; i++) {
        len = r > i ? min(z[i - c], r - i) : 0;
        while (i + len < n && len < m && a[i + len] == b[len]) {
            len++;
        }
        if (i + len > r) {
            r = i + len;
            c = i;
        }
        e[i] = len;
    }
    return e;
}

int main() {
    string a, b;
    cin >> a >> b;
    auto z = zArray(b);
    auto e = eArray(a, b, z);
    long long ans = 0;
    for (int i = 0; i < z.size(); i++)
        ans ^= 1LL * (i + 1) * (z[i] + 1);
    cout << ans << "\n";
    ans = 0;
    for (int i = 0; i < e.size(); i++)
        ans ^= 1LL * (i + 1) * (e[i] + 1);
    cout << ans << "\n";
    return 0;
}
