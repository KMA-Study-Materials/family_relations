CREATE TABLE Person (
    name VARCHAR(50) PRIMARY KEY,
    gender VARCHAR(10) CHECK (gender IN ('male', 'female'))
);

CREATE TABLE ParentChild (
    parent VARCHAR(50),
    child VARCHAR(50),
    PRIMARY KEY (parent, child),
    FOREIGN KEY (parent) REFERENCES Person(name),
    FOREIGN KEY (child) REFERENCES Person(name)
);

INSERT INTO Person (name, gender) VALUES 
('jane', 'female'), ('anna', 'female'), ('mary', 'female'), ('catlyn', 'female'), ('sarah', 'female'),
('john', 'male'), ('jim', 'male'), ('peter', 'male'), ('alex', 'male'), ('tom', 'male'), ('micky', 'male');

INSERT INTO ParentChild (parent, child) VALUES 
('john', 'jim'), ('jane', 'jim'), ('jim', 'anna'), ('jim', 'tom'), 
('anna', 'peter'), ('tom', 'mary'), ('tom', 'alex');



-- Union
SELECT name FROM Person WHERE gender = 'female'
UNION
SELECT name FROM Person WHERE gender = 'male';

-- Intersection
SELECT DISTINCT p.parent 
FROM ParentChild p
JOIN Person per ON p.parent = per.name
WHERE per.gender = 'male';

-- Difference
SELECT name FROM Person
EXCEPT
SELECT name FROM Person WHERE gender = 'male';

-- Projection
SELECT DISTINCT parent FROM ParentChild;

-- Cartesian Product
SELECT m.name AS husband, f.name AS wife
FROM Person m, Person f
WHERE m.gender = 'male' AND f.gender = 'female';

-- Theta-Join & Selection
SELECT pc1.parent AS grandfather
FROM ParentChild pc1
JOIN ParentChild pc2 ON pc1.child = pc2.parent
JOIN Person p ON pc1.parent = p.name
WHERE pc2.child = 'peter' AND p.gender = 'male';


-- Transitive Closure
WITH RECURSIVE Ancestors AS (
    SELECT parent, child, 1 as depth
    FROM ParentChild
    UNION ALL
    SELECT p.parent, a.child, a.depth + 1
    FROM ParentChild p
    JOIN Ancestors a ON p.child = a.parent
)
-- Symmetric Closure
, BloodRelatives AS (
    SELECT DISTINCT a1.child AS p1, a2.child AS p2
    FROM Ancestors a1
    JOIN Ancestors a2 ON a1.parent = a2.parent
    WHERE a1.child <> a2.child
)
-- Reflexive Closure
SELECT p1, p2 FROM BloodRelatives
UNION
SELECT name, name FROM Person;



