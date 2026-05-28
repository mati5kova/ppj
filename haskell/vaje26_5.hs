main = return()

{-
factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n-1)
-}
factorial :: Int -> Int
factorial n 
    | n <= 1 = 1
    | otherwise = n * factorial (n-1)

{-bottom up fibonacci-}
{-0 1 1 2 3 5 8 13 21-}
fib_internal :: Int -> Int -> Int -> Int -> Int
fib_internal f0 f1 rep n 
    | rep == n = f1
    | otherwise = fib_internal (f1) (f0 + f1) (rep+1) (n)
fib :: Int -> Int
fib n = fib_internal 0 1 1 n

{-above-}
above :: Int -> [Int] -> Bool
above x [] = True
above x (head : tail)
    | x >= head && above x tail = True
    | otherwise = False


pari :: Int -> [(Int, Int)]
pari n = [(i, j) | i <- [1..n], j <- [1..n], i < j]

alternira :: Int -> [Int]
alternira n = take n [i * (-1)^(i+1) | i <- [1..]]

nedeljivi :: Int -> [Int] -> [Int]
nedeljivi k s = filter (\x -> mod x k > 0) s
