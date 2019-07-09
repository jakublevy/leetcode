--https://leetcode.com/problems/jump-game/
--https://leetcode.com/problems/jump-game-ii/

import Data.List

jumpGame_i :: Integral i => [i] -> Bool
jumpGame_i [] = False
jumpGame_i xs = jumpGame_i' t 1
    where
        xsR = reverse xs
        t = tail xsR

jumpGame_i' :: Integral i => [i] -> i -> Bool
jumpGame_i' [x] d = x >= d
jumpGame_i' (x : xs) d | x < d      = jumpGame_i' xs (d+1)
                       | otherwise  = jumpGame_i' xs 1


jumpGame_ii :: [Int] -> Maybe Int
jumpGame_ii xs = jumpGame_ii' ys [head ys] 0
    where
        m1 = repeat (-1)
        ys = zip3 [0..] xs m1


jumpGame_ii' :: [(Int, Int, Int)] -> [(Int, Int, Int)] -> Int -> Maybe Int
jumpGame_ii' _ [] _ = Nothing
jumpGame_ii' xs ((i,v,d) : q) nD | idx == Nothing   = jumpGame_ii' ys (q++zs) (nD+1) 
                                 | otherwise        = Just (nD + 1)
    where
        ys = putAt i (i,v,nD) xs
        zs = filter(\(_,_,k) -> k == -1) (range v i ys)
        idx = findIndex (\(o,_,_) -> o == length xs - 1) zs


range :: Int -> Int -> [a] -> [a]
range v i xs | v > i     = (take i xs) ++ r
             | otherwise = (take v $ drop (i - v) xs) ++ r
    where r = take (v+1) $ drop i xs


putAt :: Integral i => i -> a -> [a] -> [a]
putAt _ _ [] = []
putAt 0 y (x : xs) = y : xs
putAt i y (x : xs) = x : putAt (i-1) y xs
