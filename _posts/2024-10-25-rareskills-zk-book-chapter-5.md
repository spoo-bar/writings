---
title: "ZK-Book - Chapter 5 - Abstract Algebra"
date: 2024-10-25T00:00:00+00:00
author: Spoorthi Satheesha
layout: post
permalink: /zk-book-chapter-5-abstract-algebra/
categories: Study
tags: [math, zk]
mathjax: true
---

Book Link - [ZK Book](https://www.rareskills.io/zk-book)

Chapter Link - [Chapter-5: Abstract Algebra](https://github.com/RareSkills/zk-book/blob/f27b170f03d38f8674801a75fbc4d7d1782f2344/content/abstract-algebra/en/abstract-algebra.md)

This post hosts my notes for my studies using the ZK Book by Rareskills.

Why did I start with Chapter 5? Cuz I am an idiot who didn't look at the Table of Contents. Thats why.

### TLDR

| Type      | Closed | Associative | Identity | Inverse |
| --------  | ------ | ----------- | -------- | ------- |
| Magma     |   ✔️   |             |          |         | 
| Semigroup |   ✔️   |     ✔️     |          |         |
| Monoid    |   ✔️   |     ✔️     |    ✔️    |         |
| Group     |   ✔️   |     ✔️     |    ✔️    |   ✔️   |

---

**Set** - Well-defined collection of distinct elements  $\mathbb{Z}$

**Binary Operator** - An operation that combines two elements from the set e.g addition

**Closed Set** - Set is closed under an operation if applying that operation to elements within the set always results in an element that’s still within the set

**Magma** - Set with closed binary operator 

**Semigroup** - Magma but also associative 

**Associative** - Grouping of operations doesn’t affect the result e.g $(a∗b)∗c=a∗(b∗c)$

**Exercise:** Work out for yourself that concatenating “foo”, “bar”, “baz” in that order is associative. Remember, associative means $(A \square B) \square C = A \square (B \square C)$, where $\square$ is the Semigroup's binary operator.

$(foo + bar) + baz = foo + (bar + baz)$

$foobar + baz = foo + barbaz$

$foobarbaz = foobarbaz$

**Exercise:** Give an example of a Magma and a Semigroup. The Magma must not be a Semigroup. This means you must think of a binary operator that is closed but not associative for the Magma, and for the Semigroup, the binary operator must be closed and associative.

_Magma_: 
1. Set of strings
2. Operation `TrimStart` such that any instance of the first string from the beginning of the second string is trimmed

e.g

``` 
a = "fun" , b = "function", c = "functions" 

(a TrimStart b) TrimStart c != a TrimStart (b TrimStart c)
("fun" TrimStart "function") TrimStart "functions" != "fun" TrimStart ("function" TrimStart "functions")
"ction" TrimStart "functions" !=  "fun" TrimStart "s"
"functions" != "s"
```

_Semigroup_:
1. All positive integers excluding zero
2. Operation `Addition mod 3`

e.g 

```
a = 2, b = 8, c = 12

(a |+|3 b) |+|3 c  = a |+|3 (b |+|3 c)
(2 |+|3 8) |+|3 12 = 2 |+|3 (8 |+|3 12)
        1  |+|3 12 = 2 |+|3  2
                 1 = 1    
```

---

**Monoid** - Semigroup with identity element

**Identity** - Binary operation with an element = element e.g addition of positive integers with 0

**Union** - $ \\{ 1,2,3\\} \cup \\{2,3,4\\} = \\{1,2,3,4\\}$

where, identity element is empty set $\\{\\}$

**Intersection** - $\\{1,2,3\\} \cap \\{2,3,4\\} = \\{2,3\\}$

where, identity element is the domain of the set itself  $\mathbb{Z}$

**Exercise:** Let our binary operator be the function `min(a,b)` over integers. Is this a Magma, Semigroup, or Monoid? What if we restrict the domain to be positive integers (zero or greater)? What about the binary operator `max(a,b)` over those two domains?

$min(a,b)$ over integers

1. closed -> yes 
2. associative -> yes
3. identity -> no

=> Semigroup

$min(a,b)$ over positive integers and 0

1. closed -> yes
2. associative -> yes
3. identity -> no

=> Semigroup

$max(a,b)$ over integers

1. closed -> yes 
2. associative -> yes
3. identity -> no

=> Semigroup

$max(a,b)$ over positive integers and 0

1. closed -> yes
2. associative -> yes
3. identity -> yes $0$

=> Monoid

**Exercise:** Let our set be all 3 bit binary numbers (a set of cardinality 8). Let our possible binary operators be bit-wise and, bit-wise or, bit-wise xor, bit-wise nor, bit-wise xnor, and bit-wise nand. Clearly this is closed because the output is a 3 bit binary number. For each binary operator, determine if the set under that binary operator is a Magma, Semigroup, or Monoid.

_Bitwise AND_

| A | B | & |
| - | - | - |
| 0 | 0 | 0 |
| 0 | 1 | 0 |
| 1 | 0 | 0 |
| 1 | 1 | 1 |

1. closed -> yes
2. associative -> yes
3. identity -> yes $1$

=> Monoid

_Bitwise OR_

| A | B |\||
| - | - | - |
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 1 |

1. closed -> yes
2. associative -> yes
3. identity -> yes $0$

=> Monoid

_Bitwise XOR_

| A | B | ^ |
| - | - | - |
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 0 |

1. closed -> yes
2. associative -> yes
3. identity -> yes $0$

=> Monoid

_Bitwise NOR_

| A | B |\|~|
| - | - | - |
| 0 | 0 | 1 |
| 0 | 1 | 0 |
| 1 | 0 | 0 |
| 1 | 1 | 0 |

1. closed -> yes
2. associative -> no
```
(1 |~ 1) |~ 0 != 1 |~ (1 |~ 0)
       0 |~ 0 != 1 |~ 0
            1 != 0
```

=> Magma

_Bitwise XNOR_

| A | B |\|^|
| - | - | - |
| 0 | 0 | 1 |
| 0 | 1 | 0 |
| 1 | 0 | 0 |
| 1 | 1 | 1 |

1. closed -> yes
2. associative -> yes
3. identity -> yes $1$

=> Monoid

_Bitwise NAND_

| A | B | &~|
| - | - | - |
| 0 | 0 | 1 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 0 |

1. closed -> yes
2. associative -> no
```
(1 &~ 1) &~ 0 != 1 &~ (1 &~ 0)
       0 &~ 0 != 1 &~ 1
            1 != 0
```

=> Magma

---

**Group** - Monoid where each element has an inverse

**Inverse** - For every element $a$ , there is  $a'$ such that $a \square a' = i$ identity

**Exercise:** Why can’t strings under concatenation be a group?

Set - Strings with empty string

Operation - Concatenation

Identity - Empty string

For a given non empty string, there cannot be any other string, concatenating with which will result in an empty string. Therefore, it cannot have an inverse and its not a group.

**Exercise:** Polynomials under addition satisfy the property of a group. Demonstrate this is the case by showing it matches all the properties that define a group.

---

**Abelien** - Oredering of operations doesnt affect the result e.g $(a∗b)=(b∗a)$