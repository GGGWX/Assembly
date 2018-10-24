#include <stdio.h>

int main(int argc, char const *argv[])
{
    for(int i = 2; i <= 100; i++){
        int flag = 1;
        for(int j = 2; j < i; j++){
            if(i % j == 0){
                flag = 0;
                break;
            }
        }
        if(1 == flag){
            printf(" %d ", i);
        }
    }
    return 0;
}
