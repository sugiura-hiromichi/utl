int fact(int n) {
	if (n == 1) {
		return 1;
	} else {
		return n + fact(n - 1);
	}
}

int main() {
	int f = fact(15);
	return f;
}
