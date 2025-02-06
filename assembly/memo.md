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

# syntax of indirect memory reference

## AT&T syntax

`displacement` (`base register`, `index register`, `scale`)

this means that

`base register` + `index register` * `scale` + `displacement`

## intel syntax

`[base_register + index_register * scale + displacement]`

# general purpose register in x86 (IA-32)

| 31 ~ 16 | 15 ~ 8 | 7 ~ 0 | lower 16 bits | entire 32 bits |
| :-----: | :----: | :---: | :-----------: | :------------: |
|         |   ah   |  al   |      ax       |      eax       |
|         |   bh   |  bl   |      bx       |      ebx       |
|         |   ch   |  cl   |      cx       |      ecx       |
|         |   dh   |  dl   |      dx       |      edx       |
|         |        |       |      bp       |      esi       |
|         |        |       |      si       |      edi       |
|         |        |       |      di       |      ebp       |
|         |        |       |      sp       |      esp       |

# armv8-a

## GASの再配置指定子(relocation specifier)

表中の`X[n:m]`は64bit値Xのmビット目からnビット目を意味する

| 演算子   | 値        | 値の確認 |
| :------- | :-------- | :------- |
| :abs_g0: | `X[15:0]` |          |

## address指定モード

armv8-aのassemblyにおけるアドレスの記述方法

### メモリロケーション

レジスタが角括弧で囲われている

```asm
ldr	w2,	[x1]
```

### ベースレジスタとオフセット

```asm
ldr	w2,	[x1, 4] // レジスタw2に、x1の値+4のアドレスに格納されている値を読み込む
```

### プリ・インデックス

末尾に!が付くと、プリインデックスといって、[]内の計算を初めに行う

```asm
ldr	x30,	[sp, 16]	// x30 <- [sp + 16]
ldr	x30,	[sp, 16]!	// sp <- <-> 16, x30 <- [sp]
```

### ポスト・インデックス

[] の後に即値がある

```asm
ldr	x30, [sp], 16 // x30 ← [sp], sp ← <+> 16
```

## str命令

Store Register命令。第一オペランドに指定されたレジスタの値を第2オペランドで指定されたアドレスに格納する

```asm
str	w2,	[x1, w0, sxtw 2] // [x1 + (w0 << 2)] ← w2
```

## mov命令

レジスタからレジスタに値を転送したり、レジスタに即値を読み込むための命令
mov命令はオペランドにメモリロケーションを取れない
その時はldr命令を使おう

## adrp命令

```asm
adrp	x0,	.LANCHOR0 // x0 ← .LANCHOR0のページアドレス
add	x1,	x0,	:lo12:.LANCHOR0
```

---

# Latex

$\sqrt{3x-1}+(1+x)^2$

$\sum \epsilon \subset \beta$

$$
f(x,y) = x + \sqrt{y}
f(x,y) = \sqrt{y} + \frac{x^2}{4y}
$$
