import qualified Data.Map as Map

--https://leetcode.com/problems/repeated-dna-sequences/

findRepeatedDnaSeq :: String -> [String]
findRepeatedDnaSeq dna | length dna >= 10   = map fst dnaOccurence
                       | otherwise          = []
            where
                 m = findRepeatedDnaSeq' dna Map.empty
                 dnaOccurence = filter(\(_,o) -> o > 1) $ Map.toList m


findRepeatedDnaSeq' :: Num a => String -> Map.Map String a -> Map.Map String a
findRepeatedDnaSeq' [] m = m
findRepeatedDnaSeq' dna m = findRepeatedDnaSeq' rest nm
            where
                s = take 10 dna
                rest = drop 1 dna
                nm = Map.insertWith(\_ v -> v+1) s 1 m
