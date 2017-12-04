-- | This file describes a very simple implementation of an n-ary tree in
-- Haskell based off of the Wikipedia entry for k-ary tree.

module Main where

data Tree a = Empty | Leaf a | Node a [Tree a]

-- | Count the number of entries in a tree, you can also make a tree that
-- is balanced and therefore each node has a count, but that's for another day.
numTreeEntries :: Tree a -> Int
numTreeEntries Empty  = 0
numTreeEntries (Leaf _) = 1
numTreeEntries (Node _ trees) = 1 + (sum $ map numTreeEntries trees)

-- | Here we are attempting to one bit of data with another, traversing the
-- tree to do so, kind of a fun example.
updateTreeValue :: (Eq a) => a -> a -> Tree a -> Tree a
updateTreeValue _ _ Empty = Empty
updateTreeValue a b (Leaf z)
  | a == z = Leaf b
  | otherwise = Leaf z
updateTreeValue a b (Node z ts)
  | a == z = Node b ts
  | otherwise = Node z (map (updateTreeValue a b) ts)


main :: IO ()
main = print "Yeah, the output isn't gonna help much I'm afraid, use the code."
