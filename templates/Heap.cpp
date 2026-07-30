/*
* 反向索引堆
*/

#include <bits/stdc++.h>
using std::cout;
using std::cin;

const int MAXN = 1000;
int heap[MAXN]; // 节点编号
int hsize = 0;
int dis[MAXN];
int where[MAXN]; // 节点在堆中的下标

void swap(int a, int b) {
    int tmp = heap[a];
    heap[a] = heap[b];
    heap[b] = tmp;
    where[heap[a]] = a;
    where[heap[b]] = b;
}
// 向上调整
void insert(int i) {
    while (i > 0 && dis[heap[i]] < dis[heap[(i-1)/2]]) {
        swap(i, (i-1)/2);
        i = (i-1)/2;
    }
}

// 向下调整
void heapify(int i) {
    int l = 2*i + 1, best;
    while (l < hsize) {
        best = l+1 < hsize && dis[heap[l+1]] < dis[heap[l]] ? l+1 : l;
        best = dis[heap[i]] < dis[heap[best]] ? i : best;
        if (best == i) break;
        swap(i, best);
        i = best;
        l = i * 2 + 1;
    }
}


int pop() {
    int ans = heap[0];
    swap(0, --hsize);
    heapify(0);
    where[ans] = -2;
    return ans;
}

void addOrupdate(int v, int c) {
    if (where[v] == -1) {
        heap[hsize] = v;
        dis[v] = c;
        where[v] = hsize++;
        insert(where[v]);
    } else if (where[v] >= 0) {
        // 只会减小，只需要向上调整
        dis[v] = std::min(dis[v], c);
        insert(where[v]);
    } 
    
}

void init() {
    hsize = 0;
    std::fill(dis, dis+MAXN, INT_MAX);
    std::fill(where, where+MAXN, -1);
}

int main() {
    int op, v, c;
    init();
    for (int i = 0; i < 10; i++) {
        cin >> op;
        if (op == 0) {
            cin >> v >> c;
            addOrupdate(v, c);
            cout << dis[heap[0]] << std::endl;
            cout << "hsize:" << hsize << std::endl;
        } else if (op == 1) {
            cout << dis[pop()] << std::endl;
            cout << "hsize:" << hsize << std::endl;
        } else if (op == 2) {
        cout << "\nheap: ";
        for (int i = 0; i < 10; i++) {
            cout << heap[i] << " ";
        }
        
        cout << "\ndis:";
        for (int i = 0; i < 10; i++) {
            cout << dis[i] << " ";
        }
    }
    }
    
    return 0;
}
