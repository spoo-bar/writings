---
title: "ZK-Book - Chapter 1 - P vs NP and its application to zero knowledge proofs"
date: 2024-11-03T00:00:00+00:00
author: Spoorthi Satheesha
layout: post
permalink: /zk-book-chapter-1-p-vs-np/
categories: Study
tags: [math, zk]
mathjax: true
excerpt: "Notes for Chapter 1 of ZK-Book - P vs NP and its application to zero knowledge proofs"
seo_title: "ZK-Book - Chapter 1 - P vs NP and its application to zero knowledge proofs"
seo_description: "Notes for Chapter 1 of ZK-Book - P vs NP and its application to zero knowledge proofs"
---

Book Link - [ZK Book](https://www.rareskills.io/zk-book)

Chapter Link - [Chapter-1: P vs NP and its application to zero knowledge proofs](https://github.com/RareSkills/zk-book/blob/f27b170f03d38f8674801a75fbc4d7d1782f2344/content/p-vs-np/en/p-vs-np.md)

This post hosts my notes for my studies using the ZK Book by Rareskills.


### TLDR

| Category  | Compute Time | Verify Time | Memory Size |
| --------  | ------------ | ----------- | ----------- |
| P         | Polynomial   | Polynomial  | Polynomial  |
| NP        | Exponential  | Polynomial  | Polynomial  |
| PSPACE    | Exponential  | Exponential | Polynomial  |
| EXPSPACE  | Exponential  | Exponential | Exponential |

---

If we can quickly verify a solution to a problem is correct, can we also quickly compute the solution?

$O(n^c)$ 
where,
$n$ is size of input
$c$ is non-negative constant

Polynomial time complexity = efficient

Exponential time or expensive => $O(c^n)$ where, $c$ is constant > 1

Problems in P are:
1. Easy to solve
2. Easy to verify

e.g Sorting

**Witness** - Proof that you solved problem correctly

e.g Sorted List

**Pspace** - Problems require exponential resources to solve and verify. exponential time but not exponential memory.

Not all problems in pspace have solutions that can be efficient to verify

e.g if regexes are the same

**NP** - Some problems can be quirkly verified but not quickly computed. Stands for Non deterministic polynomial.

e.g Solution to sudoku

if p = np => we can find efficient method for verifying solution, we can also find efficient method for finding the solution.

if p = np => RIP cryptography RIP blockchains

---

Boolean NOT $¬$

Boolean AND $∧$

Boolean OR $∨$

All problems in P and NP can be verified by transforming them to boolean formula and showing solution to the formula.

Boolean formula => Boolean **circuit**