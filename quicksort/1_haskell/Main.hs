
module Main where

-- | Simple quicksort function using a linked list
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = quicksort [y | y <- xs, y < x] ++
                   (x : quicksort [y | y <- xs, y >= x])

                   
    
main :: IO ()
main = getLine >>= putStrLn . show . quicksort . (read :: String -> [Int])

