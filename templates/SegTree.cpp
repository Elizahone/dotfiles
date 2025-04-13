#include <bits/stdc++.h>
using namespace std;

const int MAXN = 1e5+2;

long long a[MAXN];


long long tree[MAXN << 2];
long long tag[MAXN << 2];

int n, m;

void collect(int p) {
    tree[p] = tree[p << 1] + tree[p << 1 | 1];
}

void lazy(int p, long long v, int len) {
    tree[p] += v * len;
    tag[p] += v;
}

void send(int p, int ln, int rn) {
    if (tag[p] != 0) {
        lazy(p << 1, tag[p], ln);
        lazy(p << 1 | 1, tag[p], rn);
        tag[p] = 0;
    }
}

void build(int i, int l, int r) {
    if (l == r) {
        tree[i] = a[l];
        return;
    }
    int mid = l + (r - l) / 2;
    build(i << 1, l, mid);
    build(i << 1 | 1, mid + 1, r);
    collect(i);
}

long long query(int i, int l, int r, const int jobl, const int jobr) {
    if (l > jobr || r < jobl) {
        return 0;
    }
    if (jobl <= l && jobr >= r) {
        return tree[i];
    }
    long long ans = 0;
    int mid = l + (r - l) / 2;
    send(i, mid - l + 1, r - mid);
    // if (jobl <= mid) {
    //     ans += query(i << 1, l, mid, jobl, jobr);
    // }
    // if (jobr > mid) {
    //     ans += query(i << 1 | 1, mid + 1, r, jobl, jobr);
    // }
    return query(i << 1, l, mid, jobl, jobr) +  query(i << 1 | 1, mid + 1, r, jobl, jobr);
}


void modify(int i, int l, int r, long long v, int jobl, int jobr) {
    if (jobl <= l && r <= jobr) {
        lazy(i, v, r - l + 1);
        return ;
    }
    int mid = l + (r - l) / 2;
    send(i, mid - l + 1, r - mid);
    if (jobl <= mid) {
        modify(i << 1, l, mid, v, jobl, jobr);
    }
    if (jobr > mid) {
        modify(i << 1|1, mid+1, r, v, jobl, jobr);
    }
    collect(i);
}

long long range_query(int l, int r) {
    return query(1, 1, n, l, r);
}

void modify(int l, int r, long long v) {
    modify(1, 1, n, v, l, r);
}

void solve() {
    cin >> n >> m;
    for (int i = 1; i <= n; i++) cin >> a[i];
    build(1, 1, n);
    int op, x, y; long long k;
    while (m--) {
        cin >> op;
        if (op == 1) {
            cin >> x >> y >> k;
            modify(1, 1, n, k ,x, y);
        } else {
            cin >> x >> y;
            cout << range_query(x, y) << "\n";
        }
    }
}

int main() {
    ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);

    solve();
    return 0;
}
