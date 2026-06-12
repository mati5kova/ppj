main = return ()

{-
    OSNOVNE FUNKCIJE
-}

-- absolutna vrednost
absVal :: Int -> Int
absVal n | n < 0 = -n
         | otherwise = n

-- maksimum dveh stevil
max2 :: Int -> Int -> Int
max2 a b | a >= b = a
         | otherwise = b

-- minimum dveh stevil
min2 :: Int -> Int -> Int
min2 a b | a <= b = a
         | otherwise = b

-- maksimum treh stevil
max3 :: Int -> Int -> Int -> Int
max3 a b c = max2 (max2 a b) c

-- preveri ali je stevilo sodo
sodo :: Int -> Bool
sodo n = n `mod` 2 == 0

-- preveri ali je stevilo liho
liho :: Int -> Bool
liho n = n `mod` 2 /= 0

-- potenca: izracuna a^n
potenca :: Int -> Int -> Int
potenca _ 0 = 1
potenca a n = a * potenca a (n-1)

-- vsota stevil od 1 do n
vsotaDo :: Int -> Int
vsotaDo 0 = 0
vsotaDo n = n + vsotaDo (n-1)

-- produkt stevil od 1 do n
produktDo :: Int -> Int
produktDo 0 = 1
produktDo n = n * produktDo (n-1)

-- najvecji skupni delitelj
gcd2 :: Int -> Int -> Int
gcd2 a 0 = a
gcd2 a b = gcd2 b (a `mod` b)

-- najmanjsi skupni veckratnik
lcm2 :: Int -> Int -> Int
lcm2 a b = (a * b) `div` gcd2 a b

{-
    SEZNAMI
-}

-- clanstvo/vsebovanost v seznamu
member :: Int -> [Int] -> Bool
member _ [] = False
member x (h : t) | x == h = True
                 | otherwise = member x t

-- dolzina seznama
dolzina :: [Int] -> Int
dolzina [] = 0
dolzina (_ : t) = 1 + dolzina t

-- vsota elementov seznama
vsota :: [Int] -> Int
vsota [] = 0
vsota (h : t) = h + vsota t

-- produkt elementov seznama
produkt :: [Int] -> Int
produkt [] = 1
produkt (h : t) = h * produkt t

-- zadnji element seznama
zadnji :: [Int] -> Int
zadnji [x] = x
zadnji (_ : t) = zadnji t

-- prvih n elementov seznama
prvih :: Int -> [Int] -> [Int]
prvih 0 _ = []
prvih _ [] = []
prvih n (h : t) = h : prvih (n-1) t

-- odstrani prvih n elementov
spusti :: Int -> [Int] -> [Int]
spusti 0 lst = lst
spusti _ [] = []
spusti n (_ : t) = spusti (n-1) t

-- obrni/reverse seznam
rev :: [Int] -> [Int]
rev [] = []
rev (h : t) = rev t ++ [h]

-- preveri ali je seznam palindrom
palindrom :: [Int] -> Bool
palindrom lst = lst == rev lst

-- zdruzi dva seznama
conc :: [Int] -> [Int] -> [Int]
conc [] ys = ys
conc (h : t) ys = h : conc t ys

-- vrne najmanjsi element seznama
minimumLst :: [Int] -> Int
minimumLst [x] = x
minimumLst (h : t) = min2 h (minimumLst t)

-- vrne najvecji element seznama
maximumLst :: [Int] -> Int
maximumLst [x] = x
maximumLst (h : t) = max2 h (maximumLst t)

-- odstrani vse pojavitve stevila x iz seznama
odstrani :: Int -> [Int] -> [Int]
odstrani _ [] = []
odstrani x (h : t) | x == h = odstrani x t
                   | otherwise = h : odstrani x t

-- presteje kolikokrat se x pojavi v seznamu - count occurences
pojavitve :: Int -> [Int] -> Int
pojavitve _ [] = 0
pojavitve x (h : t) | x == h = 1 + pojavitve x t
                    | otherwise = pojavitve x t

-- preveri ali so vsi elementi pozitivni
vsiPozitivni :: [Int] -> Bool
vsiPozitivni [] = True
vsiPozitivni (h : t) = h > 0 && vsiPozitivni t

-- preveri ali obstaja sodo stevilo v seznamu
obstajaSodo :: [Int] -> Bool
obstajaSodo [] = False
obstajaSodo (h : t) = sodo h || obstajaSodo t

{-
    FILTRIRANJE IN PRESLIKAVE
-}

-- vrne samo soda stevila
soda :: [Int] -> [Int]
soda lst = [x | x <- lst, x `mod` 2 == 0]

-- vrne samo liha stevila
liha :: [Int] -> [Int]
liha lst = [x | x <- lst, x `mod` 2 /= 0]

-- vrne samo pozitivna stevila
pozitivna :: [Int] -> [Int]
pozitivna lst = [x | x <- lst, x > 0]

-- kvadrati elementov seznama
kvadrati :: [Int] -> [Int]
kvadrati lst = [x * x | x <- lst]

-- podvoji vse elemente seznama
podvoji :: [Int] -> [Int]
podvoji lst = [2 * x | x <- lst]

-- vsi elementi vecji od n
-- ohrani vse elemente vecje od n
vecjiOd :: Int -> [Int] -> [Int]
vecjiOd n lst = [x | x <- lst, x > n]

-- vsi elementi med a in b inkluzivno
med :: Int -> Int -> [Int] -> [Int]
med a b lst = [x | x <- lst, x >= a, x <= b]

-- deli seznam na soda in liha stevila
sodaLiha :: [Int] -> ([Int], [Int])
sodaLiha lst = ([x | x <- lst, sodo x], [x | x <- lst, liho x])

-- odstrani duplikate iz seznama
-- make_set makeSet set mnozica
unikatni :: [Int] -> [Int]
unikatni [] = []
unikatni (h : t) | member h t = unikatni t
                 | otherwise = h : unikatni t

{-
    UREJANJE
-}

-- vstavi element v ze urejen seznam
vstavi :: Int -> [Int] -> [Int]
vstavi x [] = [x]
vstavi x (h : t) | x <= h = x : h : t
                 | otherwise = h : vstavi x t

-- insertion sort
uredi :: [Int] -> [Int]
uredi [] = []
uredi (h : t) = vstavi h (uredi t)

-- preveri ali je seznam narascajoce urejen
narascajoc :: [Int] -> Bool
narascajoc [] = True
narascajoc [_] = True
narascajoc (x : y : t) = x <= y && narascajoc (y : t)

-- preveri ali je seznam padajoce urejen
padajoc :: [Int] -> Bool
padajoc [] = True
padajoc [_] = True
padajoc (x : y : t) = x >= y && padajoc (y : t)

{-
    STEVILA IN PRASTEVILA
-}

-- preveri ali stevilo d deli stevilo n
deli :: Int -> Int -> Bool
deli d n = n `mod` d == 0

-- vrne vse delitelje stevila n
delitelji :: Int -> [Int]
delitelji n = [d | d <- [1..n], d `deli` n]

-- preveri ali je stevilo prastevilo
prastevilo :: Int -> Bool
prastevilo n | n <= 1 = False
             | otherwise = delitelji n == [1, n]

-- vsa prastevila do n
prastevilaDo :: Int -> [Int]
prastevilaDo n = [x | x <- [2..n], prastevilo x]

-- stevilo deliteljev stevila n
stDeliteljev :: Int -> Int
stDeliteljev n = dolzina (delitelji n)

-- preveri ali je stevilo popolno
-- popolno stevilo je enako vsoti svojih pravih deliteljev
popolno :: Int -> Bool
popolno n = vsota [d | d <- [1..n-1], d `deli` n] == n

-- vsa popolna stevila do n
popolnaDo :: Int -> [Int]
popolnaDo n = [x | x <- [1..n], popolno x]

{-
    PARI, TROJICE IN KOMBINACIJE
-}

-- vsi pari iz dveh seznamov
vsiPari :: [Int] -> [Int] -> [(Int, Int)]
vsiPari xs ys = [(x, y) | x <- xs, y <- ys]

-- pari, katerih vsota je enaka s
pariVsota :: Int -> [(Int, Int)]
pariVsota s = [(x, y) | x <- [0..s], y <- [0..s], x + y == s]

-- pitagorejske trojice do n
pitagorejske :: Int -> [(Int, Int, Int)]
pitagorejske n = [(a, b, c) | a <- [1..n], b <- [1..n], c <- [1..n], a*a + b*b == c*c]

-- pitagorejske trojice kjer je a < b < c
pitagorejskeUrejene :: Int -> [(Int, Int, Int)]
pitagorejskeUrejene n = [(a, b, c) | a <- [1..n], b <- [1..n], c <- [1..n], a < b, b < c, a*a + b*b == c*c]

-- kartezicni produkt dveh seznamov
produktSeznamov :: [Int] -> [Int] -> [(Int, Int)]
produktSeznamov xs ys = [(x, y) | x <- xs, y <- ys]

{-
    NIZI
-}

-- dolzina niza
dolzinaNiza :: String -> Int
dolzinaNiza [] = 0
dolzinaNiza (_ : t) = 1 + dolzinaNiza t

-- obrne niz
obrniNiz :: String -> String
obrniNiz [] = []
obrniNiz (h : t) = obrniNiz t ++ [h]

-- preveri ali je niz palindrom
palindromNiz :: String -> Bool
palindromNiz s = s == obrniNiz s

-- presteje pojavitev znaka v nizu
pojavitveZnaka :: Char -> String -> Int
pojavitveZnaka _ [] = 0
pojavitveZnaka c (h : t) | c == h = 1 + pojavitveZnaka c t
                         | otherwise = pojavitveZnaka c t

-- odstrani vse presledke iz niza
brezPresledkov :: String -> String
brezPresledkov [] = []
brezPresledkov (h : t) | h == ' ' = brezPresledkov t
                       | otherwise = h : brezPresledkov t

{-
    TOKOVI / NESKONCNI SEZNAMI
-}

-- naravna stevila od 0 naprej
naravna :: [Int]
naravna = [0..]

-- pozitivna naravna stevila
pozitivnaNaravna :: [Int]
pozitivnaNaravna = [1..]

-- soda stevila
sodaInf :: [Int]
sodaInf = [2 * k | k <- [0..]]

-- liha stevila
lihaInf :: [Int]
lihaInf = [2 * k + 1 | k <- [0..]]

-- kvadrati naravnih stevil
kvadratiInf :: [Int]
kvadratiInf = [k * k | k <- [0..]]

-- potence stevila 2
potenceDva :: [Int]
potenceDva = [2 ^ k | k <- [0..]]

-- fibonacci kot neskoncen seznam
fibSeznam :: [Int]
fibSeznam = 0 : 1 : [fibSeznam !! (k-1) + fibSeznam !! (k-2) | k <- [2..]]

-- alternirajoci seznam 1, -1, 1, -1, ...
plusMinus :: [Int]
plusMinus = [(-1)^k | k <- [0..]]

-- seznam: 1, -2, 3, -4, 5, -6, ...
alternirajoci :: [Int]
alternirajoci = [(k + 1) * (-1)^k | k <- [0..]]

-- trikotniska stevila: 1, 3, 6, 10, 15, ...
trikotniska :: [Int]
trikotniska = [vsotaDo k | k <- [1..]]

{-
    FUNKCIJE VISJEGA REDA
-}

-- moja verzija map
-- mojMap (\x -> x*x) [1,2,3,4,5]
mojMap :: (Int -> Int) -> [Int] -> [Int]
mojMap _ [] = []
mojMap f (h : t) = f h : mojMap f t

-- moja verzija filter
mojFilter :: (Int -> Bool) -> [Int] -> [Int]
mojFilter _ [] = []
mojFilter p (h : t) | p h = h : mojFilter p t
                    | otherwise = mojFilter p t

-- moja verzija foldr za Int sezname
mojFoldr :: (Int -> Int -> Int) -> Int -> [Int] -> Int
mojFoldr _ z [] = z
mojFoldr f z (h : t) = f h (mojFoldr f z t)

-- vsota z uporabo foldr
vsotaFold :: [Int] -> Int
vsotaFold lst = mojFoldr (+) 0 lst

-- produkt z uporabo foldr
produktFold :: [Int] -> Int
produktFold lst = mojFoldr (*) 1 lst