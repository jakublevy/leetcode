--just bruteforce
--https://leetcode.com/problems/longest-valid-parentheses/

longestValidParentheses :: String -> Int
longestValidParentheses s = longestValidParentheses' s 0 0

longestValidParentheses' :: String -> Int -> Int -> Int
longestValidParentheses' [] balance l       | balance > 0   = 0
                                            | otherwise     = l

longestValidParentheses' (x : xs) balance l | x == ')' && balance == 0      = max l o2
                                            | x == ')' && balance > 0       = longestValidParentheses' xs (balance-1) (l+1)
                                            | x == '(' && balance == 0      = maximum [l, o1, o2]
                                            | x == '(' && balance > 0       = max o1 o2
            where
                o1 = longestValidParentheses' xs (balance+1) (l+1)
                o2 = longestValidParentheses' xs balance 0
