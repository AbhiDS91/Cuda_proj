#include <iostream>
#include <vector>
#include <chrono>

using namespace std;
using namespace std::chrono;

void matrixMultiply(const vector<vector<float>>& A,
                    const vector<vector<float>>& B,
                    vector<vector<float>>& C) {
    int m = A.size();
    int n = A[0].size();
    int p = B[0].size();

    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < p; ++j) {
            C[i][j] = 0.0f;
            for (int k = 0; k < n; ++k) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }
}

int main() {
    int m = 512, n = 512, p = 512;

    vector<vector<float>> A(m, vector<float>(n, 1.0f));
    vector<vector<float>> B(n, vector<float>(p, 1.0f));
    vector<vector<float>> C(m, vector<float>(p, 0.0f));

    auto start = high_resolution_clock::now();
    matrixMultiply(A, B, C);
    auto end = high_resolution_clock::now();

    auto duration = duration_cast<milliseconds>(end - start);
    cout << "CPU Matrix multiplication took " << duration.count() << " ms" << endl;

    cout << "C[0][0] = " << C[0][0] << endl;
    return 0;
}
