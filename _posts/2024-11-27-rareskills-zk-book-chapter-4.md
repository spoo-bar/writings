---
title: "ZK-Book - Chapter 4 - Elementary Set Theory for Programmers"
date: 2024-11-27T00:00:00+00:00
author: Spoorthi Satheesha
layout: post
permalink: /zk-book-chapter-4-set-theory/
categories: Study
tags: [math, zk]
mathjax: true
excerpt: "Notes and solved exercises for Chapter 4 of ZK-Book - Elementary Set Theory for Programmers"
seo_title: "ZK-Book - Chapter 4 - Elementary Set Theory for Programmers"
seo_description: "Notes and solved exercises for Chapter 4 of ZK-Book - Elementary Set Theory for Programmers"
---

Book Link - [ZK Book](https://www.rareskills.io/zk-book)

Chapter Link - [Chapter-4: Elementary Set Theory for Programmers](https://github.com/RareSkills/zk-book/blob/c4345804a6d9ad1f516952531753293ca5cd586e/content/set-theory/en/set-theory.md)

This post hosts my mathy notes for my studies using the ZK Book by Rareskills.

### Shorthand

$\mathbb{N}$ - Natural numbers

$\mathbb{Z}$ - Real numbers

$\mathbb{Q}$ - Rational numbers

$\mathbb{R}$ - Real numbers 

$\mathbb{C}$ - Complex numbers

$\mathbb{R}^2$ or $a \in \mathbb{R}^2$ - $a$ is a 2D vector 

---

**Set** - Well defined collection of objects

Sets do not contain duplicate elements

**Exercise:** _Assume you have a proper definition for integers. Create a well-defined set of rational numbers._

A rational number is a fraction with a non-zero denominator.

For integers $\mathbb{Z}$,

$$\mathbb{Q} = \{ (a,b) | a \in \mathbb{Z}, b\in \mathbb{Z}, b \neq 0 \}$$

**Exercise:** _Define the subset relationship between integers, rational numbers, real numbers, and complex numbers._

- Integers are a subset of Rational numbers
- Rational numbers are a subset of Real numbers
- Read numbers are a subset of Complex numbers

**Exercise:** _Define the relationship between the set of transcendental numbers and the set of complex numbers in terms of subsets. Is it a proper subset?_

Since transcendental numbers are irrational, they are real. So they are a subset of Complex numbers.

It is a proper subset as every transcendental number is a complex number while every complex number is not a transcendental number.

---

If $A$ is a subset of $B$, $B$ is a subset of $A$, then $A = B$

$A = B \iff A \subseteq B, B \subseteq A$

**Cardinality** - Number of elements in a set

e.g $\{5,8,10\}$ $|A| = 3$

Set of Integers -> Countably infinite
Set of Real numbers -> Uncountably infinite

**Exercise:** _Using the formal definition of equality above, argue that if two finite sets have different cardinality, they cannot be equal. (Demonstrating this for infinite sets is a little trickier, so we skip that)._

Assume 2 sets $A$ and $B$ which are equal.
Therefore, $A \subseteq B, B \subseteq A$

But we know, $|A| \neq |B|$

If $|A| > |B|$, then $A$ has more elements than $B$ and $A \subseteq B$ is false.

If $|A| < |B|$, then $B$ has more elements than $A$ and $B \subseteq A$ is false.

Therefore, $A,B$ cannot be equal.

---

$\{a,b\}$ -> Set

$(a,b)$ -> Ordered Pair

**Cartesian Product** -> Every element from one set is one part of ordered paid with an element from another set.

$A = \{1,2,3\}$ $B = \{x,y,z\}$

**Exercise:** _Compute the Cartesian product of $B×A$ using the definitions above._

$B \times A = \{(x,1),(x,2),(x,3),(y,1),(y,2),(y,3),(z,1),(z,2),(z,3)\}$

**Funtion** - Subset of cartesian product of domain sset and codomain set. aka a mapping between one set to another

**Exercise:** _Define a mapping (function) from integers $\{1,2,3,4,5,6\}$ to the set $\{even,odd\}$._

|   | even       | odd       |
| - | ---------- | --------- |
| 1 |            | $(1,odd)$ |
| 2 | $(2,even)$ | |
| 3 |            | $(3,odd)$ |
| 4 | $(4,even)$ | |
| 5 |            | $(5,odd)$ |
| 6 | $(6,even)$ | |

**Exercise:** _Take the Cartesian product of the polygons $\{\text{triangle}, \text{square}, \text{pentagon}, \text{hexagon}, \text{heptagon}, \text{octagon}\}$ and the set of integers $\{0,1,2,…,8\}$. Define a mapping such that the polygon maps to an integer representing the number of sides. For example, the ordered pair $(\Box, 4)$ should be in the subset, but $(\bigtriangleup, 7)$ should not be in the subset of the Cartesian product._

|          | 0 | 1 | 2 | 3                      | 4                    | 5                      | 6                     | 7                      | 8                     | 
| -------- | - | - | - | ---------------------- | -------------------- | ---------------------- | --------------------- | ---------------------- | --------------------- |
| triangle |   |   |   | $(\text{triangle}, 3)$ |                      |                        |                       |                        |                       |
| square   |   |   |   |                        | $(\text{square}, 4)$ |                        |                       |                        |                       |
| pentagon |   |   |   |                        |                      | $(\text{pentagon}, 5)$ |                       |                        |                       |
| hexagon  |   |   |   |                        |                      |                        | $(\text{hexagon}, 6)$ |                        |                       |
| heptagon |   |   |   |                        |                      |                        |                       | $(\text{heptagon}, 7)$ |                       |
| octagon  |   |   |   |                        |                      |                        |                       |                        | $(\text{octagon}, 8)$ |

**Exercise:** _Define a mapping between positive integers and positive rational numbers (not the whole thing, obviously). It is possible to perfectly map the integers to rational numbers. Hint: draw a table to construct rational numbers where the columns are the numerators and the rows are the denominators. Struggle with this for at least 15 minutes before looking up the answer._

// todo

---

**Relation** - Taking a subset of cartesian product

Element $a$ from $A$ is related to elelent $b$ from $B$ if there is an ordered pair $(a,b)$ in subset of $A \times B$

**Binary operator** - Function from $A \times A \to A$

**Exercise:** _Pick a subset of ordered pairs that defines $a \times b \pmod 3$._

$A = \{0,1,2\}$

| $A \times A$ | 0       | 1       |       2 |
| ------------ | ------- | ------- | ------- |
| 0            | $(0,0)$ | $(0,1)$ | $(0,2)$ |
| 1            | $(1,0)$ | $(1,1)$ | $(1,2)$ |
| 2            | $(2,0)$ | $(2,1)$ | $(2,2)$ |  

| $a \times b \pmod3$ | 0 | 1 | 2 |
| ------- | ----------- | ----------- | ----------- |
| $(0,0)$ | $((0,0),0)$ |             |             |
| $(0,1)$ | $((0,1),0)$ |             |             |
| $(0,2)$ | $((0,2),0)$ |             |             |
| $(1,0)$ | $((2,0),0)$ |             |             |
| $(1,1)$ |             | $((1,1),1)$ |             |
| $(1,2)$ |             |             | $((1,2),2)$ |
| $(2,0)$ | $((2,0),0)$ |             |             |
| $(2,1)$ |             |             | $((2,1),2)$ |
| $(2,2)$ |             | $((2,1),1)$ |             |

**Exercise:** _Define our set $A$ to be the numbers $\set{0,1,2,3,4}$ and our binary operator to be subtraction modulo $5$. Define all the ordered pairs of $A \times A$ in a table, then map that set of ordered pairs to $A$._

$A = \{0,1,2,3,4\}$

| $A \times A$ | 0       | 1       |       2 | 3       | 4       |  
| ------------ | ------- | ------- | ------- | ------- | ------- | 
| 0            | $(0,0)$ | $(0,1)$ | $(0,2)$ | $(0,3)$ | $(0,4)$ | 
| 1            | $(1,0)$ | $(1,1)$ | $(1,2)$ | $(1,3)$ | $(1,4)$ | 
| 2            | $(2,0)$ | $(2,1)$ | $(2,2)$ | $(2,3)$ | $(2,4)$ | 
| 3            | $(3,0)$ | $(3,1)$ | $(3,2)$ | $(3,3)$ | $(3,4)$ | 
| 4            | $(4,0)$ | $(4,1)$ | $(4,2)$ | $(4,3)$ | $(4,4)$ | 

| $a -b \pmod 5 $ | 0           | 1           |       2     | 3           | 4           | 
| --------------- | ----------- | ----------- | ----------- | ----------- | ----------- | 
| $(0,0)$         | $((0,0),0)$ |             |             |             |             |
| $(0,1)$         |             |             |             |             | $((0,1),4)$ |
| $(0,2)$         |             |             |             | $((0,2),3)$ |             |
| $(0,3)$         |             |             | $((0,2),3)$ |             |             |
| $(0,4)$         |             | $((0,4),1)$ |             |             |             |
| $(1,0)$         |             | $((1,0),1)$ |             |             |             |
| $(1,1)$         | $((1,1),0)$ |             |             |             |             |
| $(1,2)$         |             |             |             |             | $((1,2),4)$ |
| $(1,3)$         |             |             |             | $((1,3),3)$ |             |
| $(1,4)$         |             |             | $((1,4),2)$ |             |             |
| $(2,0)$         |             |             | $((2,0),2)$ |             |             |
| $(2,1)$         |             | $((2,1),1)$ |             |             |             |
| $(2,2)$         | $((2,2),0)$ |             |             |             |             |
| $(2,3)$         |             |             |             |             | $((2,3),4)$ |
| $(2,4)$         |             |             |             | $((2,4),3)$ |             |
| $(3,0)$         |             |             |             | $((3,0),3)$ |             |
| $(3,1)$         |             |             | $((3,1),2)$ |             |             |
| $(3,2)$         |             | $((3,2),1)$ |             |             |             |
| $(3,3)$         | $((3,3),0)$ |             |             |             |             |
| $(3,4)$         |             |             |             |             | $((3,4),4)$ |
| $(4,0)$         |             |             |             |             | $((4,0),4)$ |
| $(4,1)$         |             |             |             | $((4,1),3)$ |             |
| $(4,2)$         |             |             | $((4,2),2)$ |             |             |
| $(4,3)$         |             | $((4,3),1)$ |             |             |             |
| $(4,4)$         | $((4,4),0)$ |             |             |             |             |


---

Closed binary operator takes two elements from set, outputs another element from the same set.