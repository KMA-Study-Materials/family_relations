module Main where

import Data.List (nub, intersect, (\\))

type Person = String


females, males :: [Person]
females = ["jane", "anna", "mary", "catlyn", "sarah"]
males   = ["john", "jim", "peter", "alex", "tom", "micky"]

relations :: [(Person, Person)]
relations = 
    [ ("john", "jim"), ("jane", "jim"), ("jim", "anna")
    , ("jim", "tom"), ("anna", "peter"), ("tom", "mary"), ("tom", "alex")
    ]



allPeople :: [Person]
allPeople = nub (females ++ males) -- Union

fathers :: [(Person, Person)] -- Intersection
fathers = [(p, c) | (p, c) <- relations, p `elem` males]

womenByDiff :: [Person] -- Difference
womenByDiff = allPeople \\ males

isParent :: Person -> Bool -- Projection
isParent x = any (\(p, _) -> p == x) relations

possiblePairs :: [(Person, Person)] -- Cartesian Product
possiblePairs = [(m, f) | m <- males, f <- females]

-- Theta-Join & Selection
grandfathersOfPeter :: [Person]
grandfathersOfPeter = nub [gf | (gf, p) <- fathers, (p', "peter") <- relations, p == p']



parents :: Person -> [Person] -- Inverse
parents child = [p | (p, c) <- relations, c == child]

siblings :: Person -> [Person] -- Inequality
siblings x = nub [s | p <- parents x, (p', s) <- relations, p == p', s /= x]



ancestors :: Person -> [Person] -- Transitive Closure
ancestors x = 
    let p = parents x
    in nub (p ++ concatMap ancestors p)

isBloodRelative :: Person -> Person -> Bool -- Symmetric Closure
isBloodRelative x y 
    | x == y    = False
    | otherwise = not (null (ancestors x `intersect` ancestors y))

inGeneticClan :: Person -> Person -> Bool -- Reflexive Closure
inGeneticClan x y = x == y || isBloodRelative x y


main :: IO ()
main = do
    putStrLn $ "Union (All People): " ++ show allPeople
    putStrLn $ "Intersection (Fathers): " ++ show fathers
    putStrLn $ "Difference (Women): " ++ show womenByDiff
    putStrLn $ "Join (Grandfathers of Peter): " ++ show grandfathersOfPeter
    putStrLn $ "Ancestors of Mary: " ++ show (ancestors "mary")
    putStrLn $ "Is Jim in his own genetic clan? " ++ show (inGeneticClan "jim" "jim")