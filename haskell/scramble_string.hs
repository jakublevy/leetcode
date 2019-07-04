-- https://leetcode.com/problems/scramble-string/

import Data.List
data Bst a = Nil | Node (Bst a) a (Bst a) deriving (Eq, Show)

test = Node (Node (Node Nil "g" Nil) "gr" (Node Nil "r" Nil)) "great" (Node (Node Nil "e" Nil) "eat" (Node (Node Nil "a" Nil) "at" (Node Nil "t" Nil)))

swapCount :: (Integral n, Eq a) => Bst [a] -> n
swapCount Nil = 0
swapCount (Node l v r) | l /= Nil && r /= Nil    = 1 + swapCount l + swapCount r
                       | otherwise               = swapCount l + swapCount r


possibleTrees :: [a] -> [Bst [a]]
possibleTrees [] = [Nil]
possibleTrees [x] = [Node Nil [x] Nil]
possibleTrees s = trees 
    where
        split = [splitAt i s | i <- [1..length s - 1]]
        trees = [Node l (p ++ q) r | (p,q) <- split, l <- possibleTrees p, r <- possibleTrees q]

scrambleTrees :: Eq a => Bst [a] -> [Bst [a]]
scrambleTrees t = [swapBranchAtL k t | i <- [1..swapC], k <- combination i [1..swapC]]
    where swapC = swapCount t

--scrambleWords "great"
scrambleWords :: Eq a => [a] -> [[a]]
scrambleWords s = nub $ [nodeValue t' | t <- possibleTrees s, t' <- scrambleTrees t]

isScrambleWordOf :: Eq a => [a] -> [a] -> Bool
isScrambleWordOf x y = elem y (scrambleWords x)

swapBranchAtL :: (Integral i, Eq a) => [i] -> Bst [a] -> Bst [a]
swapBranchAtL xs t = foldr (\x t' -> swapBranchAt x t') t xs

swapBranchAt :: (Integral i, Eq a) => i -> Bst [a] -> Bst [a]
swapBranchAt n t | f > n     = t''
                 | otherwise = error "Out of range swap."
    where
        (f, t') = swapBranchAt' n 1 t  
        t'' = fixTree t'

        swapBranchAt' :: (Integral i, Eq a) => i -> i -> Bst [a] -> (i, Bst [a])
        swapBranchAt' n acc (Node l v r) | acc < n && l /= Nil && r /= Nil          =  if acc' <= n then (acc'', Node ll v rr)
                                                                                       else (acc', Node ll v r)

                                         | acc == n && l /= Nil && r /= Nil         =  (acc + 1, Node r v l)
                                         | l == Nil && r == Nil                     =  (acc, Node Nil v Nil)
            where
                (acc', ll) = swapBranchAt' n (acc+1) l
                (acc'', rr) = swapBranchAt' n acc' r


fixTree :: Eq a => Bst [a] -> Bst [a]
fixTree (Node Nil v Nil) = Node Nil v Nil
fixTree (Node l v r) | l /= Nil && r /= Nil = Node lF (nodeValue lF ++ nodeValue rF) rF
    where
        lF = fixTree l
        rF = fixTree r

nodeValue :: Bst a -> a
nodeValue Nil = error "Attempt to access a value of Nil."
nodeValue (Node _ v _) = v

combination :: (Eq a, Integral b) => b -> [a] -> [[a]]
combination 0 _ = [[]]
combination _ [] = []
combination n (x : xs) | n > 0 = combination n xs ++ map (x:) (combination (n-1) xs)
