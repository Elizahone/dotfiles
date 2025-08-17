/*
  https://leetcode.cn/problems/find-the-index-of-the-first-occurrence-in-a-string/description/
 */

#include <bits/stdc++.h>
using namespace std;

vector<int> getNext(string &s) {
    int n = s.size();
    if (n == 1)
        return {-1};
    vector<int> next(n + 1);
    next[0] = -1, next[1] = 0;
    int len = next[1];
    for (int i = 2; i <= n; i++) {
        while (len >= 0 && s[i - 1] != s[len]) {
            len = next[len];
        }
        next[i] = ++len;
    }
    return next;
}

int KMP(string &s1, string &s2) {
    vector<int> next = getNext(s2);
    int n = s1.size(), m = s2.size(), x = 0, y = 0;

    while (x < n && y < m) {
        if (s1[x] == s2[y]) {
            x++, y++;
        } else if (y == 0) {
            x++;
        } else {
            y = next[y];
        }
    }
    return y == m ? (x - m) : -1;
}
