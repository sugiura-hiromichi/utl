#include <stdio.h>

extern int sum_asm(void);
int ary_len = 11;
/*
 this code causes error that says *1. Variable length array declaration not
allowed at file scope [vla_decl_in_file_scope]*

int ary[ary_len] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 0, -1};
*/

int ary[11] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 0, -1};

int main(void) {
	int sum = sum_asm();
	printf("sum = %d\n", sum);
	return 0;
}
