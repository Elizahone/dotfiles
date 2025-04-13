/*
 * 给定正整数 n，输出所有小于等于 n 的质数
 */

#include <bits/stdc++.h>
using namespace std;
// 埃氏筛

int ehrlich(int n) {
    vector<bool> visit(n + 1); // 默认所有数是质数
    for (int i = 2; i <= n; i++) {
        if (!visit[i]) {
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

// 求解质因数的个数
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

int main() {
    int n = 1e7;
    auto factor_count = countPrimeFactors(n);
    
    for (int i = 1; i <= n; ++i) {
        if (f(i) != factor_count[i]) {
            cout << "Error" << endl;
        }
    }
    cout << "AC" << endl;
    
    return 0;
}
