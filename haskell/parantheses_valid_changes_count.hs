minAddToMakeValid :: String -> Int
minAddToMakeValid xs = minAddToMakeValid' xs 0 0

minAddToMakeValid' :: String -> Int -> Int -> Int
minAddToMakeValid' [] balance counter = balance + counter
minAddToMakeValid' (x : xs) balance counter | x == '('                      = minAddToMakeValid' xs (balance+1) counter
                                            | x == ')' && balance == 0      = minAddToMakeValid' xs 0 (counter+1)
                                            | x == ')' && balance > 0       = minAddToMakeValid' xs (balance-1) counter
                                                 

