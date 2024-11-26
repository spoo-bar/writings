---
title: "ZK-Book - Chapter 3 - Finite Fields and Modular Arithmetic for ZK Proofs"
date: 2024-11-26T00:00:00+00:00
author: Spoorthi Satheesha
layout: post
permalink: /zk-book-chapter-3-finite-fields/
categories: Study
tags: [math, zk]
mathjax: true
excerpt: "Notes and solved excercises for Chapter 3 of ZK-Book - Finite Fields and Modular Arithmetic for ZK Proofs"
seo_title: "ZK-Book - Chapter 3 - Finite Fields and Modular Arithmetic for ZK Proofs"
seo_description: "Notes and solved excercises for Chapter 3 of ZK-Book - Finite Fields and Modular Arithmetic for ZK Proofs"
---

Book Link - [ZK Book](https://www.rareskills.io/zk-book)

Chapter Link - [Chapter-3: Finite Fields and Modular Arithmetic for ZK Proofs](https://github.com/RareSkills/zk-book/blob/f27b170f03d38f8674801a75fbc4d7d1782f2344/content/finite-fields/en/finite-fields.md)

This post hosts my mathy notes for my studies using the ZK Book by Rareskills.

The code-y nodes for this chapter can be found here: [3-FiniteFields.ipynb](https://github.com/spoo-bar/zkbook/blob/main/3-FiniteFields.ipynb)

---

Mathematical Notation of addition over finite field 

$$
c = a + b \pmod p
$$

where,
- a,b are numbers in the field
- p is a prime number (for our case at least) aka characterisitc of the field
- c is the remainder that maps to the field

**Element** - Number in a finite field

**Order** - Number of elements in a field

---

Additive Identity - Any number $+ p$ results in same element

Additive Inverse - $p - a$ where a is an element

e.g 14 mod 23 => Additive inverse = 23 - 14 = 9

14 + 9 (mod 23) = 0

Every element in a field has one additive inverse

Zero is its own additive inverse

Elements in first half of the field are inverses of second half

**Exercise:** _Let’s say we pick a $p≥3$. Which, if any, non-zero values are their own additive inverse?_

For $p = 4$ with elements $\\{0,1,2,3\\}$, 2 is its own inverse

2 + 2 mod 4 = 4 mod 4 = 0

---

Multiplicative Identity - Any number $* p$ results in same element

Multiplicative Inverse - $ab = 1$

0 has no multiplicative inverse

1 is its own multiplicative inverse

Every element as exactly one multiplicative inverse

$p-1$ is its own inverse

if p = 23, 1 and 22 are their own inverses.

because $-1 * -1 = 1$

$(p-1)(p-1) = 1$

Therefore, $p-1$ is congruent to -1.

For given arithematic circuit

$$
x * x === 1 \\
x + 1 === 0
$$

For regular numebrs, x = -1

In a finite field, x = -1 or x = $p-1$

---

### Fermat's Little Theorem

$$
a^{p} = a\pmod p, a \neq 0
$$

e.g $3⁵ \pmod 5 = 3$

$$
a^p=a \\
\frac{a^p}{a}=\frac{a}{a} \\
a^{p-1}=1 \\
a.a^{p-2}=1 \\
$$

Therefore, for $a$, multiplicative inverse is $a^{p-2}$

e.g p = 7, $a^{7-2}=5 \pmod 7$

This is used in Ethereum due to `expmod` precompile. But not ideal for other situations as we are raising numbers to large powers.

To calculate multiplicaitve inverse in python

```py
pow(a, -1, p) # -1 is the exponent
```

**Exercise:** _Find the multiplicative inverse of 3 modulo 5. There are only 5 possibilities, so try all of them and see which ones work._

$$
\\{0,1,2,3,4\\} \\
3 \times 0 \pmod 5 = 0  ❌ \\
3 \times 1 \pmod 5 = 3 ❌ \\
3 \times 2 \pmod 5 = 6 \pmod 5 = 1 ✅\\
3 \times 3 \pmod 5 = 9 \pmod 5 = 4 ❌\\
3 \times 4 \pmod 5 = 12 \pmod 5 = 2 ❌\\
$$

**Exercise:** _What is the multiplicative inverse of 50 in the finite field $p=51$? You do not need Python to compute this, see the principles described in “General rules of multiplicative inverses.”_

Since we need to find the multiplicative inverse of 50, which is $p-1$, we know that it is its own multiplicative inverse.

$$
50 \times 50 \pmod{51} \\
2500 \pmod {51} \\
1
$$

**Exercise:** _Use Python to compute the multiplicative inverse of 288 in the finite field of p = 311. You can check your work by validating that (288 * answer) % 311 == 1._

```python
p = 311
mi = pow(288, -1, p)
assert (288 * mi) % p == 1
```

---

To compute fraction in a finite field, numerator times multiplicative invserse of denominator

$$\frac{5}{6} = 5 \times \frac{1}{6} = 5 \times mul\_inv(6)$$

Finite field division does not suffer from precision loss

e.g

$$
x + y + z === 1  \\
x === y \\
y === z
$$

In regular numebrs, x = y = z would be 0.333

For p = 11, 
`x = pow(3, -1, 11)`

$$
x = y = z= 4 \\
(x + y + z) \pmod {11} = 1
$$

Finite field elements are not Odd or Even as any element can be divided by 2 with no remainder.

Finite fields are sometimes called Galois fields.

No two elements can be multiplied together to get 0 in finite fields unless one of them is 0. This property is preserved from regular math.

Finite field operations are also associative, commutative and distributive.

Elements in finite field doo not need to be perfect squares to have a square root.

$$
5 \times 5 \pmod {11} = 3 \\
\sqrt{3} = 5
$$

In the finite field modulo 11, the following elements have square roots:

| Element | 1st Square Root | 2nd Square Root |
| --- | --- | --- |
| 0 | 0 | n/a |
| 1 | 1 | 10 |
| 3 | 5 | 6 |
| 4 | 2 | 9 |
| 5 | 4 | 7 |
| 9 | 3 | 8 |

**Exercise**: _Verify the claimed square roots in the table are correct in the finite field modulo 11._

Case $\sqrt1$:

Root 1: $1 \times 1 \pmod{11} = 1$

Root 2: $10 \times 10 \pmod{11} = 100 \pmod{11} = 1$

Case $\sqrt3$:

Root 1: $5 \times 5 \pmod{11} = 25 \pmod{11} = 3$

Root 2: $6 \times 6 \pmod{11} = 36 \pmod{11} = 3$


Case $\sqrt4$:

Root 1: $2 \times 2 \pmod{11} = 4$

Root 2: $9 \times 9 \pmod{11} = 81 \pmod{11} = 4$


Case $\sqrt5$:

Root 1: $4 \times 4 \pmod{11} = 16 \pmod{11} = 5$

Root 2: $7 \times 7 \pmod{11} = 49 \pmod{11} = 5$


Case $\sqrt9$:

Root 1: $3 \times 3 \pmod{11} = 9$

Root 2: $8 \times 8 \pmod{11} = 64 \pmod{11} = 9$

First square root is always the additive inverse of the second square root

```python
# Computing modular square root
def mod_sqrt(x, p):
	assert (p - 3) % 4 == 0, "prime not 4k + 3"
	exponent = (p + 1) // 4
	return pow(x, exponent, p) # x ^ e % p
```
**Exercise:** _Use the code snippet above to compute the modular square root of 5 in the finite field of p = 23. The code will only give you one of the answers. How can you compute the other?_

```python
p = 23
x = 5
sqrt1 = mod_sqrt(x, p)
sqrt2 = p - sqrt1 # as the two roots are additive inverses of each other
print(sqrt1, sqrt2)
# [8, 15]
```
---

Linear system of equations -> A collection of straight line equations with unknown variables which need to be solved for.

Linear systems of equations can have
1. No solution. (parallel lines)
2. One solution (lines intersect)
3. $p$ many solutions. As many as order of field. (lines overlap)

**Exercise:** 
$$
x + 2y=1\\
7x+3y=2
$$
_Write code to bruteforce every combination of (x, y) over x = 0..10, y = 0..10 to verify the above system has no solution over the finite field of p = 11._

```python
import galois
GF11 = galois.GF(11)

for x in range(11):
    for j in range(11):
        expectOne =  GF11(x) + (2 * GF11(j))
        expectTwo =  (7 * GF11(x)) + (3 * GF11(j))
        if expectOne == 1 and expectTwo == 2:
            print(x, j) # found solution. but this should never hit as there is no solution
```

**Exercise:**
$$
x + 2y=1\\
4x+8y=1
$$
_Convert the two equations to their finite field representation and see they are the same._

$$
y = \frac{3-x}{2} = \frac{3}{2} - \frac{x}{2} \\
y = \frac{1-4x}{8} = \frac{1}{8} - \frac{4x}{8} = \frac{1}{8} - \frac{x}{2}
$$

From both the equations, the slope is $\frac12$ or multiplicative inverses of $2$.



## Exercises

In the problems below, use a finite field `p` of `21888242871839275222246405745257275088548364400416034343698204186575808495617`. Beware that the `galois` library takes a while to initialize a GF object, `galois.GF(p)`, of this size.

### Question 1

_A dev creates an arithmetic circuit `x * y * z === 0` and `x + y + z === 0` with the intent of constraining all the signals to be zero. Find a counter example to this where the constraints are satisfied, but not all of x, y, and z are 0._

Absolute bruteforce code. Do not run. Will take ages.

```python
import galois
p = 21888242871839275222246405745257275088548364400416034343698204186575808495617
GFBig = galois.GF(p)

for x in range(p):
    for y in range(p):
        for z in range(p):
            if GFBig(x) + GFBig(y) + GFBig(z) == 0 and GFBig(x) * GFBig(y) * GFBig(z) == 0: # circuit is satisfied
                if not(x == 0 and y == 0 and z == 0): # not the solution where all are 0
                    print(x, y, z)
                    break
        else:
            continue
        break
    else:
        continue
    break     
# 0 1 21888242871839275222246405745257275088548364400416034343698204186575808495616   
```

Counter example: 1,0,p-1

### Question 2
_A dev creates a circuit with the polynomial `x² + 2x + 3 === 11` and proves that 2 is a solution. What is the other solution? Hint: write the circuit as `x² + 2x - 8 === 0` then factor the polynomial by hand to find the roots. Finally, compute the congruent element of the roots in the finite field to find the other solution._

Finding the roots using the quadratic formula

$$
x^2 + 2x - 8 = 0 \\
a = 1 \\
b = 2 \\
c = -8 \\
$$

$$
roots = \frac{-b \pm \sqrt{b^2 -4ac}}{2a}
$$
$$
= \frac{-2 \pm \sqrt{2^2 -4 \cdot 1 \cdot -8}}{2 \cdot 1} \\
$$
$$
= \frac{-2 \pm \sqrt{4 + 32}}{2} = \frac{-2 \pm \sqrt{36}}{2} = \frac{-2 \pm 6}{2}
$$

Root 1 = $\frac{-2+6}{2} = \frac{4}{2} = 2$

Root 2 = $\frac{-2-6}{2} = \frac{-8}{2} = -4$

```python
import galois
GFBig = galois.GF(21888242871839275222246405745257275088548364400416034343698204186575808495617)
 
# using quadratic formula we know that the roots of the polynomial are 2 and -4
root1 = GFBig(2)
root2 = -GFBig(4) # This will calculate the congruent of -4
poly = galois.Poly([1,2,-8], GFBig)

assert poly(root1) == 0 # Ensuring that the roots satisfy the polynomial
assert poly(root2) == 0 # Ensuring that the roots satisfy the polynomial
```
Roots: 2, 21888242871839275222246405745257275088548364400416034343698204186575808495613