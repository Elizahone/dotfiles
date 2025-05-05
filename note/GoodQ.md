
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



# ALGORITHM


## 单调栈

单调栈最经典的用法是解决如下问题： 每个位置都求： 0） **当前位置的
左侧比当前位置的数字小，且距离最近的位置 在哪** 1） **当前位置的
右侧比当前位置的数字小，且距离最近的位置 在哪** 或者 每个位置都求： 0）
**当前位置的 左侧比当前位置的数字大，且距离最近的位置 在哪** 1）
**当前位置的 右侧比当前位置的数字大，且距离最近的位置 在哪**
或者，及时删除无用信息
用单调栈的方式可以做到：求解过程中，单调栈所有调整的总代价为O(n)，单次操作的均摊代价为O(1)

-   [模板题](https://www.nowcoder.com/practice/2a2c00e7a88a498693568cef63a4b7bb)
    经典实现是保持栈中严格单调，实际使用应根据实际选择，如 **例题1**

```c++ title:单调栈 fold
#include <iostream>
using namespace std;

int arr[1000001];
int ans[1000001][2];
int stack[1000001];
int n, r;

void compute() {
	r = 0;
	int cur;
	// 遍历压栈阶段
	for (int i = 0; i < n; i++) {
		while (r > 0 && arr[stack[r-1]] >= arr[i]) {
			cur = stack[--r];
			ans[cur][0] = r > 0 ? stack[r-1] : -1;
			ans[cur][1] = i;
		}
		stack[r++] = i;
	}
	// 清算阶段
	while (r > 0) {
		cur = stack[--r];
		ans[cur][1] = -1;
		ans[cur][0] = r > 0 ? stack[r-1] : -1;
	}
	// 修正阶段 当含有重复值时
	// 从右往左修正，n-1位置的右侧答案一定是-1，不需要修正
	for (int i = n - 2; i >= 0; i--) {
		if (ans[i][1] != -1 && arr[ans[i][1]] == arr[i]) {
			ans[i][1] = ans[ans[i][1]][1];
		}
	}
}

int main() {
	cin >> n;
	for (int i = 0; i < n; i++) {
		cin >> arr[i];
	}
	compute();
	for (int i = 0; i < n; i++) {
		cout << ans[i][0] << " " << ans[i][1] << endl;
	}
}

```

### 例题一 [每日温度](https://leetcode.cn/problems/daily-temperatures/description/)

```c++
class Solution {
public:
	vector<int> dailyTemperatures(vector<int>& temperatures) {
		int n = temperatures.size();
		vector<int> ans(n);
		stack<int> st;
		for (int i = 0; i < n; i++) {
			// 该题方法： 相等也加入栈中
			while (!st.empty() && temperatures[i] > temperatures[st.top()]) {
				int cur = st.top(); st.pop();
				ans[cur] = i - cur;
			}
			st.push(i);
		}
		return ans;
	}
};
```

### 例题二 [子数组的最小值之和](https://leetcode.cn/problems/sum-of-subarray-minimums/description/)

## 并查集(Union Find 又叫 Disjoint-Set)

### 并查集的使用是如下的场景

1）一G开始每个元素都拥有自己的集合，在自己的集合里只有这个元素自己，一开始代表元素是自己
2） `find(i)` ：查找i所在集合的代表元素，代表元素来代表i所在的集合 3）
`bool isSameSet(a, b)`
：判断a和b在不在一个集合里，即调用find函数看代表元素是否时同一个 4）
`void union(a, b)` ：a所在集合所有元素 与 b所在集合所有元素
合并成一个集合 5）各种操作单次调用的均摊时间复杂度为O(1)

并查集的两个优化，都发生在find方法里
1）扁平化（一定要做）,在find过程中，将所经过的元素直接挂在代表元素上
2）小挂大（可以不做，原论文中是秩的概念，可以理解为 粗略高度 或者 大小）

[测试链接](https://www.luogu.com.cn/problem/P3367)

模板：非小挂大优化，递归实现 find() 函数


```c++
#include<iostream>
#define N 100001
using namespace std;

int father[N]; // 父节点，最上面是代表节点
int n;
void build() {
  for (int i = 0; i < n; i++) {
	father[i] = i; // 初始每个集合的代表元素是自己
  }
}

// 递归方法解决, 并进行扁平化处理
int find(int i) {
  if (i != father[i]) {
	father[i] = find(father[i]);
  }
  return father[i];
}

bool isSameSet(int a, int b) {
  return find(a) == find(b);
}

void Union(int a, int b) {
  father[find(a)] = find(b);  // 把 a 所在的集合 挂在 b 所在集合上
}


int main() {
  int m;
  cin  >> n >> m;
  build();
  while (m--) {
	int z, x, y;
	cin >> z >> x >> y;
	if (z == 1) {
	  Union(x, y);
	} else {
	  string ans = isSameSet(x, y) ? "Y" : "N";
	  cout << ans << endl;
	}
  }
  return 0;
}
``` 

find() 的非递归实现：需增加 stack 数组作为栈存储路径上的节点

```c++
int stack[N];
int find(int i) {
  int size = 0;
  while (i != father[i]) {
	stack[size++] = i;
	i = father[i];
  }
  while (size > 0) {
	father[stack[--size]] = i;
  }
  return i;
}
```

小挂大优化：需增加 size\[\] 数组存储每个代表节点所代表集合的大小,修改
build()和Union() 函数

```c++
int size[N];
    void build() {
      for (int i = 0; i <= n; i++) {
        father[i] = i;
        size[i] = 1;
      }
    }
    void Union(int x, int y) {
      int fx = find(x);
      int fy = find(y);
      if (fx != fy) {
        // fx是集合的代表：拿大小
        // fy是集合的代表：拿大小
        if (size[fx] >= size[fy]) {
          size[fx] += size[fy];
          father[fy] = fx;
        } else {
          size[fy] += size[fx];
          father[fx] = fy;
        }
      }
    }
```

### 案例：

1.  例题一：[情侣牵手](https://leetcode.cn/problems/couples-holding-hands/)

    每两个人之间看作一个集合，若恰好满足题意，那么每个集合只有一对情侣，（如果一个集合里面有
    K 对情侣，那么必然需要交换 K-1 次。)

	```c++
	int father[31];
	        int sets;
	        class Solution {
	        public:
	          int minSwapsCouples(vector<int>& row) {
	            int n = row.size();
	            build(n/2);
	            for (int i = 0; i < n; i += 2) {
	              Union(row[i] / 2, row[i+1] / 2);
	            }
	            return n/2 - sets;
	          }
	
	          void build(int n) {
	            for (int i = 0; i < n; i++) {
	              father[i] = i;
	            }
	            sets = n;
	          }
	
	          int find(int i) {
	            if (i != father[i]) {
	              father[i] = find(father[i]);
	            }
	            return father[i];
	          }
	          void Union(int a, int b) {
	            if (find(a) == find(b)) return ;
	            father[find(a)] = find(b);
	            sets--;
	          }
	        };
	```

2.  例题二：[相似字符串组](https://leetcode.cn/problems/H6lPxb/description/)
```c++

int father[301];
int setsize;
class Solution {
public:
	int numSimilarGroups(vector<string>& strs) {
		int n = strs.size(); build(n);
		for (int i = 0; i < n; i++) {
			for (int j = i+1; j < n; j++) {
				if (check(strs[i], strs[j])) {
					_union(i, j);
				}
			}
		}
		return setsize;
	}

	bool check(string a, string b) {
		int diff = 0;
		for (int i = 0; i < a.size(); i++) {
			if (a[i] != b[i]) {
				diff++;
			}
		}
		return diff <= 2;
	}

	void build(int n) {
		for (int i = 0; i < n; i++) {
			father[i] = i;
		}
		setsize = n;
	}
	int find(int x) {
		if (father[x] != x) {
			father[x] = find(father[x]);
		}
		return father[x];
	}
	void _union(int a, int b) {
		int fa = find(a);
		int fb = find(b);
		if (fa != fb) {
			father[fa] = fb;
			setsize--;
		}
	}
};
```


3.  例题三：[岛屿数量](https://leetcode.cn/problems/number-of-islands/)

    将上下左右的 1 均 union，最后有几个集合即有几个岛屿 **build 函数**
```c++
public static void build(int n, int m, char[][] board) {
	  cols = m;
	  sets = 0;
	  for (int a = 0; a < n; a++) {
		  for (int b = 0, index; b < m; b++) {
			  if (board[a][b] == '1') {
				  index = index(a, b);
				  father[index] = index;
				  sets++;
			  }
		  }
	  }
  }
```


    dfs 解法 （最优）
```c++

class Solution {
public:
	int m, n;
	int numIslands(vector<vector<char>>& grid) {
		int ans = 0;
		m = grid.size(); n = grid[0].size();
		for (int i = 0; i < m; i++) {
			for (int j = 0; j < n; j++) {
				if (grid[i][j] == '1') {
					ans++;
					dfs(i, j, grid);
				}
			}
		}
		return ans;
	}

	void dfs(int i, int j, vector<vector<char>>& grid) {
		if (i < 0 || i == m || j < 0 || j == n || grid[i][j] == '0') {
			return ;
		}
		grid[i][j] = '0';
		dfs(i-1, j, grid);
		dfs(i+1, j, grid);
		dfs(i, j-1, grid);
		dfs(i, j+1, grid);
	}
};
```

4.  例题四：[移除最多的同行或同列石头](https://leetcode.cn/problems/most-stones-removed-with-same-row-or-column/description/)

    使用map来存储行和列，并记录其father节点索引

```c++
int father[1005];
int sets;
unordered_map<int, int> col;
unordered_map<int, int> row;
class Solution {
public:
	int removeStones(vector<vector<int>>& stones) {
		sets = stones.size();
		build(sets);
		for (int i = 0; i < stones.size(); i++) {
			int r = stones[i][0], c = stones[i][1];
			if (row.contains(r)) {
				_union(i, row[r]);
			} else {
				row[r] = i;
			}
			if (col.contains(c)) {
				_union(i, col[c]);
			} else {
				col[c] = i;
			}
		}
		col.clear(); row.clear();
		return  stones.size()- sets;
	}

	void build(int n) {
		for (int i = 0; i < n; i++) {
			father[i] = i;
		}
	}
	int find(int i) {
		if (i != father[i]) {
			father[i] = find(father[i]);
		}
		return father[i];
	}
	void _union(int a, int b) {
		int fa = find(a);
		int fb = find(b);
		if (fa != fb) {
			father[fa] = fb;
			sets--;
		}
	}
};
```
## 图

### 建图

通常会给所有边的集合，利用这些边的集合进行建图，可以使用
**邻接矩阵、邻接表，链式前向星。**

`邻接表建图` ：
```c++
    void createGraph(vector<vector<int, int, int>> edges) {
        vector<vector<pair<int, int>>> graph; // 带权图，不带权将pair改成单数据类型
        for (auto edge : edges) {
            int from = edge[0], to = edge[1], wt = edge[2];
            graph[from].push_back({to, wt}); // 有向图只需要这一行
            graph[to].push_back(from, wt); // 无向图建法
        }
    }
```
`链式前向星建图：
+ **head[]** ：下标表示点号，数据表示头边号 0表示没有 （顶点的第一条边） 
+ **next[]** 下标表示边号，数据表示下一条边的编号 （同一顶点的不同边） 
+ **to[]** 下标表示边号，数据表示去往的点
+ **weight\[\]** ：权重数组 **cnt=1**

```c++
    const int MAXN = 1e5; // 点
    const int MAXM = 1000; // 边
    int head[MAXN]; // 手动清理
    int next[MAXM];
    int to[MAXM];
    int cnt = 1;
    void addEdge(int u, int v) {
      next[cnt] = head[u];
      to[cnt] = v;
      head[u] = cnt++;
    }

    // 遍历顶点的所有边 u
    for (int ei = head[u]; ei > 0; ei = next[ei]) {

    }
    // dfs
    void dfs(int u) {
      if (vis[u]) return false;
      vis[u] = true;
      for (int ei = head[u]; ei > 0; ei = next[ei]) dfs(to[ei]);
    }
```
### 拓扑排序 TopologicalSort

`排序方法` ：首先拿出图中入度为 0
的节点（没有前置条件的节点），将其加入队列，并将边所指向的节点的入度减
1，如果减一后入度变为
0，将其加入队列，如此往复，知道队列为空，同时记录已排序的节点个数，如果不等于图中节点个数
意味着不能进行拓扑排序（存在环）

[模板题1](https://leetcode.cn/problems/course-schedule-ii/description/)
```c++
    class Solution {
    public:
        vector<int> findOrder(int numCourses, vector<vector<int>>& prerequisites) {
            vector<vector<int>> g(numCourses, vector<int>());
            vector<int> indegree(numCourses);
            for (auto p : prerequisites) {
                indegree[p[0]]++;
                g[p[1]].push_back(p[0]);
            }
            vector<int> queue(numCourses);
            int l = 0, r = 0;
            for (int i = 0; i < numCourses; i++) {
                if (indegree[i] == 0) {
                    queue[r++] = i;
                }
            }
            int cnt = 0;
            while (l < r) {
                int cur = queue[l++];
                for (auto to : g[cur]) {
                    if (--indegree[to] == 0) {
                        queue[r++] = to;
                    }
                }
                cnt++;
            }
            return cnt == numCourses ? queue : vector<int>();
        }
    };
```

[模板题2](https://www.nowcoder.com/practice/88f7e156ca7d43a1a535f619cd3f495c)

```c++
    #include <iostream>
    #include <vector>
    using namespace std;

    int main() {
        int n, m;
        cin >> n >> m;
        vector<vector<int>> g(n+1, vector<int>());
        vector<int> indegree(n+1);
        while (m--) {
            int a, b;
            cin >> a >> b;
            g[a].push_back(b);
            indegree[b]++;
        }
        vector<int> queue(n);
        int l = 0, r = 0;
        for (int i = 1; i <= n; i++) {
            if (indegree[i] == 0) {
                queue[r++] = i;
            }
        }
        int cnt = 0;
        while (l < r) {
            int cur = queue[l++];
            for (auto next : g[cur]) {
                if (--indegree[next] == 0) {
                    queue[r++] = next;
                }
            }
            cnt++;
        }
        if (cnt != n) {cout << -1 << endl; return 0;}
        for (int i = 0; i < n-1; i++) {
            cout << queue[i] << " ";
        }
        cout << queue[n-1] <<endl;
    }
```

### Dijkstra

我们的目标是计算出最终的 dis 数组。

-   首先更新起点 k 到其邻居 y 的最短路，即更新 dis\[y\] 为 g\[k\]\[y\]。
-   然后取除了起点 k 以外的 dis\[i\] 的最小值，假设最小值对应的节点是
    3。此时可以断言：dis\[3\] 已经是 k 到 3 的最短路长度，不可能有其它 k
    到 3 的路径更短！反证法：假设存在更短的路径，那我们一定会从 k
    出发经过一个点 u，它的 dis\[u\] 比 dis\[3\]
    还要小，然后再经过一些边到达 3，得到更小的 dis\[3\]。但 dis\[3\]
    已经是最小的了，并且图中没有负数边权，所以 u
    是不存在的，矛盾。故原命题成立，此时我们得到了 dis\[3\] 的最终值。
-   用节点 3 到其邻居 y 的边权 g\[3\]\[y\] 更新 dis\[y\]：如果
    dis\[3\]+g\[3\]\[y\]\<dis\[y\]，那么更新 dis\[y\] 为
    dis\[3\]+g\[3\]\[y\]，否则不更新。
-   然后取除了节点 k,3 以外的 dis\[i\] 的最小值，重复上述过程。
-   由数学归纳法可知，这一做法可以得到每个点的最短路。当所有点的最短路都已确定时，算法结束。

`朴素Dijkstra` ：适用于稠密图

```c++
     class Solution {
    public:
        int networkDelayTime(vector<vector<int>>& times, int n, int k) {
            vector<vector<int>> g(n, vector<int>(n, INT_MAX / 2)); // 邻接矩阵
            for (auto& t : times) {
                g[t[0] - 1][t[1] - 1] = t[2];
            }
            vector<int> dis(n, INT_MAX / 2), done(n); // 距离数据和已完成数组
            dis[k-1] = 0;
            while (true) {
                int x = -1;
                // 找到为完成 done 的最小的节点，并标记为 done
                for (int i = 0; i < n; i++) {
                    if (!done[i] && (x < 0 || dis[i] < dis[x])) {
                        x = i;
                    }
                }
                // 如果x为-1，意味着所有的节点都 done 了
                if (x < 0) {
                    return ranges::max(dis);
                }
                // 如果 x 为 ，意味着有节点不可达
                if (dis[x] == INT_MAX / 2) {
                    return -1;
                }
                done[x] = true;
                for (int y = 0; y < n; y++) {
                    dis[y] =  min(dis[y], dis[x] + g[x][y]);
                }
            }
        }
    };
```

`堆优化Dijkstra` :适用于稀疏图，并且使用堆优化

问：为什么代码要判断 d \> dis\[i\]\[j\]？可以不写 continue 吗？

答：对于同一个点 (i,j)，例如先入堆一个比较大的
dis\[i\]\[j\]=10，后面又把 dis\[i\]\[j\] 更新成 5。之后这个 5 会先出堆，
然后再把 10 出堆。10 出堆时候是没有必要去更新周围邻居的最短路的，因为 5
出堆之后，就已经把邻居的最短路更新过了，用 10
是无法把邻居的最短路变得更短的，所以直接 continue。本题由于只有 4
个邻居，写不写其实无所谓。但如果是一般图，不写这个复杂度就不对了，可能会超时。
```c++
    class Solution {
    public:
        int networkDelayTime(vector<vector<int>>& times, int n, int k) {
            vector<vector<pair<int, int>>> g(n); // 邻接表
            for (auto& t : times) {
                g[t[0] - 1].emplace_back(t[1] - 1, t[2]);
            }

            vector<int> dis(n, INT_MAX);
            dis[k - 1] = 0;
            priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> pq;
            pq.emplace(0, k - 1);
            while (!pq.empty()) {
                auto [dx, x] = pq.top();
                pq.pop();
                if (dx > dis[x]) { // x 之前出堆过
                    continue;
                }
                for (auto &[y, d] : g[x]) {
                    int new_dis = dx + d;
                    if (new_dis < dis[y]) {
                        dis[y] = new_dis; // 更新 x 的邻居的最短路
                        pq.emplace(new_dis, y);
                    }
                }
            }
            int mx = ranges::max(dis);
            return mx < INT_MAX ? mx : -1;
        }
    };
```
## DP

### 背包问题

1.  0-1 背包问题

    每种商品只能只有两种可能：选（1）或 不选（0），因此动态转移方程为：
    `dp[i][j] = max(dp[i-1][j], dp[i-1][j-w[i]]+val[i])`
    在0-i范围内选取，容量不超过j，最终结果为 <u>dp\[n\]\[j\]</u> 。

2.  有依赖的背包

3.  分组背包

    所有商品经过分组，每个分组最多选择一个。
    只需要对每个分组进行展开，对于每个分组依然是0-1背包。 典型例题：
    [从栈中取出 K
    个硬币的最大面值和](https://leetcode.cn/problems/maximum-value-of-k-coins-from-piles)

4.  完全背包

    和 0-1 背包的区别就是每个商品都可以无限选择，因此，当在 0-i
    范围内选择时，假如第 i 件商品不选择（选择），那么子问题依然是 0-i
    的范围内选择。 `dp[i][j] = max(dp[i][j], dp[i][j-w[i]]+val[i])`

5.  多重背包

    当每个商品有其数量限制，不同于0-1背包（1个），完全背包（无限）。

    -   解法：枚举每个商品选取几件.
        `dp[i][j] = max(dp[i-1][j-w[i]], dp[i-1][j-2*w[i]], ... , dp[i][j])`
        -   优化：

6.  混合背包


### 删除一些数使得不存在相邻的数

[ABC403-D](https://atcoder.jp/contests/abc403/tasks/abc403_d)


- 显然 **对于一个数，要么全删，要么全不删**
**与值域无关的解法：**
设 $dp[i][0]$ 为第i个数要删，$dp[i][1]$ 为第i个数不删，那么：$dp[0][0]=1,dp[0][1]=0$
- 当 $a_i = a_{i-1}$时：$dp[i][0]\ =\ dp[i-1][0]$, $dp[i][1]\ =\ dp[i-1][1]+1$
- 当 $a_i  = a_{i-1}+1$时：$dp[i][0]=min(dp[i-1][0], dp[i-1][1])+1$, $dp[i][1]=dp[i-1][0]$
- 当 $a_i > a_{i-1}+1$时：$dp[i][0]=min(dp[i-1][0], dp[i-1][1])+1$, $dp[i][0]=min(dp[i-1][0], dp[i-1][1])$

**与值域有关的解法：**
预处理每个数的个数，假设为 $C_x$
设 $dp[i][0]$ 为`数i`要删，$dp[i][1]$ 为`数i`不删
同理如上分类讨论

## 逆元

`逆元详解：` <https://www.luogu.com.cn/problem/solution/P3811>

p的逆元等于 `inv =` p \^ (mod-2) % mod= 最后 **a / b % mod = ((a % mod)
\* inv) % mod** , **inv** 的计算可用快速幂计算。 需满足如下条件：

1.  a / b 能除尽 （a 能被 b 整除）
2.  mod 为质数

逆元的线性递推公式：
`inv[i] = (int) (mod - (long long)inv[mod % i] * (mod / i) % mod)`

+ $a在模p下的逆元$
设 $p=aq+r$,即 $q=\lfloor p/a \rfloor, r=p \mod a$
在模p的意义下，有 $aq+r=0(mod \ \ p)$ 
移项整理得：$a = -r\times \ inv(q) (mod \ \ p)$ 两边取逆元有：$inv(a)=-inv(r)\times q \ (mod \ \ p)$ 也就是：$inv(a)=-\lfloor p/a \rfloor \times inv(p \mod a)\ \ (mod\ \ p)$
## KMP

最长真前后缀：aaaaa，前缀是 0 1 2 3 ，后缀是 4 3 2 1，不包含整体。
**next\[\]**
的定义：不含当前，前面字符串钱后缀最大匹配长度（不能是前面的整体）。因此next\[0\]=-1,
next\[1\]=0是确定的。

如何快速得到 `next` 数组，假设来到了第 i 个字符，设 `len = next[i-1]`
，如果 s\[len\] == s\[i-1\]，那么 next\[i\] 就等于
len+1，如果不等于那么就跳到 len 位置继续上述操作。

```c++ fold
    vector<int> getNext(string& s) {
      int n = s.size();
      if (n == 1) return {-1};
      vector<int> next(n+1);
      next[0] = -1, next[1] = 0;
      int len = next[1]; 
      for (int i = 2; i <= n; i++) {
        while (len >= 0 && s[i-1] != s[len]) {
          len = next[len];
        }
        next[i] = ++len;
      }
      return next;
    }

    int KMP(string& s1, string& s2) {
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
```
## 字符串哈希

通过自定义字符串哈希函数为每个字符串生成特定的哈希值，可以不逐位比较。同时，通过特定的预处理结构可以快速得到字串的哈希值，从而替代
KMP 算法，但是时间复杂度没有 KMP 好，但是理解难度低。
**字符串哈希函数：**
任意选择一个质数作为基数，就如同二进制一样。让最后的值自然溢出（mod
2^64^），最后的哈希值理论上存在哈希冲突，但是概率极小，就算真冲突了，也可以通过更换基数解决。
能不用就不用

```c++
const int base = 499;


int v(char c) {
  if (c >= '0' && c <= '9') {
	return c - '0' + 1;
  } else if (c >= 'A' && c <= 'Z') {
	return c - 'A' + 11;
  } else {
	return c - 'a' + 37;
  }
}


long long strHash(string& s) {
  long long value = v(s[0]);
  for (int i = 1; i < s.size(); i++) {
	value = value * base + v(s[i]);
  }
  return value;
}
```
`获得某个字串的hash值，维护一个hash前缀，每次都过O（1）时间获得` 此方法降低了字串比较的代价，可以替代KMP和Manacher

```c++ fold
    const int MAXN = 1e5 + 7;
    const int BASE = 499;
    long long pow[MAXN]; // base ^ i
    long long hash[MAXN];

    void init(string& s) {
      int n = s.size();
      pow[0] = 1;
      for (int i = 1; i < MAXN; i++) {
        pow[i] = pow[i-1] * BASE;
      }
      // hash list
      hash[0] = s[0] - 'a' + 1;
      for (int i = 1; i < n; i++) {
        hash[i] = hash[i-1] * base + s[i] - 'a' + 1;
      }
      // if you wanna get [l, r]'s hashvalue, just return hash[r] - hash[l-1] * base^(r - l + 1)
    }

    long long getHash(int l, int r) {
      long long ans = hash[r];
      if (l > 0) {
        ans -= hash[l-1] * pow[r - l + 1];
      }
      return ans;
    }
```
## AC 自动机

[讲解视频-左程云](https://www.bilibili.com/video/BV1Sy421a78C/?spm_id_from=333.1387.collection.video_card.click&vd_source=3e78417e114be9d4af93565f11845737)
<https://www.luogu.com.cn/problem/P5357>

每个可能性都没丧失，只不过每个节点只保存了最长前后缀匹配的最大长度（即
`fail` 指针的指向，通过在fail的跳转实现对所有可能性的查找，类似与kmp中
`len = next[len];` 语句，不断跳转）
fail指针设定规则：（由起始节点（父节点）设定终止节点（子节点）的fail指针）如果边为
a 的起始节点的fail指针所指向的节点（假设为2号节点）a边，那么 该起始节点
a边的终止节点的fail指针就指向2号节点，倘若2号节点不存在a边，则继续跳转至2号节点的fail指针指向的节点，
重复上述操作，直到设定成功或者到 0节点。意思为：
**如果匹配失败，那么其他目标字符的前缀和当前所匹配的字符串的真后缀最长相同值一定是fail指针所指向的节点**

**`fail指针绕圈现象`** : 只fail指针在构建、匹配失败、词频传递时都需要顺着fail指针链走很长距离。时间复杂度很大

-   优化一；建立AC自动机时和匹配失败时防止绕圈
    绕圈原因：每次都需要顺着fail指针走，对于Tire所形成的表中，可将值为0（没有这条路）的数据直接设定为最终的目的地。具体方法为：当父节点设定子节点时，对于每条路，如果没有路（值为0），则将该值设为父节点fail指针指向的节点的该路的值。
    就如 `优化KMP的nextval数组` 这样就可以直接到达目标节点，不需要依次寻路。
-   优化二：遍历主串时不知道命中了哪些目标串，需要fail指针绕圈进行词频传递
    在传递词频时，每次都将fail指针的指向节点词频加一，fail指针所指向的节点一定在该节点的上层，该过程像子树像父节点传递。在遍历时不绕圈，在遍历完之后，通过把fail指针看作边的指向进行建树，该节点的最终词频就为该点的词频加上子树的词频。
-   优化三：当问题不允许离线处理（优化二）时，比如当存在某个目标字符时就报警，然后停止。在匹配过程中，为了确定到底要不要报警时需要fail指针绕圈。为避免绕圈，可以设置一个
    `alter[]` 表，**alter[u] |=alter[fail[u]]**，最初的alter在建立前缀树时设定。
    <https://www.luogu.com.cn/problem/P3311>

## Manacher

Manacher
算法最经典的用法是用以求最长回文子序列问题。对于该问题，最朴素的算法是每到一个位置（假设为回文中心）就往两边扩展，但是会丢失偶数长度的回文串，为此可以将每个字符两边添加一个任意字符（‘#’），这样再进行上述操作就不会丢失可能性。
Manacher算法通过利用隐含的信息建立 `回文半径数组` 将时间复杂度优化到
O(n) 。

-   **回文半径：** 当前字符向某一方向最远可扩的距离。无法扩展为 1。
-   **回文覆盖最右边界（r）：**
    以往字符的回文半径所不能达到的最近的字符下标（最远可达字符加一），例如：
    `abac` ，r=3（c）
-   **回文中心（c）：** 最先扩展回文覆盖最右边界的字符下标

Manacher算法共有一下四种可能情况：

1.  i（当前字符下标）没有被 r 包住，此时不能加速，以 i 为中心直接扩展
2.  i 被 r 包住， 对称点 `2*c-i`
    的回文半径在大回文区域（以c为中心，r为半径）内，直接确定
    `p[i] = p[2*c-i]`
3.  i 被 r 包住， 对称点 `2*c-i` 的回文半径不在在大回文区域内，直接确定
    `p[i] = r-i`
4.  i 被 r 包住， 对称点 `2*c-i` 的回文半径撞线大回文区域边界，从 r
    位置直接开始扩展

```c++ fold

    #include <bits/stdc++.h>
    const int MAXS = 11000007;
    int n;
    char ss[MAXS << 1];
    int p[MAXS << 1];

    void manacherss(std::string& s) {
      for (int i = 0, j = 0; i < 2*n+1; i++) {
        ss[i] = i & 1 ? s[j++] : '#';
      }
    }

    int manacher() {
      int mx = 0;
      for (int i = 0, r = 0, c = 0, len; i < 2*n+1; i++) {
        len = r > i ? std::min(p[2*c - i], r - i) : 1;
        while (i + len < 2*n + 1 && i - len >= 0 && ss[i-len] == ss[i+len]) {
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
```

<https://leetcode.cn/problems/maximum-number-of-non-overlapping-palindrome-substrings/description/>

## Z 函数（扩展KMP）

求解一个字符串从某一下标开始的字串和该字符串整体的最大前缀匹配长度（Z数组），下面四种情况和Manacher算法有着惊人的相似。

-   **最右匹配右边界（r）：**
    从某一下标出发扩展出的最近不合规的下标，（对比 `回文覆盖右边界` ）
-   **匹配中心（c）：** 叫匹配起点更合适一点。含义是最先抵达
    **最右匹配右边界** 的下标。

四种情况：

1.  i（当前字符下标）没有被 r 包住，此时不能加速，以 i 为起点直接扩展

2.  i 被 r 包住， 关键点 `i-c` 的 `i+z[i-c]` 小于 `r` ，直接确定
    `z[i] = z[c-i]`

3.  i 被 r 包住， 关键点 `i-c` 的 `i+z[i-c]` 大于 `r` ，直接确定
    `z[i] = r-i`

4.  i 被 r 包住， 关键点 `i-c` 的 `i+z[i-c]` 等于 `r` ，从 r
    位置直接开始扩展

```c++ fold
vector<int> zArray(string& s) {
  int n = s.size();
  z[0] = n;
  for (int i = 1, r = 1, c = 1, len; i < n; i++) {
	len = r > i ? min(z[i-c], r - i) : 0;
	while (i + len < n && s[i+len] == s[len]) {
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
```

E数组。两个字符串 A B，E\[i\]为 A 从下标i开始的子串和 B
整体的最长匹配长度。需要借助B的Z数组。 同样有四种情况，r和c的定义同上：

1.  i（当前字符下标）没有被 r 包住，此时不能加速，以 i 为起点直接扩展

2.  i 被 r 包住， 关键点 `i-c` 的 `i+z[i-c]` 小于 `r` ，直接确定
    `e[i] = z[c-i]`

3.  i 被 r 包住， 关键点 `i-c` 的 `i+z[i-c]` 大于 `r` ，直接确定
    `e[i] = r-i`

4.  i 被 r 包住， 关键点 `i-c` 的 `i+z[i-c]` 等于 `r` ，从 r
    位置直接开始扩展

```c++ fold
vector<int> eArray(string& a, string& b, vector<int>& z) {
  int n = a.size();
  vector<int> e(n);
  for (int i = 0, r = 0, c = 0, len; i < n; i++) {
	len = r > i ? min(z[i-c], r - i) : 0;
	while (i + len < n && a[i+len] == b[len]) {
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
```

## 树状数组

一般用来维护可差分的信息，比如累加和、累乘积。
不可差分的信息，比如最大值、最小值等 下标必须从 1
开始，每次更新、得到范围信息都需要借助lowbit进行跳转。当数据扩展到二维时，树状数组对比线段树更加高效，先段树需要
**树套树** 技巧。

`用法一：区间查询，单点增加` ：使用树状数组维护原始数组
<https://www.luogu.com.cn/problem/P3374>

```c++ fold
class IndexTree {
  vector<int> tree;
  int n;
public:
  // 数据范围
  IndexTree(int n): tree(n+3), n(n){};

  // 单点增加
  void add(int i, int v) {
	while (i <= n) {
	  tree[i] += v;
	  i += i & (-i);
	}
  }
  // 返回 [1，r] 的累加和
  int sum(int r) {
	int ans = 0;
	while (r > 0) {
	  ans += tree[r];
	  r -= r & -r;
	}
	return ans;
  }

  int query(int l, int r) {

	return sum(r) - sum(l-1);
  }
};
```

`用法二：单点查询，区间增加` ：使用树状数组维护原始数组的差分信息
<https://www.luogu.com.cn/problem/P3368>

```c++ fold
class IndexTree {
  vector<int> tree;
  int n;
public:
  // 数据范围
  IndexTree(int n): tree(n+3), n(n){};

  void add(int i, int v) {
	while (i <= n) {
	  tree[i] += v;
	  i += i & -i;
	}
  }
  // 范围增加
  void add(int l, int r, int v) {
	add(l, v);
	add(r+1, -v);
  }
  // 返回 [1，r] 的累加和
  int sum(int r) {
	int ans = 0;
	while (r > 0) {
	  ans += tree[r];
	  r -= r & -r;
	}
	return ans;
  }

  int query(int i) {

	return sum(i);
  }
};
```

`用法三：区间查询，区间增加` ：从一道 k 的区间和可以表示为 ：
`k * sum(1, k, di) - sum(1, k, (i-1)*di)` sum表示从 i 到 k 的 di的和，其中di是差分信息,使用 线段树
<https://www.luogu.com.cn/problem/P3372>

```c++ fold
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
```

`用法四：二维数组上单点增加和范围查询` ：运用二维前缀和的技巧 (a, b) -\>
(c, d) 范围的累加和为 sum\[c\]\[d\] - sum\[c\]\[b-1\] -
sum\[a-1\]\[d\] + sum\[a-1\]\[b-1\]

```c++ fold
    int lowbit(int i) {
      return i & -i;
    }

    // (x, y) 点加上 v
    void add(int x, int y, int v) {
      for (int i = x; i <= n; i += lowbit(i)) {
        for (int j = y; j <= m; j += lowbit(j)) {
          tree[i][j] += v;
        }
      }
    }

    // 从(1,1)到(x,y)这个部分的累加和
    int sum(int x, int y) {
      int ans = 0;
      for (int i = x; i > 0; i -= lowbit(i)) {
        for (int j = y; j > 0; j -= lowbit(j)) {
          ans += tree[i][j];
        }
      }
      return ans;
    }
```

`用法五：二维数组上的范围增加和范围查询` ：二维数组的差分定义：(i, j) - (i-1, j) - (i, j-1) + (i-1, j-1); 二维差分数组 (a, b)+k; (c+1, d+1) + k;
(c+1, b)-k; (a, d+1)


## 博弈问题

[简单易懂的博弈论讲解(巴什博弈、尼姆博弈、威佐夫博弈、斐波那契博弈、SG定理)](https://www.cnblogs.com/Khada-Jhin/p/9609561.html)

威佐夫博弈：
+ 小 != (大 - 小) * 黄金分割比例，先手win
+ 小 == (大 - 小) * 黄金分割比例，后手win

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
埃氏筛：每个质数会将其倍数改为非质数，在该过程的就可以累加质因数个数

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

```c++ title:埃氏筛求个数 :fold
 for (int i = 2; i < A; i++) {
 		if (v[i] == 0) for (int j = i; j < A; j += i) v[j]++;
	}
```

```c++ title:筛法求质因数的个数 fold
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

ST表可以用来解决**可重复贡献**问题，比如说最大值、最小值、GCD、众数等问题，并且可以在树上应用。

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
为在线算法，可用来实现[树上差分](#树上差分)
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

### tarjan 算法

算法思想：遍历一个节点的所有子树，遍历前标记已到达，当遍历完之后，结算与该节点有关的所有查询，**如果该查询的另一节点已经遍历过，那么答案为另一节点的代表节点（并查集维护，父节点永远是代表节点），如果没遍历过，略过。** 因此还需要对查询建图

```c++ title:tarjan fold
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
```


## 树上前缀和 && 树上差分

[树上前缀和(董晓算法)](https://www.cnblogs.com/dx123/p/17523492.html)


[董晓算法视频](https://www.bilibili.com/video/BV1xV4y187qR/?spm_id_from=333.999.0.0&vd_source=607514df4428a309d5130d87a0423d0c)
[董晓算法博客](https://www.cnblogs.com/dx123/p/17526375.html)

前置知识：[LCA](#LCA 问题)

点差分：对路径 (x, y) 上的所有点加一操作等于在差分树上对 **x,y 点+1，对二者的 LCA -1，LCA的父亲 -1**

边差分：对路径上的所有边做+1操作，由于边的修改困难，注意到每个边只对应一个子节点，即下方的节点，因此将边权下放给节点，转换为点权，**x,y 点+1，对二者的 LCA -2** 因为LCA的值对应其上方的边，还原时会收到两个+1操作

+ 差分值定义：父节点的值-子节点的值

适用于多次对树上的路径进行 加减操作


[Luogu P3128 [USACO15DEC] Max Flow P](https://www.luogu.com.cn/problem/P3128)
[Luogu U143800 暗之连锁](https://www.luogu.com.cn/problem/U143800)

[Luogu P3258 [JLOI2014] 松鼠的新家](https://www.luogu.com.cn/problem/P3258)

[Luogu P2680 [NOIP2015 提高组] 运输计划](https://www.luogu.com.cn/problem/P2680)

[Luogu P1600 [NOIP2016 提高组] 天天爱跑步](https://www.luogu.com.cn/problem/P1600)

[Luogu P4556 [Vani有约会] 雨天的尾巴](https://www.luogu.com.cn/problem/P4556)

## 左偏树 / 可并堆

[cnblog by @董晓](https://www.cnblogs.com/dx123/p/17536222.html)


核心函数：merge，合并两个队
	1. 维护堆的性质：以较小的节点做新根，如果题目要求当权值相同时编号较小的做根的话也需维护
	2. 维护左偏的性质，保证每次合并的时间复杂度为 $O(\log(n) + \log(m))$

每个节点存储 权重 v, 该节点距离任一外节点的最短距离 dis，左右字节点 lc & rc
并规定外节点为左右孩子有一个为空的节点，外节点的距离为 0，空节点的距离为 -1

左偏树的性质：
	1. 堆的性质
	2. 左偏性质
	3. 节点的距离 = 右孩子的距离 + 1

```c++ title:merge实现 fold
int merge(int x, int y) {
    if (!x || !y) return x+y;
    if (v[x] == v[y] ? x > y : v[x] > v[y]) std::swap(x, y); // 维护堆的性质
    rc[x] = merge(rc[x], y);

    if (dis[lc[x]] < dis[rc[x]]) std::swap(lc[x], rc[x]);  // 维护左偏性
    dis[x] = dis[rc[x]] + 1;  // 更新dis
    return x;
}
```

[Luogu P3377 【模板】左偏树（可并堆）](https://www.luogu.com.cn/problem/P3377)
左偏树没法快速找到所在堆的堆顶，因此需借助 并查集
+ 当合并两个堆时，将并查集中两个代表元素挂在新根下，保证并查集中的根和左偏树的根为同一个 `if (fx != fy) fa[fx] = fa[fy] = merge(fx, fy);` 实质上只更新了一个，有一个一定没变
+ 删除某一节点时，相当于合并该节点的两个子树，`fa[x] = fa[lc[x]] = fa[rc[x]] = merge(lc[x], rc[x]);` 同时，原来节点在并查集中并未删去，只作为其他节点到根节点的桥梁。

```c++ title:模板
/*
  左偏树  https://www.luogu.com.cn/problem/P3377
*/


#include <bits/stdc++.h>
using std::cin, std::cout, std::string;

const int MAXN = 1e5+1;
int v[MAXN], dis[MAXN], lc[MAXN], rc[MAXN];

int fa[MAXN];

// 合并两个小根堆
int merge(int x, int y) {
    if (!x || !y) return x+y;
    if (v[x] == v[y] ? x > y : v[x] > v[y]) std::swap(x, y); // 维护堆的性质
    rc[x] = merge(rc[x], y);

    if (dis[lc[x]] < dis[rc[x]]) std::swap(lc[x], rc[x]);  // 维护左偏性
    dis[x] = dis[rc[x]] + 1;  // 更新dis
    return x;
}

int find(int x) { return x == fa[x] ? x : fa[x] = find(fa[x]); }

void solve() {
    dis[0] = -1; // 空节点默认为 -1
    int n, m;
    cin >> n >> m;
    for (int i = 1; i <= n; i++) cin >> v[i], fa[i] = i;

    int op, x, y;
    while (m--) {
        cin >> op;
        if (op == 1) {
            cin >> x >> y;
            if (v[x] == -1 || v[y] == -1) continue ;
            int fx = find(x), fy = find(y);
            if (fx != fy) fa[fx] = fa[fy] = merge(fx, fy); // 代表节点为新根
            
        } else {
            cin >> x;
            if (v[x] == -1) {
                cout << "-1\n";
                continue;
            }
            x = find(x); // 堆中最小值
            cout << v[x] << "\n";
            v[x] = -1;
            fa[x] = fa[lc[x]] = fa[rc[x]] = merge(lc[x], rc[x]);
        }
        
    }
    
}

int main() {
    std::ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);

    solve();
    return 0;
}
```

+ 当堆顶值变化是，需要进行调整，一种简单办法就是先把调整的节点删去，在给他合并到堆中。
[Luogu P1456 Monkey King](https://www.luogu.com.cn/problem/P1456)
```c++ title:堆的调整 fold
int weak(int x) {
    v[x] >>= 1;
    int rt = merge(lc[x], rc[x]);
    lc[x] = rc[x] = dis[x] = 0;
    return fa[x] = fa[rt] = merge(rt, x);
}
```

## 高斯消元
### 高斯消元求解加法方程组

### 高斯消元求解异或方程组

### 高斯消元求解同余方程组

前置：[逆元](#逆元)


## 线性基

### 异或空间线性基


