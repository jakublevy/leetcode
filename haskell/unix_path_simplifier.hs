import Data.List.Split
import Data.List

--https://leetcode.com/problems/simplify-path/

simplifyPath :: String -> String
simplifyPath path | length pathList == 1    = "/"
                  | otherwise               = intercalate "/" pathList
    where 
        split = splitOn "/" path
        pathList = reverse $ simplifyPath' split []

simplifyPath' :: [String] -> [String] -> [String]
simplifyPath' [] pathAcc = pathAcc
simplifyPath' (p : pathSplit) pathAcc | null p && null pathAcc                                         = simplifyPath' pathSplit ("" : pathAcc)
                                      | p == "." || null p || (length pathAcc == 1 && p == "..")       = simplifyPath' pathSplit pathAcc 
                                      | p == ".." && length pathAcc > 1                                = simplifyPath' pathSplit (tail pathAcc)
                                      | otherwise                                                      = simplifyPath' pathSplit (p : pathAcc)
