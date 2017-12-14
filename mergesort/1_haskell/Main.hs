-- | A simple mergesort implementation.

module Main where

merge :: (Ord a) => [a] -> [a] -> [a]
merge xs [] = xs
merge [] xy = xy
merge (x:xs) (y:ys)
  | (x <= y)  = x:(merge xs (y:ys))
  | otherwise = y:(merge (x:xs) ys)

mergesort :: (Ord a) => [a] -> [a]
mergesort [] = []
mergesort [x] = [x]
mergesort list = merge (mergesort (take hl list)) (mergesort (drop hl list))
  where
    hl = length list `div` 2

main :: IO ()
main = getLine >>= putStrLn . show . mergesort . (read :: String -> [Int])
