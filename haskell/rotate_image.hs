--https://leetcode.com/problems/rotate-image/

rotate :: Num a => [[a]] -> [[a]]
rotate ([] : _) = []
rotate [] = []
rotate m = reverse(map head m) : rotate(map tail m)
