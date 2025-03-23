/*
 * Manacher 算法，最微不足道的用法是用于解决最长回文子序列
 */

#include <bits/stdc++.h>
const int MAXS = 11000007;
int n;
char ss[MAXS << 1];
int p[MAXS << 1];

void manacherss(std::string &s) {
    for (int i = 0, j = 0; i < 2 * n + 1; i++) {
        ss[i] = i & 1 ? s[j++] : '#';
    }
}

int manacher() {
    int mx = 0;
    for (int i = 0, r = 0, c = 0, len; i < 2 * n + 1; i++) {
        len = r > i ? std::min(p[2 * c - i], r - i) : 1;
        while (i + len < 2 * n + 1 && i - len >= 0 && ss[i - len] == ss[i + len]) {
            len++;
        }
        if (i + len > r) {
            r = i + len;
            c = i;
        }
        mx = std::max(mx, len);
        p[i] = len;
    }
    return mx - 1;
}

int main() {
    std::string s;
    std::cin >> s;
    n = s.size();
    manacherss(s);
    std::cout << manacher() << "\n";
}
