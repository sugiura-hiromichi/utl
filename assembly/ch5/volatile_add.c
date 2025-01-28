volatile int i, j;

int main(void) {
	i = 666;
	i = i + 1;
	j = 777;
	j = j - i;
	j = j % 10;
	return j;
}
