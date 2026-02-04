# Family Relations: Multi-Paradigm Analysis

This project explores the representation and querying of family relations using four distinct programming paradigms: **Logical** (Prolog), **Imperative** (Python), **Functional** (Haskell) and **Relational** (SQL).

## Project Overview

It solves the classic "Family Tree" problem but approaches it as a formal mathematical model. The implementation is structured around three levels of operations on relations:

### 1. Set-Theoretic Operations

* **Union:** Combining groups (e.g., defining `person` from `male` and `female`).
* **Intersection:** Finding commonality (e.g., defining `father` as the intersection of `male` and `parent`).
* **Difference:** Exclusion logic (e.g., defining specific groups by excluding others).
* **Cartesian Product:** Generating all possible combinations of tuples.

### 2. Codd's Relational Algebra

* **Selection:** Horizontal filtering (finding specific individuals).
* **Projection:** Vertical filtering (checking for existence of relationships, e.g., `is_parent`).
* **Join:** Combining relations based on shared attributes (e.g., inferring `grandfather`).

### 3. Operations on Binary Relations & Closures

* **Inversion:** Reversing the direction of a relationship (defining `child` via `parent`).
* **Transitive Closure:** Recursive logic to determine deep ancestry (`ancestor`/`descendant`).
* **Symmetric Closure:** Establishing bidirectional relationships (defining `blood_relative`).
* **Reflexive Closure:** Including the element itself in the set (defining genetic groups/clans).

## Project Structure

The project consists of the following source files:

* **`family.pl`**
    Contains the Knowledge Base (Facts) and Rules. Implements logical inference for family connections, theoretical set operations and optimized recursive definitions for ancestors.

* **`family.py`**
    A Python script using Sets and Dictionaries to model the family tree. Implements algorithms for finding relatives via explicit iteration and Depth-First Search (DFS).

* **`family.hs`**
    A Haskell module demonstrating the functional approach. Uses `List Comprehensions` to mimic mathematical set notation and recursive functions for determining closures.

* **`family.sql`**
    Contains the DDL (Schema creation), DML (Data insertion) and complex queries. Features standard `JOIN` operations for Codd's Algebra and `RECURSIVE CTEs` for ancestor traversal.

## References and Sources

* [Lifencev's repo](https://github.com/Lifencev/Family-relationships)
* [video from SunSay, Сенсей, Sensei channel (34m)](https://www.youtube.com/watch?v=-9CyZnb_pNY)
* [video from SunSay, Сенсей, Sensei channel (7m)](https://www.youtube.com/watch?v=OQn-jj72wbY)
* [video from SunSay, Сенсей, Sensei channel (16m)](https://www.youtube.com/watch?v=r1CVJbr5GDg)
