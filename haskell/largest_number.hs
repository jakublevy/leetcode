import Data.List

--https://leetcode.com/problems/largest-number/

largestNumber :: [Int] -> String
largestNumber = intercalate "" . map show . sortBy (\n m -> compare (combine m n) (combine n m))

combine :: Int -> Int -> Int
combine x y = read $ show x ++ show y :: Int
