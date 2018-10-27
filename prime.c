#include <stdio.h>

int main(int argc, char const *argv[])
{
    for(int i = 2; i <= 100; i++){
        for(int j = 2; j <= i; j++){
            if(i == j){
                printf(" %d ", j);
            }
            if(i % j == 0){
                break;
            }
        }
    }
    return 0;
}