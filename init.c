#include <unistd.h>
#include <stdio.h>
int main() {
    execl("/bin/dash", "dash", NULL);
    return 1;
}