--not optimal solution
--https://leetcode.com/problems/median-of-two-sorted-arrays

median :: Fractional a => [a] -> a
median xs@(_ : _) | odd l  = rest!!0
                  | even l = (rest!!0 + rest!!1) / 2
    where 
        l = length xs  
        idx = (l-1) `div` 2
        rest = drop idx xs

medianSorted :: (Fractional a, Ord a, Eq a) => [a] -> [a] -> a
medianSorted xs ys = median $ merge xs ys

merge :: (Ord a, Eq a) => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge (x : xs) (y : ys) | x <= y    = x : y : merge xs ys
                        | otherwise = y : x : merge xs ys
