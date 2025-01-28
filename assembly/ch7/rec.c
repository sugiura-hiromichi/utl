int fib(int n) {
	if (n < 3) {
		return 1;
	} else {
		return fib(n - 1) + fib(n - 2);
	}
}

int main() {
	int six = fib(6);
	return six;
}
