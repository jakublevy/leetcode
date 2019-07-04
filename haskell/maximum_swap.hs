import Data.List

--https://leetcode.com/problems/maximum-swap/

maximumSwap :: (Show a, Read a, Integral a) => a -> a
maximumSwap n = read nMax 
    where nMax = maximumSwap' $ show n

maximumSwap' :: String -> String
maximumSwap' [d] = [d]
maximumSwap' (d : n) | m > d = m : s
                     | otherwise = d : maximumSwap' n
    where
        m = maximum n
        i = elemIndex m n
        idx = case i of Just v -> v
        s = putAt idx d n


putAt :: Int -> a -> [a] -> [a]
putAt _ _ [] = []
putAt 0 y (x : xs) = y : xs
putAt i y (x : xs) = x : putAt (i-1) y xs
