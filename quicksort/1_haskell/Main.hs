
module Main where

-- | Simple quicksort function using a linked list
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = quicksort [y | y <- xs, y < x] ++
                   (x : quicksort [y | y <- xs, y >= x])

                   
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
main = getLine >>= putStrLn . show . quicksort . (read :: String -> [Int])

