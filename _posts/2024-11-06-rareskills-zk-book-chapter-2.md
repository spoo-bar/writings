---
title: "ZK-Book - Chapter 2 - Arithmetic Circuits for ZK"
date: 2024-11-06T00:00:00+00:00
author: Spoorthi Satheesha
layout: post
permalink: /zk-book-chapter-2-arithematic-circuits/
categories: Study
tags: [math, zk]
mathjax: true
---

Book Link - [ZK Book](https://www.rareskills.io/zk-book)

Chapter Link - [Chapter-2: Arithmetic Circuits for ZK](https://github.com/RareSkills/zk-book/blob/f27b170f03d38f8674801a75fbc4d7d1782f2344/content/arithmetic-circuit/en/arithmetic-circuit.md)

This post hosts my notes for my studies using the ZK Book by Rareskills.


---

Boolean Circuits are verbose => So we use Arithematic Circuits.

**Arithematic Circuits** - Sysem of equations using only addition, multiplication and equality. 

Checks that the proposed set of inputs are valid but does not compute solution.

Arithematic Circuit is satisfied if there is an assignment to the variable such that all the equations hold true.

**Signals** - Variables in an Arithematic Circuit. Because thats the terminology used by Circom.

**Equality** - Two segnals hold equal values $===$

$$
x_1(x_1-1) === 0 \\
(x_1x_2) === x_1 \\
$$
Valid witnesses:
$$
(x_1,x_2) = (1,1) \\
(x_1,x_2) = (0,2) \\
(x_1,x_2) = (0,anything)
$$      

|           | Boolean Circuit     | Arithematic Circuit         | 
| --------- |-------------------- | --------------------------- |
| Inputs    | Var are 0 or 1      | Signals may be any numbers  |
| Operation | AND, OR, NOT        | Addition and Multiplication |
| Output    | Satisfied when true | Satisfied when LHS = RHS    | 
| Witness   | Assignment to the Boolean variables that satisfies the Boolean circuit | Assignment to the signals that satisfies all the equality constraints

### Arithematic Circuit for 3 color map of Australia 

Where blue = 1, red = 2, green = 3:

$0===(1-x)*(2-x)*(3-x)$
ensures that a region has only one color

$0===(2-xy)*(3-xy)*(6-xy)$
ensures two neighbouring regions have different colors

### Trivia

1. For number $n$ compute $2^n$, we get $n+1$ bit number where MSB is $1$ and rest are $0$. e.g n = 3, $2^3$ = 1000
2. $2^n - 1$ is $n$ bit number, where all are 1. e.g n = 3, $2^n - 1 = 2^3 - 1 = 1000 - 1 = 111$ 
3. For $n$ bit number, $2^{n-1}$ is midpoint where MSB is $1$ and rest are $0$. e.g n = 3, $2^{3-1} = 2^2 = 100$
4. For $n$ bit number, $2^{n-1}$ is smallest number with 1 in MSB. Therefore, we can sheck MSB to know if a number is $>=2{n-1}$ or $<2{n-1}$


If in $midpoint + (u-v)$, MSB = 0, then $u < v$.

If in $midpoint + (u-v)$, MSB = 1, then $u >= v$.

For $n$ bits, $u$ and $v$ need to be $n-1$ bits to prevent underflow and overflow

### Arithematic Circuit for comparing two numbers

For n = 4,

Ensuring $u$ and $v$ are 3 bits
$$
2^2a_2 + 2^1a_1 + a_0 === u \\
2^2b_2 + 2^1b_1 + b_0 === v
$$

Ensuring $a_i$ and $b_i$ are binary
$$
a_0(a_0 - 1) === 0 \\
a_1(a_1 - 1) === 0 \\
a_2(a_2 - 1) === 0 \\
b_0(b_0 - 1) === 0 \\
b_1(b_1 - 1) === 0 \\
b_2(b_2 - 1) === 0 \\
$$

$2^{n-1} + (u - v)$ as binary representation
$$
2^3 + (u - v) === 8 c_3 + 4 c_2 + 2 c_1 + c_0
$$

Ensuring $c_i$ is binary
$$
c_0(c_0 - 1) === 0 \\
c_1(c_1 - 1) === 0 \\
c_2(c_2 - 1) === 0 \\
$$

Ensuring MSB is $1$, implying that $u$ is greater than or equal to $v$
$$
c_3 === 1
$$

Above arithematic circuit compares 2 numbers, for sorting verification, all will need to be checked.

---

### To convert Arithematic Circuit to Boolean Circuit

AND => $t === uv$
OR => $t === u + v - uv$
NOT => $t === 1 - u$

e.g $out = (x ∧ ¬ y) ∨ z$

1. Make all vars binary
$$
x(x-1)===0 \\
y(y-1)===0 \\
z(z-1)===0
$$

Alternatively,
$$
x^2 === 0 \\
y^2 === 0 \\
z^2 === 0
$$

Therefore,
$$
(x ∧ ¬ y) ∨ z = x(1-y) + z - x(1-y)z \\
= x-xy+z-xz+xyz
$$

--- 

Exercises:

Well its my birthday today and I ended up getting drunk, so tomorrow I guess.
Also visit [Encanto](https://www.encantojoseavillez.pt/en/) in Lisbon. Such good food, such good wine.