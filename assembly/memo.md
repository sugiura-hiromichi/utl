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

## 主要フラグ

armv8-aでは、フラグレジスタは単一のものではない
複数の、特定用途向けのレジスタが存在する
フラグレジスタを含めた、状態を表す情報の集まりを **PSTATE** (Process STATE)と呼ぶ

| フラグ | 名称                 | 動作                                                     |
| :----: | :------------------- | :------------------------------------------------------- |
|   N    | ネガティブフラグ     | 演算結果が符号付き整数として負であれば1、そうでなければ0 |
|   Z    | ゼロフラグ           | 演算結果が0であれば1、そうでなければ0                    |
|   C    | キャリーフラグ       | 演算結果にキャリーがあれば1、なければ0                   |
|   V    | オーバーフローフラグ | 演算結果がオーバーフローすれば1、そうでなければ0         |

## GASの再配置指定子(relocation specifier)

表中の`X[n:m]`は64bit値Xのmビット目からnビット目を意味する

| 演算子       | 値                                                   | 値の確認      |
| :----------- | :--------------------------------------------------- | :------------ |
| :abs_g0:     | `X[15:0]`                                            | 0 <= X < 2^16 |
| :abs_g1:     | `X[15:0]`                                            | なし          |
| :abs_g0_nc:  | `X[31:16]`                                           | 0 <= X < 2^32 |
| :abs_g1_nc:  | `X[31:16]`                                           | なし          |
| :abs_g2:     | `X[47:32]`                                           | 0 <= X < 2^48 |
| :abs_g2_nc:  | `X[47:32]`                                           | なし          |
| :abs_g3:     | `X[63:48]`                                           | なし          |
| :pg_hi21:    | `X[31:12]`                                           | \|X\| <= 2^32 |
| :pg_hi21_nc: | `X[31:12]`                                           | なし          |
| :lo12:       | `X[11:0]`,`X[11:1]`,`X[11:2]`,`X[11:3]` (命令による) | なし          |

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

## LDP命令とSTP命令

Load Pair of Registers命令とStore Pair of Registers命令
2つのレジスタの値を連続して書き込んだり読み込んだりできる

```asm
stp	x19,	x20,	[sp,	-16]!	// push x20, push x19
ldp	x19,	x20,	[sp], 16		// pop x19, pop x20
```

## ADD命令

ADD命令のオペランドにはメモリロケーションを指定できない
また、ADD命令を実行してN Z C Vフラグは変化しない

フラグの変更を伴いたい場合はADDS(ADD, Setting flags)命令を使おう

```asm
add	w2, w2, 1 // w2 ← <+> 1
add	w20, w20, w19 // w20 ← w20 + w19
add	x0, x0, :lo12:.LC0 // x0 ← x0 + .LC0 & 0x0fff
```

## CMP命令

CMP命令はSUBS命令のアライアスとなっている
例えば

```asm
cmp	x0, x7 // x0 == x7 ?
subs	xzr, x0, x7 // xzr ← x0 - x7
```

この各二行は同じ機械語を生成する

# B命令

BranchのB
B命令は無条件の相対ジャンプ命令。オペランドには即値のみ指定できる。現在のプログラムカウンタから128Mいないのオフセットにジャンプする

[!note]
armv8-aでは全ての命令語は32ビットだった。この為それぞれの機械語の命令が格納されているメモリのアドレスは必ず4の倍数になる
