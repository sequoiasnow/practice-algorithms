-- | A simple weighted binary tree.

module Main where

import Data.Maybe (listToMaybe, catMaybes)

data Tree a = Empty | Node (Tree a) a (Tree a)

treeInsert :: (Ord a) => a -> Tree a -> Tree a
treeInsert a Empty = Node Empty a Empty
treeInsert a (Node t1 z t2)
  | a < z     = Node (treeInsert a t1) z t2
  | otherwise = Node t1 z (treeInsert a t2)

-- |Finds an element in the tree that matches a given function.
treeFind :: (Ord a) => (a -> Bool) -> Tree a -> Maybe a
treeFind _ Empty = Nothing
treeFind f (Node t1 z t2)
  | f z       = Just z
  | otherwise = listToMaybe $ catMaybes [treeFind f t1, treeFind f t2]

-- |Map through a tree.
treeMap :: (a -> b) -> Tree a -> Tree b
treeMap _ Empty = Empty
treeMap f (Node t1 z t2) = Node (treeMap f t1) (f z) (treeMap f t2)

-- |Deletes an element in a tree
treeDelete :: (Ord a) => a -> Tree a -> Tree a
treeDelete _ Empty = Empty
treeDelete a n@(Node Empty z Empty)
  | a == z    = Empty
  | otherwise = n
treeDelete a n@(Node Empty z t@(Node _ _ _))
  | a == z    = t
  | otherwise = n
treeDelete a n@(Node t@(Node _ _ _) z Empty)
  | a == z    = t
  | otherwise = n
treeDelete a (Node t1 z t2)
  | a == z    = case t2min of
                  Just m  -> Node t1 m (treeDelete m t2)
                  Nothing -> t1 -- t2 is empty
  | otherwise = Node (treeDelete a t1) z (treeDelete a t2) 
  where
    t2min = treeMin t2
-- |Finds the minimum value in a tree.
treeMin :: (Ord a) => Tree a -> Maybe a
treeMin Empty = Nothing
treeMin (Node t1 z t2) = minimum <$> sequence [m1, m2, Just z]
  where
    m1 = treeMin t1
    m2 = treeMin t2

main :: IO ()
main = print "read the code!"

