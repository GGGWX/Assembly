#include <stdio.h>

long long fibonacci(int i){
    return i < 2 ? i : fibonacci(i - 1) + fibonacci(i - 2);
}
int main(int argc, char const *argv[])
{
    for(int i = 1; i <= 30; i++){
        printf(" %lld ",fibonacci(i));
    }
    return 0;
}

