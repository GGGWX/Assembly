#include <stdio.h>
#include <stdlib.h>

const int maxNum = 8;
int ans[9];
int count = 0;

void print(){
    for(int i = 1;i <= maxNum;i++){
        printf("%i ", ans[i]);
    }
    printf("\n");
}

void queen(int i){
	if(i <= maxNum){
		for(int j = 1;j <= maxNum;j++){
            int k;
            for(k = 1;k < i;k++){
                if(ans[k] == j || (i-k) == abs(ans[k]-j))
                    break;
            }
            if(k == i){
                ans[i] = j;
                queen(i+1);
            }
        }
    }else{
        count++;
        print();
    }
        
}

int main(int argc, char const *argv[])
{
    queen(1);
	printf("%i\n", count);
    return 0;
}
