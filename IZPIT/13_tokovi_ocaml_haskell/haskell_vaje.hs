main = return ()

-- FAKTORIELA
factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial(n-1)

-- alternativen zapis
-- factorial :: Int -> Int
-- factorial n | n <= 1 = 1
--             | otherwise = n * factorial (n-1)

-- FIBONACCI
fib :: Int -> Int
fib n | n == 0 = 0
      | n == 1 = 1
      | otherwise = fib (n-1) + fib (n-2)
{-bottom up fibonacci-}
{-0 1 1 2 3 5 8 13 21-}
{-
fib_internal :: Int -> Int -> Int -> Int -> Int
fib_internal f0 f1 rep n 
    | rep == n = f1
    | otherwise = fib_internal (f1) (f0 + f1) (rep+1) (n)
fib :: Int -> Int
fib n = fib_internal 0 1 1 n
-}

{-
    SEZNAMI
-}
-- clanstvo/vsebovanost v seznamu
member :: Int -> [Int] -> Bool
member _ [] = False
member x (h : t) | x == h = True
                 | otherwise = member x t

-- above 
-- za dano število x in seznam s vrne True, če je x večji ali enak vsem elementom seznama s
above :: Int -> [Int] -> Bool
above _ [] = True
above x (h : t) = x >= h && above x t

-- pari
-- sprejme celo število n in vrne seznam vseh parov (i,j), kjer velja 1 ≤ i < j ≤ n
pari :: Int -> [(Int, Int)]
pari n = [(x, y) | x <- [1..n], y <- [1..n], x < y]

{-
    TOKOVI
-}
-- [0..] - seznam vseh naravnih števil 0, 1, 2, 3, ...
-- [ k * k | k <- [0..] ] - seznam kvadratov naravnih števil 0, 1, 4, 9, ...
-- [ (i, j) | i <- [0..], j <- [0..i] ] - seznam parov (i,j) kjer je i ≥ j: (0,0), (1,0), (1,1), (2,0), (2,1), (2,2), (3,0), ...
-- [k | k <- [1..], k * k mod 7 == 1] - seznam naravnih števil k, katerih kvadrat da pri deljenju s 7 ostanek 1: 1, 6, 8, 13, 15, ...

-- Če zgornje primere vnesemo v Haskell, le-ta začne izpisovati neskončen seznam. 
--      Če želimo videti le prvih 20 elementov, uporabimo funkcijo `take`
--      npr. take 20 [0..]         ->  [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]

-- rekurzivna definicija seznama: lst = 0 : [k + 1 | k <- lst]
--                                ena_dva_tri = 1:2:3:ena_dva_tri     -> [1,2,3,1,2,3,1,2,3,1,...]

-- neskoncen alternirajoc seznam
-- [1, -2, 3, -4, 5, -6, ...]
inf_altern = [(k + 1)*(-1)^(k) | k <- [0..]]

-- nedeljivi n lst
-- sprejme stevilo k in seznam lst ter vrne seznam tistih elementov iz lst, ki niso deljivi s k
nedeljivi :: Int -> [Int] -> [Int]
nedeljivi k lst = [i | i <- lst, (i `mod` k) /= 0]

-- Eratostenovo sito
eratosten :: [Int] -> [Int]
eratosten (k : lst) = k : eratosten (nedeljivi k lst)

prastevila :: [Int]
prastevila = eratosten [2..]     -- prastevila !! 1000      -> vrne 1000th prastevilo
