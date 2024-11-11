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

## Exercises:

### Question 1 

Create an arithmetic circuit that takes signals x₁, x₂, …, xₙ and is satisfied if at least one signal is 0.

Because anything multiplied by 0, is 0

$$
x_1x_2 === 0
$$

Repeat this circuit for each sequential pair in the list

### Question 2

Create an arithmetic circuit that takes signals x₁, x₂, …, xₙ and is satsified if all signals are 1.

Because 1 multiplied by itself is 1,

$$
x_1x_2 === 1
$$

Repeat this circuit for each sequential pair in the list

### Question 3

A bipartite graph is a graph that can be colored with two colors such that no two neighboring nodes share the same color. Devise an arithmetic circuit scheme to show you have a valid witness of a 2-coloring of a graph. Hint: the scheme in this tutorial needs to be adjusted before it will work with a 2-coloring.

Consider the two colors to be 0, 1

Ensuring the node color is 0 or 1

$$
x(x-1) === 0 \\
y(y-1) === 0
$$

Ensuring $x$ and $y$ are not the same

| x | y | We want |
| - | - | ------- |
| 0 | 0 |    0    |
| 0 | 1 |    1    |
| 1 | 0 |    1    |
| 1 | 1 |    0    |
 
Therefore, we want XOR 
$$
1 === (x ∨ y) ∧ ¬(x ∧ y) \\
1 === (x ∨ y) ∧ ¬(xy) \\
1 === (x ∨ y) ∧ (1 - xy) \\
1 === (x ∨ y)(1 - xy) \\
1 === (x + y - xy)(1 - xy) \\
1 === x(1 - xy) + y(1 - xy) -xy(1 - xy) \\
1 === x - x^2y + y -xy^2 -xy +x^2y^2 \\
1 === x^2y^2 - x^2y - xy^2 -xy + x + y
$$

### Question 4

Create an arithmetic circuit that constrains k to be the maximum of x, y, or z. That is, k should be equal to x if x is the maximum value, and same for y and z.

Note: There might be better ways to solve this, but here we go

Assuming x,y,z are 3 bit numbers. Therefore, $n=4$

Converting x,y,z to binary.

$$
2^2a_2 + 2^1a_1 + a_0 === x \\
2^2b_2 + 2^1b_1 + b_0 === y \\
2^2c_2 + 2^1c_1 + c_0 === z \\
$$

Ensuring that $a_i$, $b_i$ and $c_i$ are binary

$$
a_0(a_0 - 1 ) === 0 \\
... \\
b_0(b_0 - 1 ) === 0 \\
... \\
c_0(c_0 - 1 ) === 0 \\
$$

We know that,

if x >= y, $2^{n-1} + (x-y)$

if y >= z, $2^{n-1} + (y-z)$

if z >= x, $2^{n-1} + (z-x)$

$$
2^3 + (x - y) === 8d_3 + 4d_2 + 2d_1 + d_0 \\
2^3 + (y - z) === 8e_3 + 4e_2 + 2e_1 + e_0 \\
2^3 + (z - x) === 8f_3 + 4f_2 + 2f_1 + f_0 \\
$$

Such that $d_i$, $e_i$ and $f_i$ are binary

$$
d_0(d_0 - 1 ) === 0 \\
... \\
e_0(e_0 - 1 ) === 0 \\
... \\
f_0(f_0 - 1 ) === 0 \\
$$

if x >= y, $d_3$ will be 1

if y >= z, $e_3$ will be 1 

if z >= x, $f_3$ will be 1

if x >= y and y >= z, then x is max, $d_3 ∧ e_3 = 1$
$$
g === d_3e_3
$$

if y >= z and z >= x, then y is max, $e_3 ∧ f_3 = 1$
$$
h === e_3f_3
$$

if z >= x and x >= y, then z is max, $f_3 ∧ d_3 = 1$
$$
i === f_3d_3
$$

Constraint of $k$ is that, $k$ is

1. x if x is max,
2. y if y is max,
3. z if z is max

As Arithematic Circuit,

$$
k === gx ∨ hy ∨ iz \\
k === (gx + hy - gxhy) ∨iz \\
k === gx + hy - gxhy + iz - (gx + hy - gxhy)iz \\
k === gx + hy - gxhy + iz - gxiz - hyiz + gxhyiz \\
k === gx + hy + iz - gxhy - hyiz - gxiz + gxhyiz \\
$$

### Question 5 

Create an arithmetic circuit that takes signals x₁, x₂, …, xₙ, constrains them to be binary, and outputs 1 if at least one of the signals is 1. Hint: this is tricker than it looks. Consider combining what you learned in the first two problems and using the NOT gate.

(Ignoring the hint)
Ensuring that the signals are binary

$$
x_1(x_1 - 1) === 0 \\
x_2(x_2 - 1) === 0 \\
$$

| $x_1$ | $x_2$ | We want |
| ----- | ----- | ------- |
|   0   |   0   |    0    |
|   0   |   1   |    1    |
|   1   |   0   |    1    |
|   1   |   1   |    1    |

Therefore, we want the OR gate

$$
1 === x_1 + x_2 - x_1x_2
$$

Repeat this circuit for each sequential pair in the list.

Looking at the hint, is this tricky? idts but did I understand the question wrong then?
And why would I use NOT gate? when OR gate solves it exactly 🤔

### Question 6

Create an arithmetic circuit to determine if a signal v is a power of two (1, 2, 4, 8, etc). Hint: create an arithmetic circuit that constrains another set of signals to encode the binary representation of v, then place additional restrictions on those signals.

$$
2^0 = 1 = 1 \\
2^1 = 2 = 10 \\
2^2 = 4 = 100 \\
2^3 = 8 = 1000 \\
$$

Assuming $v$ is a 3 bit number, n = 4

$$
2^3v_3 + 2^2v_2 + 2^1v_1 + 2^0v_0 === v
$$

Ensuring that $v_i$ are binary

$$
v_3(v_3 - 1) === 0 \\
v_2(v_2 - 1) === 0 \\
v_1(v_1 - 1) === 0 \\
v_0(v_0 - 1) === 0 \\
$$

If $v$ is $2^n$ then in binary only one bit will be $1$ and all else will be $0$

$$
s === v_3 + v_2 + v_1 + v_0 \\
s === 1
$$
