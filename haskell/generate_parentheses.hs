--https://leetcode.com/problems/generate-parentheses/

generateParentheses :: Int -> [String]
generateParentheses n = generateParentheses' n 0 []

generateParentheses' :: Int -> Int -> String -> [String]
generateParentheses' 0 0 acc = [reverse acc]
generateParentheses' toOpen toClose acc | toOpen > 0 && toClose > 0     = p ++ q
                                        | toOpen > 0                    = p
                                        | toClose > 0                   = q
        where
            p = generateParentheses' (toOpen - 1) (toClose + 1) ('(' : acc)
            q = generateParentheses' toOpen (toClose - 1) (')' : acc)   
