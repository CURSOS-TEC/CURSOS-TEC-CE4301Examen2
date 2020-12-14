#define size 2000
int a[size][size] = { [0 ... size-1 ] = {[0 ... size-1 ] = 3} };
int b[size][size] = { [0 ... size-1 ] = {[0 ... size-1 ] = 4} };
int c[size][size] = { [0 ... size-1 ] = {[0 ... size-1 ] = 5} };

int main(int argc, char *argv[]) {
    int i,j,k;
    for(i=0; i<size; i++) {
        for(j=0; j<size; j++) {
            for(k=0; k<size; k++) {
                c[i][j] =  a[i][k] * b[k][j] + c[i][j];
            }
            // printf("%d \n", a[i][j]);
        }
    }

}