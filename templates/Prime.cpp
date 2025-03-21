/*
* 给定正整数 n，输出所有小于等于 n 的质数
*/

#include <bits/stdc++.h>
using namespace std;
// 埃氏筛

int ehrlich(int n) {
    vector<bool> visit(n+1); // 默认所有数是质数
    for (int i = 2; i <= n; i++) {
	if (!visit[i]) {
	    for (int j = i * i; j <= n; j += i) {
		visit[j] = true;
	    }
	}
    }
    int cnt = 0;
    for (int i = 2; i <= n; i++) cnt += !visit[i];
    return cnt;
}

// 欧拉筛，是每一个合数都只由它的最小质因数标记

int euler(int n) {
    vector<bool> visit(n+1);
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
	    if (i % prime[j] == 0) { // 此后的数的最小质因数一定是 prime[j], 不能由 prime[j+1] 标记
		break;
	    }
	}
    }
    return prime.size();
}

// 奇数筛  改进埃氏筛，只能计数
int ehrlich2(int n) {
    if (n <= 1) {
	return 0;
    }
    vector<bool> visit(n+1);
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


int main() {
    int n = 1000;
    cout << ehrlich(n) << endl;
    cout << euler(n) << endl;
    cout << ehrlich2(n) << endl;
    return 0;
}
