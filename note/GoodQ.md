
#### 问题陈述

给你整数 $N, M$ 和长度为 $M$ 的三个整数序列： $X = (X_1, X_2, \ldots, X_M)$ 、 $Y = (Y _1, Y_2, \ldots, Y_M)$ 和 $Z = (Z_1, Z_2, \ldots, Z_M)$ 。保证 $X$ 和 $Y$ 中的所有元素都在 $1$ 和 $N$ 之间。

当且仅当长度为 $N$ 的非负整数序列 $A = (A_1, A_2, \ldots, A_N)$ 满足以下条件时，我们称它为**好序列**：

- 对于 $i$ 与 $1 \le i \le M$ 的每一个整数， $A_{X_i}$ 与 $A_{Y_i}$ 的 XOR 为 $Z_i$ 。

判断是否存在一个好序列 $A=(A_1,A_2,\ldots,A_N)$ ，如果存在，找出一个使其元素之和 $\displaystyle \sum_{i=1}^N A_i$ 最小的好序列。

关于 XOR 的说明 对于非负整数 $A$ 和 $B$ ，它们的 XOR $A \oplus B$ 定义如下：

- 在 $A \oplus B$ 的二进制表示中，当且仅当 $A$ 和 $B$ 的相同数位中恰好有一位是 $1$ 时， $2^k \\,(k \ge 0)$ 对应数位上的数字是 $1$ ；否则，它是 $0$ 。

例如， $3 \oplus 5 = 6$ (二进制： $011 \oplus 101 = 110$ )。


#  LeetCode 周赛


## 问题陈述

> 这个问题是问题 C 的一个更难的版本。在这里，序列被分成三个子数组。


给你一个长度为 $N$ 的整数序列： $A = (A_1, A_2, \ldots, A_N)$ .

当将两个位置上的 $A$ 分割成三个非空（连续）子数组时，求这些子数组中不同整数的最大可能计数之和。

更正式地说，求一对整数 $(i,j)$ 的以下三个值的最大和： $1 \leq i \lt j \leq N-1$ 中的不同整数计数， $(A_{i+1},A_{i+2},\ldots,A_j)$ 中的不同整数计数， $(A_{j+1},A_{j+2},\ldots,A_{N})$ 中的不同整数计数。
### Constraints

-   $3 \leq N \leq 3 \times 10^5$
-   $1 \leq A_i \leq N$ ($1 \leq i \leq N$)
-   All input values are integers.


# P1908 逆序对

## 题目描述

猫猫 TOM 和小老鼠 JERRY 最近又较量上了，但是毕竟都是成年人，他们已经不喜欢再玩那种你追我赶的游戏，现在他们喜欢玩统计。

最近，TOM 老猫查阅到一个人类称之为“逆序对”的东西，这东西是这样定义的：对于给定的一段正整数序列，逆序对就是序列中 $a_i>a_j$ 且 $i<j$ 的有序对。知道这概念后，他们就比赛谁先算出给定的一段正整数序列中逆序对的数目。注意序列中可能有重复数字。

**Update：数据已加强。**
## 输入格式

第一行，一个数 $n$，表示序列中有 $n$ 个数。

第二行 $n$ 个数，表示给定的序列。序列中每个数字不超过 $10^9$。

## 输出格式

输出序列中逆序对的数目。

**归并分治解法** 

```C++ title:归并分治代码  fold
#include <bits/stdc++.h>
using namespace std;

int help[500005];

long long merge(vector<int>& arr, int l, int m, int r) {
	long long ans = 0;
	for (int i = m, j = r; i >= l; i--) {
		while (j > m && arr[i] <= arr[j]) {
			j--;
		}
		ans += j - m;
	}
	int i = l, a = l, b = m+1;
	while (a <= m && b <= r) {
		help[i++] = arr[a] < arr[b] ? arr[a++] : arr[b++];
	}
	while (a <= m) {
		help[i++] = arr[a++];
	}
	while (b <= r) {
		help[i++] = arr[b++];
	}
	for (int i = l; i <= r; i++) {
		arr[i] = help[i];
	}
}

long long f(vector<int>& arr, int l, int r) {
	if (l == r) {
		return 0;
	}
	int mid = (r - l) / 2 + l;
	return f(arr, l, m) + f(arr, m+1, r) + merge(arr, l, m, r);
}

int main() {
	
	return 0;
}
```

**树状数组解法**

https://www.luogu.com.cn/problem/P1908

首先，逆序对就是每遍历到一个数，看看在他后面的数中有几个比他大，因此可以从右往左遍历，统计 $[1, x-1]$ 词频的词频，每次遍历到新的数字需要单点修改，与范围查询前缀和，因此选择树状数组，注意到数据范围过大，如果不做处理将会达到 $10^9$ 的量级。可以确定的是，我们不需要具体数字大小，只需要相对大小，因此可以离散化处理。
具体处理如下，**将原始数据从小到大排序，它的下标就为新值，再将该值刷回数组中，这样将值域从 $10^9$ 减小到了和数组大小一致的量级，且保证了数据的相对大小**


>处理原始数据，保证新值不小于 1
```C++
void init() {
    sort(arr+1, arr+n+1);
    len = 1;
    for (int i = 2; i <= n; i++) {
        if (arr[len] != arr[i]) arr[++len] = arr[i];
    }
    for (int i = 1; i <= n; i++) {
        sorted[i] = lower_bound(arr+1, arr+1+len, sorted[i]) - arr;
    }
}
```

##### 总代码

```c++ fold
#include <bits/stdc++.h>
using namespace std;

const int MAXN = 5e5+7;
int n;
int arr[MAXN];
int sorted[MAXN];
int tree[MAXN];
int len;
void init() {
    sort(arr+1, arr+n+1);
    len = 1;
    for (int i = 2; i <= n; i++) {
        if (arr[len] != arr[i]) arr[++len] = arr[i];
    }
    for (int i = 1; i <= n; i++) {
        sorted[i] = lower_bound(arr+1, arr+1+len, sorted[i]) - arr;
    }
}

void add(int i, int v) {
    while (i <= n) {
        tree[i] += v;
        i += i & (-i);
    }
}

long long sum(int i) {
    long long ans = 0;
    while (i > 0) {
        ans += tree[i];
        i -= i & (-i);
    }
    return ans;
}

int main() {
    ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);
    cin >> n;
    for (int i = 1; i <= n; i++) {
        cin >> arr[i];
        sorted[i] = arr[i];
    }
    init();
    long long ans = 0;
    for (int i = n; i > 0; i--) {
        int x = sorted[i];
        ans += sum(x-1);
        add(x, 1);
    }
    cout << ans << "\n";
    
    return 0;
}
```


## 线段树

***线段数维护的信息类型：*** 父范围的信息可以用O(1)的时间从子范围上加工出来。


- [平均数和方差](https://www.luogu.com.cn/problem/P1471)
- [无聊的数列](https://www.luogu.com.cn/problem/P1438)
- [贪婪大陆](https://www.luogu.com.cn/problem/P2184)
- [开关](https://www.luogu.com.cn/problem/P3870)

### 线段数维护区间合并
经典模型：**维护区间最长连续 1 的个数**
- [序列操作](https://www.luogu.com.cn/problem/P2572)
#### code
```C++ title:线段数区间合并 fold
#include <bits/stdc++.h>
using namespace std;

const int MAXN = 1e5+1;
int n, m;

int arr[MAXN];
int sum[MAXN << 2];
int change[MAXN << 2];
bool update[MAXN << 2];
bool rev[MAXN << 2];
int len1[MAXN << 2];
int pre1[MAXN << 2];
int suf1[MAXN << 2];
int len0[MAXN << 2];
int pre0[MAXN << 2];
int suf0[MAXN << 2];

void collect(int p, int ln, int rn) {
    int l = p << 1, r = p << 1|1;
    sum[p] = sum[l] + sum[r];
    len1[p] = max(max(len1[l], len1[r]), suf1[l] + pre1[r]);
    pre1[p] = len1[l] < ln ? pre1[l] : pre1[l] + pre1[r];
    suf1[p] = len1[r] < rn ? suf1[r] : suf1[l] + suf1[r];
    
    len0[p] = max(max(len0[l], len0[r]), suf0[l] + pre0[r]);
    pre0[p] = len0[l] < ln ? pre0[l] : pre0[l] + pre0[r];
    suf0[p] = len0[r] < rn ? suf0[r] : suf0[l] + suf0[r];
}

void updateLazy(int p, int v, int len) {
    sum[p] = len * v;
    len1[p] = pre1[p] = suf1[p] = (v == 1 ? len : 0);
    len0[p] = pre0[p] = suf0[p] = (v == 0 ? len : 0);
    change[p] = v;
    update[p] = true;
    rev[p] = false;
}

void reverseLazy(int p, int len) {
    sum[p] = len - sum[p];
    swap(len1[p], len0[p]);
    swap(suf1[p], suf0[p]);
    swap(pre1[p], pre0[p]);
    rev[p] = !rev[p];
}

void send(int p, int ln, int rn) {
    if (update[p]) {
        updateLazy(p<<1, change[p], ln);
        updateLazy(p << 1|1, change[p], rn);
        update[p] = false;
    }
    if (rev[p]) {
        reverseLazy(p << 1, ln);
        reverseLazy(p << 1|1, rn);
        rev[p] = false;
    }
}

void build(int i, int l, int r) {
    if (l == r) {
        sum[i] = arr[l];
        len0[i] = pre0[i] = suf0[i] = arr[l] == 0;
        len1[i] = pre1[i] = suf1[i] = arr[l] == 1;
        return ;
    }
    int mid = (l + r) / 2;
    build(i<<1, l, mid);
    build(i << 1|1, mid+1, r);
    collect(i, mid-l+1, r - mid);
}

void update_(int jobl, int jobr, int v, int i=1, int l=1, int r=n) {
    if (jobl <= l && jobr >= r) {
        updateLazy(i, v, r-l+1);
        return ;
    }
    int mid = (l + r) / 2;
    send(i, mid-l+1, r-mid);
    if (jobl <= mid) {
        update_(jobl, jobr, v, i<<1, l, mid);
    }
    if (jobr > mid) {
        update_(jobl, jobr, v, i<<1|1, mid+1, r);
    }
    collect(i, mid-l+1, r - mid);
}

void reverse_(int jobl, int jobr, int i=1, int l=1, int r=n) {
    if (jobl <= l && jobr >= r) {
        reverseLazy(i, r-l+1);
        return ;
    }
    int mid = (l + r)/2;
    send(i, mid-l+1, r-mid);
    if (jobl <= mid) {
        reverse_(jobl, jobr, i<<1, l, mid);
    }
    if (jobr > mid) {
        reverse_(jobl, jobr, i<<1|1, mid+1, r);
    }
    collect(i, mid-l+1, r-mid);
}

int querySum(int jobl, int jobr, int i=1, int l=1, int r=n) {
    if (jobl <= l && jobr >= r) {
        return sum[i];
    }
    int mid = (l + r) / 2;
    send(i, mid-l+1, r-mid);
    int ans = 0;
    if (jobl <= mid) {
        ans += querySum(jobl, jobr, i<<1, l, mid);
    }
    if (jobr > mid) {
        ans += querySum(jobl, jobr, i<<1|1, mid+1, r);
    }
    return ans;
}

vector<int> queryLongest(int jobl, int jobr, int i=1, int l=1, int r=n) {
    if (jobl <= l && jobr >= r) {
        return {len1[i], pre1[i], suf1[i]};
    }
    int mid = (l + r) / 2;
    send(i, mid-l+1, r-mid);
    if (jobr <= mid) {
        return queryLongest(jobl, jobr, i<<1, l, mid);
    }
    if (jobl > mid) {
        return queryLongest(jobl, jobr, i<<1|1, mid+1, r);
    }
    auto l3 = queryLongest(jobl, jobr, i<<1, l, mid);
    auto r3 = queryLongest(jobl, jobr, i<<1|1, mid+1, r);
    int len = max(max(l3[0], r3[0]), l3[2] + r3[1]);
    int pf = l3[0] < mid - max(jobl, l) + 1 ? l3[1] : l3[1] + r3[1];
    int sf = r3[0] < min(jobr, r) - mid ? r3[2] : r3[2] + l3[2];
    return {len, pf, sf};
}

void solve() {
    cin >> n >> m;
    for (int i = 1; i <= n; i++) cin >> arr[i];
    build(1, 1, n);
    int op, l, r;
    while (m--) {
        cin >> op >> l >> r;
        if (op == 0) {
            update_(l, r, 0);
        } else if (op == 1) {
            update_(l, r, 1);
        } else if (op == 2) {
            reverse_(l, r);
        } else if (op == 3) {
            cout << querySum(l, r) << "\n";
        } else {
            cout << queryLongest(l, r)[0] << "\n";
        }
    }
}

int main() {
    ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);

    solve();
    return 0;
}
```

### 动态开点线段树
当数据范围很大，并且需要区间大小的信息，此时可以使用 **动态开点线段树**，使用空间大约为 *操作数量 $\times$ 树高 $\times$ 2* 
增加一个 **left[]** 数组和 **right[]** 数组，存储每个节点的左右孩子
线段树往往可以被其他技巧替代，但是它在线段的的合并中无法被取代。

- [传教](https://www.luogu.com.cn/problem/P2781)
```C++ title:动态开点线段树 fold
#include <bits/stdc++.h>
int n, m;
const int LIMIT = 80001;
long long sum[LIMIT];
long long add[LIMIT];
int left[LIMIT];
int right[LIMIT];
int cnt = 1;
using std::cout, std::cin;

// 没有左孩子时申请节点，并返回下标， rs 函数同理
inline int ls(int p) {
    if (left[p] == 0) {
        left[p] = ++cnt;
    }
    return left[p];
}

inline int rs(int p) {
    if (right[p] == 0) {
        right[p] = ++cnt;
    }
    return right[p];
}

void collect(int i) {
    sum[i] = sum[ls(i)] + sum[rs(i)];
}

void lazy(int i, long long v, int len) {
    sum[i] += v * len;
    add[i] += v;
}

void send(int i, int ln, int rn) {
    if (add[i]) {
        lazy(ls(i), add[i], ln);
        lazy(rs(i), add[i], rn);
        add[i] = 0;
    }
}

void modify(int jobl, int jobr, long long v, int i=1, int l=1, int r=n) {
    if (jobl <= l && jobr >= r) {
        lazy(i, v, r-l+1);
        return ;
    }
    int mid = (l + r) / 2;
    send(i, mid-l+1, r-mid);
    if (jobl <= mid) {
        modify(jobl, jobr, v, ls(i), l, mid);
    }
    if (jobr > mid) {
        modify(jobl, jobr, v, rs(i), mid+1, r);
    }
    collect(i);
}

// query 时并不涉及申请节点操作，因此不调用 ls 和 rs 函数
long long query(int jobl, int jobr, int i=1, int l=1, int r=n) {
    if (jobl <= l && jobr >= r) {
        return sum[i];
    }
    int mid = (l + r) / 2;
    send(i, mid-l+1, r-mid);
    long long ans = 0;
    if (jobl <= mid && left[i]) {
        ans += query(jobl, jobr, left[i], l, mid);
    }
    if (jobr > mid && right[i]) {
        ans += query(jobl, jobr, right[i], mid+1, r);
    }
    return ans;
}

void solve() {
    cin >> n >> m;
    int op, l, r; long long k;
    while (m--) {
        cin >> op;
        if (op == 1) {
            cin >> l >> r >> k;
            modify(l, r, k);
        } else {
            cin >> l >> r;
            cout << query(l, r) << "\n";
        }
    }
}

int main() {
    std::ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);

    solve();
    return 0;
}
```

### 区间最值操作 (吉如一)

**线段树的区间最值操作(hdu测试)**
**给定一个长度为n的数组arr，实现支持以下三种操作的结构**
**操作 0 l r x : 把arr[l..r]范围的每个数v，更新成min(v, x)**
**操作 1 l r   : 查询arr[l..r]范围上的最大值**
**操作 2 l r   : 查询arr[l..r]范围上的累加和**
**三种操作一共调用m次，做到时间复杂度O(n * log n + m * log n)**
测试链接 : https://acm.hdu.edu.cn/showproblem.php?pid=5306

需维护每个区间的**最大值**和**次大值**和**最大值的个数**。

```c++ title:区间最值操作代码 fold
#include <bits/stdc++.h>
using std::cin, std::cout, std::string;

const int MAXN = 1e6+1;
int arr[MAXN];
long long sum[MAXN << 2];
int max[MAXN << 2];
int cnt[MAXN << 2];
// second max;
int sem[MAXN << 2];
int n, m;
const int LOWEST = -1;

int ls(int p) {return p << 1;}
int rs(int p) {return p<<1|1;}

void collect(int p) {
    int l = ls(p), r = rs(p);
    sum[p] = sum[l] + sum[r];
    max[p] = std::max(max[l], max[r]);
    if (max[l] > max[r]) {
        cnt[p] = cnt[l];
        sem[p] = std::max(sem[l], max[r]);
    } else if (max[r] > max[l]) {
        cnt[p] = cnt[r];
        sem[p] = std::max(sem[r], max[l]);
    } else {
        cnt[p] = cnt[l] + cnt[r];
        sem[p] = std::max(sem[l], sem[r]);
    }
}

// only if `sem < v < max`
// 一定是没有颠覆掉次大值的懒更新信息下发，也就是说：
// 最大值被压成v，并且v > 严格次大值的情况下
// sum和max怎么调整  max 就是一个懒更新
void lazy(int p, int v) {
    if (v < max[p]) {
        sum[p] -= ((long long) max[p] - v) * cnt[p];
        max[p] = v;
    }
}

void send(int p) {
    lazy(ls(p), max[p]);
    lazy(rs(p), max[p]);
}

void build(int l, int r, int i) {
    if (l == r) {
        sum[i] = arr[l];
        max[i] = arr[l];
        cnt[i] = 1;
        sem[i] = LOWEST;
    } else {
        int mid = (l + r) / 2;
        build(l, mid, ls(i));
        build(mid+1, r, rs(i));
        collect(i);
    }
}

void setMin(int jobl, int jobr, int v, int i=1, int l=1, int r=n) {
    if (max[i] <= v) {
        return ;
    }
    if (jobl <= l && jobr >= r && v > sem[i]) {
        lazy(i, v);
        return ;
    }
    int mid = (l + r) / 2;
    send(i);
    if (jobl <= mid) {
        setMin(jobl, jobr, v, ls(i), l, mid);
    }
    if (jobr > mid) {
        setMin(jobl, jobr, v, rs(i), mid+1, r);
    }
    collect(i);
}

int queryMax(int jobl, int jobr, int i=1, int l=1, int r=n) {
    if (jobl <= l && jobr >= r) {
        return max[i];
    }
    int mid = (l + r)/2;
    send(i);
    int ans = -10000000;
    if (jobl <= mid) {
        ans = std::max(ans, queryMax(jobl, jobr, ls(i), l, mid));
    }
    if (jobr > mid) {
        ans = std::max(ans, queryMax(jobl, jobr, rs(i), mid+1, r));
    }
    return ans;
}

long long querySum(int jobl, int jobr, int i=1, int l=1, int r=n) {
    if (jobl <= l && jobr >= r) {
        return sum[i];
    }
    int mid = (l + r)/2;
    send(i);
    long long ans = 0;
    if (jobl <= mid) {
        ans += querySum(jobl, jobr, ls(i), l, mid);
    }
    if (jobr > mid) {
        ans += querySum(jobl, jobr, rs(i), mid+1, r);
    }
    return ans;
}


void solve() {
    cin >> n >> m;
    for (int i = 1; i <= n; i++) cin >> arr[i];
    build(1, n, 1);
    int op, x, y, t;
    while (m--) {
        cin >> op >> x >> y;
        if (op == 0) {
            cin >> t;
            setMin(x, y, t);
        } else if (op == 1) {
            cout << queryMax(x, y) << "\n";
        } else {
            cout << querySum(x, y) << "\n";
        }
    }
}

int main() {
    std::ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);
    int t; cin >> t;
    while (t--)solve();
    return 0;
}
```

维护区间最大至和历史最大值，并有区间增加操作
测试链接: https://www.luogu.com.cn/problem/P6242

```c++ title:吉司机先段树 fold
#include <bits/stdc++.h>
#include <climits>
using std::cin, std::cout, std::string;

const int MAXN = 1e6+1;
int arr[MAXN];
long long sum[MAXN << 2];
long long max[MAXN << 2];
int cnt[MAXN << 2];
// second max;
long long sem[MAXN << 2];
long long maxAdd[MAXN << 2];
long long otherAdd[MAXN << 2];

// 历史最大值
long long maxHistory[MAXN << 2];
// 最大值达到过的最大提升幅度
long long maxAddTop[MAXN << 2];
// 除最大值以外的数字，达到过的最大提升幅度
long long otherAddTop[MAXN << 2];

int n, m;
const long long LOWEST = LLONG_MIN;

int ls(int p) {return p << 1;}
int rs(int p) {return p<<1|1;}

void collect(int p) {
    int l = ls(p), r = rs(p);
    // 左 右 的历史最大值
    maxHistory[p] = std::max(maxHistory[ls(p)], maxHistory[rs(p)]);
    sum[p] = sum[l] + sum[r];
    max[p] = std::max(max[l], max[r]);
    if (max[l] > max[r]) {
        cnt[p] = cnt[l];
        sem[p] = std::max(sem[l], max[r]);
    } else if (max[r] > max[l]) {
        cnt[p] = cnt[r];
        sem[p] = std::max(sem[r], max[l]);
    } else {
        cnt[p] = cnt[l] + cnt[r];
        sem[p] = std::max(sem[l], sem[r]);
    }
}

// only if `sem < v < max`
// 一定是没有颠覆掉次大值的懒更新信息下发，也就是说：
// 最大值被压成v，并且v > 严格次大值的情况下
// sum和max怎么调整
void lazy(int p, long long maxAddv, long long otherAddv, long long maxUpv, long long otherUpv, int len) {
    maxHistory[p] = std::max(maxHistory[p], max[p] + maxUpv);
    // 相较于最初时最大的涨幅(净增幅) = 以前的净增幅 + 现在最大值增加的数量
    maxAddTop[p] = std::max(maxAddTop[p], maxAdd[p] + maxUpv);
    otherAddTop[p] = std::max(otherAddTop[p], otherAdd[p] + otherUpv);
    
    sum[p] += maxAddv * cnt[p] + otherAddv * (len - cnt[p]);
    max[p] += maxAddv;
    sem[p] += sem[p] == LOWEST ? 0 : otherAddv;
    maxAdd[p] += maxAddv;
    otherAdd[p] += otherAddv;
}

void send(int p, int ln, int rn) {
    long long tmp = std::max(max[ls(p)], max[rs(p)]);
    if (max[ls(p)] == tmp) {
        lazy(ls(p), maxAdd[p], otherAdd[p], maxAddTop[p], otherAddTop[p],ln);
    } else {
        lazy(ls(p), otherAdd[p], otherAdd[p], otherAddTop[p], otherAddTop[p], ln);
    }
    if (max[rs(p)] == tmp) {
        lazy(rs(p), maxAdd[p], otherAdd[p], maxAddTop[p], otherAddTop[p], rn);
    } else {
        lazy(rs(p), otherAdd[p], otherAdd[p], otherAddTop[p], otherAddTop[p], rn);
    }
    maxAdd[p] = otherAdd[p] = otherAddTop[p] = maxAddTop[p] =  0;
}

void build(int l, int r, int i) {
    if (l == r) {
        sum[i] = max[i] = maxHistory[i] = arr[l];
        cnt[i] = 1;
        sem[i] = LOWEST;
    } else {
        int mid = (l + r) / 2;
        build(l, mid, ls(i));
        build(mid+1, r, rs(i));
        collect(i);
    }
    maxAdd[i] = otherAdd[i] = maxAddTop[i] = otherAddTop[i] = 0;
}

void setMin(int jobl, int jobr, int v, int i=1, int l=1, int r=n) {
    if (max[i] <= v) {
        return ;
    }
    if (jobl <= l && jobr >= r && v > sem[i]) {
        lazy(i, v - max[i], 0, v-max[i], 0, r - l + 1);
        return ;
    }
    int mid = (l + r) / 2;
    send(i, mid-l+1, r-mid);
    if (jobl <= mid) {
        setMin(jobl, jobr, v, ls(i), l, mid);
    }
    if (jobr > mid) {
        setMin(jobl, jobr, v, rs(i), mid+1, r);
    }
    collect(i);
}

long long queryMax(int jobl, int jobr, int i=1, int l=1, int r=n) {
    if (jobl <= l && jobr >= r) {
        return max[i];
    }
    int mid = (l + r)/2;
    send(i, mid-l+1, r-mid);
    long long ans = LLONG_MIN;
    if (jobl <= mid) {
        ans = std::max(ans, queryMax(jobl, jobr, ls(i), l, mid));
    }
    if (jobr > mid) {
        ans = std::max(ans, queryMax(jobl, jobr, rs(i), mid+1, r));
    }
    return ans;
}

long long querySum(int jobl, int jobr, int i=1, int l=1, int r=n) {
    if (jobl <= l && jobr >= r) {
        return sum[i];
    }
    int mid = (l + r)/2;
    send(i, mid-l+1, r-mid);
    long long ans = 0;
    if (jobl <= mid) {
        ans += querySum(jobl, jobr, ls(i), l, mid);
    }
    if (jobr > mid) {
        ans += querySum(jobl, jobr, rs(i), mid+1, r);
    }
    return ans;
}

void add(int jobl, int jobr, long long v, int i=1, int l=1, int r=n) {
    if (jobl <= l && jobr >= r) {
        lazy(i, v, v, v, v, r - l + 1);
        return ;
    }
    int mid = l + (r - l) / 2;
    send(i, mid-l+1, r-mid);
    if (jobl <= mid) {
        add(jobl, jobr, v, ls(i), l, mid);
    }
    if (jobr > mid) {
        add(jobl, jobr, v, rs(i), mid+1, r);
    }
    collect(i);
}

long long queryHistoryMax(int jobl, int jobr, int i=1, int l=1, int r=n) {
    if (jobl <= l && jobr >= r) {
        return maxHistory[i];
    }
    int mid = (l + r) / 2;
    send(i, mid-l+1, r-mid);
    long long ans = LLONG_MIN;
    if (jobl <= mid) {
        ans = std::max(ans, queryHistoryMax(jobl, jobr, ls(i), l, mid));
    }
    if (jobr > mid) {
        ans = std::max(ans, queryHistoryMax(jobl, jobr, rs(i), mid+1, r));
    }
    return ans;
}

void solve() {
    cin >> n >> m;
    for (int i = 1; i <= n; i++) cin >> arr[i];
    build(1, n, 1);
    int op, l, r; long long x;
    while (m--) {
        cin >> op;
        if (op == 1) {
            cin >> l >> r >> x;
            add(l, r, x);
        } else if (op == 2) {
            cin >> l >> r >> x;
            setMin(l, r, x);
        } else if (op == 3) {
            cin >> l >> r;
            cout << querySum(l, r) << "\n";
        } else if (op == 4) {
            cin >> l >> r;
            cout << queryMax(l, r) << "\n";
        } else {
            cin >> l >> r;
            cout << queryHistoryMax(l, r) << "\n";
        }
    }
}

int main() {
    std::ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);
    solve();
    return 0;
}
```

拆分 K 次幂
1. 第二类斯特林
2. 组合数


## 筛法

[OI-WIKI](https://oi-wiki.org/math/number-theory/sieve/)

### 埃氏筛

如果我们从小到大考虑每个数，然后同时把当前这个数的所有（比自己大的）倍数记为合数，那么运行结束的时候没有被标记的数就是素数了。

**时间复杂度为：$O(n \log{\log n})$**

```c++ title:埃氏筛 fold
int ehrlich(int n) {
    vector<bool> visit(n + 1); // 默认所有数是质数
    for (int i = 2; i <= n; i++) {
        if (!visit[i]) { // false 代表是质数
        // 从 i*i开始是因为小于i的一定被其他数标记过了
            for (int j = i * i; j <= n; j += i) {
                visit[j] = true;
            }
        }
    }
    int cnt = 0;
    for (int i = 2; i <= n; i++)
        cnt += !visit[i];
    return cnt;
}
```

要找到直到`n`为止的所有素数，仅对不超过 $\sqrt n$ 的素数进行筛选就足够了

### 奇数筛

因为除 2 以外的偶数都是合数，所以我们可以直接跳过它们，只用关心奇数就好。

```c++ title:奇数筛 fold
// 奇数筛  改进埃氏筛，只能计数
int ehrlich2(int n) {
    if (n <= 1) {
        return 0;
    }
    vector<bool> visit(n + 1);
    int cnt = (n + 1) / 2; // 全体奇数，（n+1）是为了应对 n=3 的特殊情况
    for (int i = 3; i * i <= n; i += 2) {
        if (!visit[i]) {
            for (int j = i * i; j <= n; j += 2 * i) { // 每次加2i保证都是奇数
                if (!visit[j]) {
                    visit[j] = true;
                    cnt--;
                }
            }
        }
    }
    return cnt;
}
```

### 欧拉筛（线性筛）

埃氏筛法仍有优化空间，它会将一个合数重复多次标记。有没有什么办法省掉无意义的步骤呢？答案是肯定的。

如果能让每个合数都只被其**最小质因数**标记一次，那么时间复杂度就可以降到 $O(n)$ 了。

```c++ title:欧拉筛 fold
// 欧拉筛，是每一个合数都只由它的最小质因数标记

int euler(int n) {
    vector<bool> visit(n + 1);
    vector<int> prime;
    for (int i = 2; i <= n; i++) {
        if (!visit[i]) {
            prime.push_back(i);
        }
        for (int j = 0; j < prime.size(); j++) {
            if (i * prime[j] > n) {
                break;
            }
            visit[i * prime[j]] = true;
            if (i % prime[j] ==0) { // 此后的数的最小质因数一定是 prime[j], 不能由 prime[j+1] 标记
                break;
            }
        }
    }
    return prime.size();
}
```

+ 如果 `i % prime[j] ==0` 那么代表着 i 的最小质因数也是 prime[j]，如果该氏为 false，则代表 i 与 prime[j] **互质** 后续的其他拓展都依托该性质

### 筛法求欧拉函数

注意到在线性筛中，每一个合数都是被最小的质因子筛掉。比如设 $p_1$ 是 $n$ 的最小质因子， $n'= \frac{n}{p_1}$ ，那么线性筛的过程中 $n$ 通过 $n' \times p_1$ 筛掉。

观察线性筛的过程，我们还需要处理两个部分，下面对 $n' \mod p_1$ 分情况讨论。
如果 $n' \mod p_1 == 0$ ，那么 $n'$ 包含了 $n$ 的所有质因子。
$$\varphi(n)=n \times \prod_{i=1}^{s}{\frac{p_i-1}{p_i}} \newline 
=p_1 \times n' \times \prod_{i=1}^{s}{\frac{p_i-1}{p_i}} = p_1 \times \varphi(n')$$

那如果 $n' \mod p_1 \neq 0$ 呢，这时 $n'$ 和 $p_1$ 是互质的，根据欧拉函数性质，我们有：
$$\varphi(n)=\varphi(p_1) \times \varphi(n')=(p_1-1) \times \varphi(n')$$

```c++ title:筛法实现欧拉函数 fold
vector<int> pri;
bool not_prime[N];
int phi[N];

void pre(int n) {
  phi[1] = 1;
  // i 就是 上面的 n‘
  for (int i = 2; i <= n; i++) {
    if (!not_prime[i]) {
      pri.push_back(i);
      phi[i] = i - 1;  // 质数的 欧拉函数值
    }
    for (int pri_j : pri) {
      if (i * pri_j > n) break;
      not_prime[i * pri_j] = true;
      if (i % pri_j == 0) {
        phi[i * pri_j] = phi[i] * pri_j;
        break;
      }
      phi[i * pri_j] = phi[i] * phi[pri_j];
    }
  }
}
```

### 筛法求解质因数的个数
如果只求单个数的质因数个数的话，可以使用质因数分解的套路

```c++ title:质因数分解 fold
int f(int n) {
    int ans = 0;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) {
            ans++;
            while (n % i == 0) {
                n /= i;
            }
        }
    }
    if (n > 1) {
        ans++;
    }
    return ans;
}
```

使用筛法求解质因数的个数是，有如下几个要点，设 $p_1$ 为 `n` 的最小质因数 $n'=\frac{n}{p_1}$,在代码中表现为 `i`，
1. 当 $n' \mod p_1 == 0$ 说明 $n$ 的质因数个数和 $n'$ 一样 ` factor_count[i * primes[j]] = factor_count[i];`
2. 当 $n' \mod p_1 == 0$ 说明 $n$ 的质因数个数 为 $n'$ 的个数再加上 $p1$ `factor_count[i * primes[j]] = factor_count[i] + 1;`


```c++ title:质因数的个数 fold
vector<int> countPrimeFactors(int n) {
    vector<int> is_prime(n + 1, 1);
    vector<int> primes;
    vector<int> factor_count(n + 1, 0);  // 存储每个数的质因数个数
    
    is_prime[0] = is_prime[1] = 0;
    
    for (int i = 2; i <= n; ++i) {
        if (is_prime[i]) {
            primes.push_back(i);
            factor_count[i] = 1;  // 素数的质因数个数为1
        }
        
        for (int j = 0; j < primes.size() && i * primes[j] <= n; ++j) {
            is_prime[i * primes[j]] = 0;
            
            if (i % primes[j] == 0) {
                factor_count[i * primes[j]] = factor_count[i];  // 不增加质因数个数
                break;
            } 
            factor_count[i * primes[j]] = factor_count[i] + 1;  // 增加一个新的质因数
        }
    }
    
    return factor_count;
}
```

### 筛法求约数个数

约数定理：若 $n=\prod_{i=1}^{m}{p_i^{c_i}}$ 那么 $d_i=\prod_{i=1}^{m}{c_i+1}$, $d_i$ 为 `i` 的约数和,并且 $d_i$ 为积性函数
证明：$p_{i}^{c_i}$ 的约数有 $p_i^0 + p_i^1+...+p_i^{c_i}$ ,根据乘法原理就是$d_i=\prod_{i=1}^{m}{c_i+1}$

```c++
vector<int> pri;       // 存储素数的数组
bool not_prime[N];     // 标记是否为合数，not_prime[i]=true表示i是合数
int d[N];              // d[i]表示i的约数个数
int num[N];            // num[i]表示i的最小质因数的指数

d[1] = 1;  // 1的约数只有1本身
for (int i = 2; i <= n; ++i) {
    if (!not_prime[i]) {  // 如果i是素数
        pri.push_back(i); // 加入素数表
        d[i] = 2;        // 素数的约数个数为2（1和它本身）
        num[i] = 1;      // 素数的最小质因数指数为1（i^1）
    }
    // 筛去合数
    for (int pri_j : pri) {
        if (i * pri_j > n) break;  // 超过范围则退出
        not_prime[i * pri_j] = true;  // 标记为合数
        
        if (i % pri_j == 0) {  // 关键部分：i包含pri_j这个质因数
            num[i * pri_j] = num[i] + 1;  // 最小质因数指数+1
            d[i * pri_j] = d[i] / num[i * pri_j] * (num[i * pri_j] + 1);
            break;  // 保证每个合数只被最小质因数筛去
        } else {  // i不包含pri_j这个质因数
            num[i * pri_j] = 1;  // 新的最小质因数，指数为1
            d[i * pri_j] = d[i] * 2;  // 约数个数乘以2（新增一个质因数）
        }
    }
}
```

#### 代码的实现逻辑
1. **当i是素数时**：
    
    - 约数个数d[i] = 2（1和它本身）
        
    - num[i] = 1（因为它自己是唯一质因数，指数为1）
        
2. **当i × pri_j是合数时**，分两种情况：
    
    - **i包含pri_j（i % pri_j == 0）**：
        
        - 这意味着i × pri_j的最小质因数仍然是pri_j，只是指数增加了1
            
        - 更新 num[i×pri_j] = num[i] + 1
            
        - 约数个数更新公式：d[i×pri_j] = d[i] / (num[i]+1) × (num[i]+2)  
            （相当于把原来的(c+1)因子替换为(c+2)）
            
    - **i不包含pri_j（i % pri_j != 0）**：
        
        - 这意味着pri_j是i×pri_j的最小质因数（因为pri_j比i的任何质因数都小）
            
        - 设置num[i×pri_j] = 1
            
        - 约数个数d[i×pri_j] = d[i] × 2 
            （相当于在i的约数个数基础上乘以(1+1)，因为新增了一个质因数`pri_j^1` 0次和1次）

### 筛法求约数和


对于一个正整数 $n$，其约数和 $\sigma(n)$ 定义为 $n$ 的所有正约数之和，即：

$$
\sigma(n) = \sum_{d|n} d
$$

其中 $d|n$ 表示 $d$ 是 $n$ 的正约数。

#### 基于质因数分解的计算公式

若 $n$ 的质因数分解为：

$$
n = \prod_{i=1}^{k} p_i^{a_i} = p_1^{a_1} \times p_2^{a_2} \times \cdots \times p_k^{a_k}
$$

其中 $p_i$ 是质数，$a_i$ 是对应的指数，则约数和可以表示为：

$$
\sigma(n) = \prod_{i=1}^{k} \left(1 + p_i + p_i^2 + \cdots + p_i^{a_i}\right) = \prod_{i=1}^{k} \frac{p_i^{a_i+1} - 1}{p_i - 1}
$$

#### 性质

1. **积性函数**：若 $m$ 和 $n$ 互质（即 $\gcd(m,n)=1$），则：
   $$
   \sigma(mn) = \sigma(m) \times \sigma(n)
   $$

2. **特殊情况**：
   - 对于质数 $p$：
     $$
     \sigma(p) = 1 + p
     $$
   - 对于质数的幂 $p^k$：
     $$
     \sigma(p^k) = 1 + p + p^2 + \cdots + p^k = \frac{p^{k+1} - 1}{p - 1}
     $$

3. **完全数**：若 $\sigma(n) = 2n$，则 $n$ 称为完全数（即等于其真约数之和的数）。

```c++
vector<int> pri;       // 存储素数的数组
bool not_prime[N];     // 标记是否为合数，not_prime[i]=true表示i是合数
int g[N];              // g[i]表示i的最小质因数的等比数列和（p^0 + p^1 + ... + p^k）
int f[N];              // f[i]表示i的约数和

void pre(int n) {
  g[1] = f[1] = 1; // 1的约数只有1本身，约数和为1
  for (int i = 2; i <= n; ++i) {
    if (!not_prime[i]) {  // 如果i是素数
        pri.push_back(i); // 加入素数表
        g[i] = i + 1;     // 素数的g值为1 + p
        f[i] = i + 1;     // 素数的约数和为1 + p
    }
    // 筛去合数
    for (int pri_j : pri) {
        if (i * pri_j > n) break;  // 超过范围则退出
        not_prime[i * pri_j] = true;  // 标记为合数
        
        if (i % pri_j == 0) {  // 关键部分：i包含pri_j这个质因数
            g[i * pri_j] = g[i] * pri_j + 1;  // 更新等比数列和
            f[i * pri_j] = f[i] / g[i] * g[i * pri_j];  // 更新约数和
            break;  // 保证每个合数只被最小质因数筛去
        } else {  // i不包含pri_j这个质因数
            f[i * pri_j] = f[i] * f[pri_j];  // 约数和相乘（积性函数性质）
            g[i * pri_j] = 1 + pri_j;  // 新的最小质因数的等比数列和
        }
    }
}
}
```

- 更新等比数列和的代码数学原理为: 假设原数列和为 $\frac{1-q^n}{1-q}$ 当p增加到 $n-1$ 时，式子变为 $$\frac{1-q^{n+1}}{1-q}=\frac{q \times (1-q^n)}{1-q}+1$$
	$$\frac{q \times (1-q^n)}{1-q}=\frac{q-q^{n+1}}{1-q}=\frac{(1-q^{n+1})+(q-1)}{1-q}=\frac{1-q^{n+1}}{1-q}-1$$
- 更新约数和的原理为: $\left(1 + p_i + p_i^2 + \cdots + p_i^{a_i}\right)$ 变为 $\left(1 + p_i + p_i^2 + \cdots + p_i^{a_i+1}\right)$ ,因此先除前者，再乘后者


## LCA 问题

### 倍增算法

建立 `st[i][p]` 表示从 i 走 $2^p$ 长度到达哪个位置，很容易知道 `st[i][0]` ，之后进行转移 `st[i][p] = st[st[i][p-1]][p-1]` 即先到 $2^{p-1}$ 之后再跳 $2^{p-1}$ 长度。

ST表可以用来解决**可重复贡献**问题，比如说最大值、最小值、GCD、众数等问题。

[国旗计划](https://www.luogu.com.cn/problem/P4155)
[ST表查询最大值和最小值](https://www.luogu.com.cn/problem/P2880)
[ST表查询最大公约数](https://www.luogu.com.cn/problem/P1890)
[出现次数最多的数有几个](https://www.luogu.com.cn/problem/UVA11235)

```c++ title:最大最小值 fold
#include <bits/stdc++.h>
using std::cin, std::cout, std::string;

const int MAXN = 5e4+2;
int n, m;

int arr[MAXN];

int stmax[MAXN][20];
int stmin[MAXN][20];

void build() {
    for (int i = 1; i <= n; i++) {
        stmax[i][0] = arr[i];
        stmin[i][0] = arr[i];
    }
    for (int p = 1; p <= std::__lg(n); p++) {
        for (int i = 1; i+(1<<p)-1 <= n; i++) {
            
            stmax[i][p] = std::max(stmax[i][p-1], stmax[i+(1<<(p-1))][p-1]);
            stmin[i][p] = std::min(stmin[i][p-1], stmin[i+(1<<(p-1))][p-1]);
        }
    }
}

int query(int l, int r) {
    int p = std::__lg(r-l+1);
    int a = std::max(stmax[l][p], stmax[r-(1<<(p))+1][p]);
    int b =std::min(stmin[l][p], stmin[r-(1<<(p))+1][p]);
    return a- b;
}

void solve() {
    cin >> n >> m;
    for (int i = 1; i <= n; i++) cin >> arr[i];
    build(); int l, r;
    for (int i = 1; i <= m; i++) {
        cin >> l >> r;
        cout << query(l, r) << "\n";
    }
}

int main() {
    std::ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);

    solve();
    return 0;
}
```

### 树上倍增解决LCA

[P3379 【模板】最近公共祖先（LCA）](https://www.luogu.com.cn/problem/P3379)
- 算法步骤：
	- 1. 首先让深度更大的节点（a）到节点（b）的同一层
	- 2. 让节点 a 和 b 同时跳 $2^p$ 步，如果二者到达同一个节点，那么不执行该步，转而同时跳 $2^{p-1}$ 步，如果二者不相同，那么 a、b 跳至 st 表中的 p-1,继续执行
	- 3. 最后一定差一步到 LCA


```c++ title:倍增算法 fold
/*
* 树上倍增解 LCA 
*/


#include <bits/stdc++.h>
using std::cin, std::cout, std::string;

const int MAXN = 5e5+7;
int n, m, s;
int head[MAXN], next[MAXN << 1], to[MAXN << 1];
int cnt = 1;

int deep[MAXN];

int stjump[MAXN][20];

void dfs(int i, int fa) {
    deep[i] = deep[fa] + 1;
    stjump[i][0] = fa;
    for (int p = 1; p <= std::__lg(n); p++) {
        stjump[i][p] = stjump[stjump[i][p-1]][p-1];
    }
    for (int ei = head[i]; ei; ei = next[ei]) {
        if (to[ei] != fa) {
            dfs(to[ei], i);
        }
    }
}

int lca(int a, int b) {
    if (a == b) return a;
    if (deep[a] < deep[b]) {
        int tmp = a;
        a = b;
        b = tmp;
    }
    // 让 a 和 b 位于 同一层
    // for (int p = std::__lg(n); p >= 0; p--) {
    //     if (deep[stjump[a][p]] >= deep[b]) {
    //         a = stjump[a][p];
    //     }
    // }
    int k = deep[a] - deep[b];
    for (int p = 0; p <= std::__lg(k); p++) {
        if (k >> p & 1) {
            a = stjump[a][p];
        }
    }
    
    if (a == b) return b;

    for (int p = std::__lg(n); p >= 0; p--) {
        if (stjump[a][p] != stjump[b][p]) {
            a = stjump[a][p];
            b = stjump[b][p];
        }
    }
    return stjump[a][0];
}

void add(int u, int v) {
    next[cnt] = head[u];
    to[cnt] = v;
    head[u] = cnt++;
}



void solve() {
    cin >> n >> m >> s;
    int u, v;
    for (int i = 1; i < n; i++) {
        cin >> u >> v;
        add(u, v);
        add(v, u);
    }
    dfs(s, 0);
    for (int i = 0; i < m; i++) {
        cin >> u >> v;
        cout << lca(u, v) << "\n";
    }
}

int main() {
    std::ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);

    solve();
    return 0;
}
```