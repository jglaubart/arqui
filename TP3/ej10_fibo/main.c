#include <stdio.h>

int fibo(int n);

int main(){
    int n=10;
 
    int ans = fibo(n);
    printf("Fibo(%d) = %d\n", n, ans);
    return 0;
}