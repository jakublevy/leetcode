import Data.List

--https://leetcode.com/problems/permutations-ii/

permutations_ii :: Eq a => [a] -> [[a]]
permutations_ii [] = [[]]
permutations_ii xs = do
                      x <- toDelete xs
                      let ys = delete x xs
                      zs <- permutations_ii ys
                      return (x : zs)

toDelete :: Eq a => [a] -> [a]
toDelete [] = []
toDelete (x : xs) = x : toDelete (filter(/=x) xs)
