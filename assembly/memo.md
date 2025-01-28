# compiler option

```sh
clang -fno-pic -fomit-frame-pointer
```

```sh
rustc -C relocation-model=static -C force-frame-pointer=no --emit=asm
```

# representation of operation with register

r1 <- 0x7a(insert 0x7a to register r1)
r1 <- r2(insert value of r2 to register r1)
r1 <- \[0x1234\](insert value contained at address of 0x1234 in memory to register r1)
r1 <- \[r2\](insert value contained at address which contained in r2 to register r1)
\[0x1234\] <- r1(insert value of r1 to memory with address 0x1234)
\[r2\] <- r1(insert value of r1 to memory with address which contained in r1)

r1 <- \<op\>c(calculate r1 op c and insert its result to r1)

# push instruction

`push %x0` is equal to

```
ps <- <-> 4
[ps] <- x0
```

`pop %x0` is equal to

```
x0 <- [ps]
ps <- <+> 4
```
