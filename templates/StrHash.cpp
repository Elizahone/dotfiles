#include <bits/stdc++.h>
using namespace std;

const int MAXN = 1e5 + 7;
const int BASE = 499;
long long pow[MAXN];
long long hash[MAXN];

void init(string &s) {
    int n = s.size();
    pow[0] = 1;
    for (int i = 1; i < MAXN; i++) {
        pow[i] = pow[i - 1] * BASE;
    }
    // hash list
    hash[0] = s[0] - 'a' + 1;
    for (int i = 1; i < n; i++) {
        hash[i] = hash[i - 1] * base + s[i] - 'a' + 1;
    }
    // if you wanna get [l, r]'s hashvalue, just return hash[r] - hash[l-1] *
    // base^(r - l + 1)
}

long long getHash(int l, int r) {
    long long ans = hash[r];
    if (l > 0) {
        ans -= hash[l - 1] * pow[r - l + 1];
    }
    return ans;
}
