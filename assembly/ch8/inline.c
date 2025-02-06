#include <stdio.h>

int main() {
	int i = 0;
	asm("add %w0, %w0, #2525" : "=r"(i) : "0"(i));
	printf("i = %d\n", i);
	return 0;
}
