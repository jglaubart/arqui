#include <stdio.h>

char get_pad(){
    static char pad = 0;
    pad++;
    return pad;
}

void encrypt(char *plain, char *cipher){
    if(!(*plain)){
        *cipher = 0;
        return;
    }
    char pad = get_pad();
    *cipher = *plain + pad;
    encrypt(plain+1, cipher+1);
}

    void test(){
        char *msg = "Ark";
        char cipher[] = "--------";
        cipher[4] = '0';
        encrypt(msg, cipher);
        printf("%s\n", cipher);
    }

int main(){
    test();
    return 0;
}