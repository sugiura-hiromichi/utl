[1]
tissue box

[2]
0x56, 0x78, 0x9a,

| stack |
| :---: |
| 0x9a  |
| 0x78  |
| 0x56  |

[3]
It's possible because general purpose register can act as stack pointer

[4]
It's possible because stack only needs memory area

[5]
sp <- <+> 4
[sp] <- r1
r1 <- r2
r2 <- [sp]

[6]
[AArch64](https://github.com/ARM-software/abi-aa/blob/2982a9f3b512a5bfdc9e3fea5d3b298f9165c36b/pauthabielf64/pauthabielf64.rst)

[7]
assume that pointer to function, parameters, return value are all stacked.
In this senario, each function call requires

1. pointer to function (size: 64bits)
2. 1 parameter with type int of C (32bits)
3. return value with type int of C (32bits)

thus, each function call requires 192bits (= 24bytes)

count of recursion of fact(n) is (n-1).
For above reasons, fact(n) requires 24*(n-1) bytes

[8]
we can check max size of stack by using `ulimit` command (on macOS and Linux)
`ulimit -s` prints max size of stack in KiB unit
on my env,

```sh
ulimit -s
8192
```

8MiB
