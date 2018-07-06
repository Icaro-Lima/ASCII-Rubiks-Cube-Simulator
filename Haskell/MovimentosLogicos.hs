import Data.List
import qualified Base as Base

-- |Auxiliar!
getMatrixLine :: Int -> Int -> Int -> Int -> [[Int]] -> [Int]
getMatrixLine linha a b c cubeMatrix = do
  let line = genericIndex cubeMatrix linha
  
  [genericIndex line a] ++ 
    [genericIndex line b] ++ 
    [genericIndex line c]

-- |Auxiliar!
getMatrixCol :: Int -> Int -> Int -> Int -> [[Int]] -> [Int]
getMatrixCol coluna a b c cubeMatrix = 
  [genericIndex (genericIndex cubeMatrix a) coluna] ++ 
  [genericIndex (genericIndex cubeMatrix b) coluna] ++ 
  [genericIndex (genericIndex cubeMatrix c) coluna]


swapL :: Int -> Int -> Int -> [Int] -> [[Int]] -> [[Int]]
swapL i comeco fim array logicalMatrix = do
  let linha = genericIndex logicalMatrix i
  
  take i logicalMatrix ++
    [(take comeco linha) ++ array ++ (drop (fim + 1) linha)] ++
    drop (i + 1) logicalMatrix

swapC :: Int -> Int -> Int -> [Int] -> [[Int]] -> [[Int]]
swapC j comeco fim array logicalMatrix = do
  let line0 = genericIndex logicalMatrix comeco
  let line1 = genericIndex logicalMatrix (comeco + 1)
  let line2 = genericIndex logicalMatrix fim

  (take comeco logicalMatrix) ++ 
    [(take j line0) ++ [((!!) array 0)] ++ (drop (j + 1) line0)] ++ 
    [(take j line1) ++ [((!!) array 1)] ++ (drop (j + 1) line1)] ++ 
    [(take j line2) ++ [((!!) array 2)] ++ (drop (j + 1) line2)] ++ 
    (drop (fim + 1) logicalMatrix)



giraFaceAntiHorario :: Int -> Int -> Int -> Int -> [[Int]] -> [[Int]]
giraFaceAntiHorario lIni cIni lFim cFim cubeMatrix = do
    a <- getMatrixLine lIni cFim cFim-1 cIni cubeMatrix
    b <- getMatrixCol cFim lIni lFim-1 lFim cubeMatrix
    c <- getMatrixLine lFim cFim cFim-1 cIni cubeMatrix
    d <- getMatrixCol cIni lIni lFim-1 lFim cubeMatrix
    matrix <- (swapL lFim cIni cFim d (swapC cFim lIni lFim c (swapL lIni cIni cFim b cubeMatrix)))

    return (swapC cIni lIni cFim a matrix)


giraFaceHorario :: Int -> Int -> Int -> Int -> [[Int]] -> [[Int]]
giraFaceHorario lIni cIni lFim cFim cubeMatrix = do
    a <- getMatrixLine lIni cIni cFim-1 cFim cubeMatrix
    b <- getMatrixCol cFim lFim lFim-1 lIni cubeMatrix
    c <- getMatrixLine lFim cIni cFim-1 cFim cubeMatrix
    d <- getMatrixCol cIni lFim lFim-1 lIni cubeMatrix
    matrix <- (swapL lFim cIni cFim b cubeMatrix (swapC cIni lIni lFim c (swapL lIni cIni cFim d cubeMatrix)))

    swapC cFim lIni lFim a matrix

aAntiHorario :: [[Int]] -> [[Int]]
aAntiHorario cubeMatrix = do
    a <- getMatrixLine 2 5 4 3 cubeMatrix
    b <- getMatrixCol 6 3 4 5 cubeMatrix
    c <- getMatrixLine 6 5 4 3 cubeMatrix
    d <- getMatrixCol 2 3 4 5 cubeMatrix
    matrix <- (swapC 2 3 5 a (swapL 6 3 5 d (swapC 6 3 5 c (swapL 2 3 5 b cubeMatrix))))

    giraFaceAntiHorario 3 3 5 5 matrix


aHorario :: [[Int]] -> [[Int]]
aHorario cubeMatrix = do
    a <- getMatrixLine 2 3 4 5 cubeMatrix
    b <- getMatrixCol 6 5 4 3 cubeMatrix
    c <- getMatrixLine 6 3 4 5 cubeMatrix
    d <- getMatrixCol 2 5 4 3 cubeMatrix
    matrix <- (swapC 6 3 5 a (swapL 6 3 5 b (swapC 2 3 5 c (swapL 2 3 5 d cubeMatrix))))
    
    giraFaceHorario 3 3 5 5 matrix


bAntiHorario :: [[Int]] -> [[Int]]
bAntiHorario cubeMatrix = do
    a <- getMatrixLine 1 5 4 3 cubeMatrix
    b <- getMatrixCol 7 3 4 5 cubeMatrix
    c <- getMatrixLine 7 5 4 3 cubeMatrix
    d <- getMatrixCol 1 3 4 5 cubeMatrix
    matrix <- (swapL 7 3 5 d (swapC 7 3 5 c (swapL 1 3 5 b cubeMatrix)))
    
    swapC 1 3 5 a matrix
    
bHorario :: [[Int]] -> [[Int]]
bHorario cubeMatrix = do
    a <- [getMatrixLine 1 3 4 5 cubeMatrix]
    b <- getMatrixCol 7 5 4 3 cubeMatrix
    c <- getMatrixLine 7 3 4 5 cubeMatrix
    d <- getMatrixCol 1 5 4 3 cubeMatrix
    matrix <- (swapL 7 3 5 b (swapC 1 3 5 c (swapL 1 3 5 d cubeMatrix)))
    
    swapC 7 3 5 a matrix

cAntiHorario :: [[Int]] -> [[Int]]
cAntiHorario cubeMatrix = do
    a <- getMatrixLine 0 5 4 3 cubeMatrix
    b <- getMatrixCol 8 3 4 5 cubeMatrix
    c <- getMatrixLine 8 5 4 3 cubeMatrix
    d <- getMatrixCol 0 3 4 5 cubeMatrix
    matrix <- (swapC 0 3 5 a (swapL 8 3 5 d (swapC 8 3 5 c (swapL 0 3 5 b cubeMatrix))))
    
    giraFaceHorario 9 3 11 5 matrix

cHorario :: [[Int]] -> [[Int]]
cHorario cubeMatrix = do
    a <- getMatrixLine 0 3 4 5 cubeMatrix
    b <- getMatrixCol 8 5 4 3 cubeMatrix
    c <- getMatrixLine 8 3 4 5 cubeMatrix
    d <- getMatrixCol 0 5 4 3 cubeMatrix
    matrix <- (swapC 8 3 5 a (swapL 8 3 5 b (swapC 0 3 5 c (swapL 0 3 5 d cubeMatrix))))

    giraFaceAntiHorario 9 3 11 5 matrix


zeroEsq :: [[Int]] -> [[Int]]
zeroEsq cubeMatrix = do
    a <- getMatrixLine 3 0 1 2 cubeMatrix
    b <- getMatrixLine 3 3 4 5 cubeMatrix
    c <- getMatrixLine 3 6 7 8 cubeMatrix
    d <- getMatrixLine 11 3 4 5 cubeMatrix
    matrix <- (swapL 11 3 5 a (swapL 3 6 8 d (swapL 3 3 5 c (swapL 3 0 2 b cubeMatrix))))

    giraFaceHorario 0 3 2 5 matrix

zeroDir :: [[Int]] -> [[Int]]
zeroDir cubeMatrix = do
    a <- getMatrixLine 3 0 1 2 cubeMatrix
    b <- getMatrixLine 3 3 4 5 cubeMatrix
    c <- getMatrixLine 3 6 7 8 cubeMatrix
    d <- getMatrixLine 11 3 4 5 cubeMatrix
    matrix <- (swapL 11 3 5 c (swapL 3 6 8 b (swapL 3 3 5 a (swapL 3 0 2 d cubeMatrix))))

    giraFaceAntiHorario 0 3 2 5 matrix


umEsq :: [[Int]] -> [[Int]]
umEsq cubeMatrix = do
    a <- getMatrixLine 4 0 1 2 cubeMatrix
    b <- getMatrixLine 4 3 4 5 cubeMatrix
    c <- getMatrixLine 4 6 7 8 cubeMatrix
    d <- getMatrixLine 10 3 4 5 cubeMatrix
    
    swapL 10 3 5 a (swapL 4 6 8 d (swapL 4 3 5 c (swapL 4 0 2 b cubeMatrix)))


umDir :: [[Int]] -> [[Int]]
umDir cubeMatrix = do
    a <- getMatrixLine 4 0 1 2 cubeMatrix
    b <- getMatrixLine 4 3 4 5 cubeMatrix
    c <- getMatrixLine 4 6 7 8 cubeMatrix
    d <- getMatrixLine 10 3 4 5 cubeMatrix

    swapL 10 3 5 c (swapL 4 6 8 b (swapL 4 3 5 a (swapL 4 0 2 d cubeMatrix)))


doisEsq :: [[Int]] -> [[Int]]
doisEsq cubeMatrix = do
    a <- getMatrixLine 5 0 1 2 cubeMatrix
    b <- getMatrixLine 5 3 4 5 cubeMatrix
    c <- getMatrixLine 5 6 7 8 cubeMatrix
    d <- getMatrixLine 9 3 4 5 cubeMatrix
    matrix <- (swapL 9 3 5 a (swapL 5 6 8 d (swapL 5 3 5 c (swapL 5 0 2 b cubeMatrix))))

    giraFaceAntiHorario 6 3 8 5 matrix

doisDir :: [[Int]] -> [[Int]]
doisDir cubeMatrix = do
    a <- getMatrixLine 5 0 1 2 cubeMatrix
    b <- getMatrixLine 5 3 4 5 cubeMatrix
    c <- getMatrixLine 5 6 7 8 cubeMatrix
    d <- getMatrixLine 9 3 4 5 cubeMatrix
    matrix <- (swapL 9 3 5 c cubeMatrix (swapL 5 6 8 b cubeMatrix (swapL 5 3 5 a cubeMatrix (swapL 5 0 2 d cubeMatrix))))

    giraFaceHorario 6 3 8 5 matrix

bigABaixo :: [[Int]] -> [[Int]]
bigABaixo cubeMatrix = do
    a <- getMatrixCol 3 0 1 2 cubeMatrix
    b <- getMatrixCol 3 3 4 5 cubeMatrix
    c <- getMatrixCol 3 6 7 8 cubeMatrix
    d <- getMatrixCol 3 9 10 11 cubeMatrix
    matrix <- (swapC 3 9 11 c (swapC 3 6 8 b (swapC 3 3 5 a (swapC 3 0 2 d cubeMatrix))))
  
    giraFaceHorario 3 0 5 2 matrix

bigACima :: [[Int]] -> [[Int]]
bigACima cubeMatrix = do
    a <- getMatrixCol 3 0 1 2 cubeMatrix
    b <- getMatrixCol 3 3 4 5 cubeMatrix
    c <- getMatrixCol 3 6 7 8 cubeMatrix
    d <- getMatrixCol 3 9 10 11 cubeMatrix
    matrix <- (swapC 3 9 11 c (swapC 3 6 8 b (swapC 3 3 5 a (swapC 3 0 2 d cubeMatrix))))

    giraFaceHorario 3 0 5 2 matrix


bigBBaixo :: [[Int]] -> [[Int]]
bigBBaixo cubeMatrix = do
    a <- getMatrixCol 4 0 1 2 cubeMatrix
    b <- getMatrixCol 4 3 4 5 cubeMatrix
    c <- getMatrixCol 4 6 7 8 cubeMatrix
    d <- getMatrixCol 4 9 10 11 cubeMatrix
    
    swapC 4 9 11 c cubeMatrix (swapC 4 6 8 b cubeMatrix (swapC 4 3 5 a cubeMatrix (swapC 4 0 2 d cubeMatrix)))
    
    

bigBCima :: [[Int]] -> [[Int]]
bigBCima cubeMatrix = do
    a <- getMatrixCol 4 0 1 2 cubeMatrix
    b <- getMatrixCol 4 3 4 5 cubeMatrix
    c <- getMatrixCol 4 6 7 8 cubeMatrix
    d <- getMatrixCol 4 9 10 11 cubeMatrix

    swapC 4 9 11 a (swapC 4 6 8 d  (swapC 4 3 5 c (swapC 4 0 2 b cubeMatrix)))


bigCBaixo :: [[Int]] -> [[Int]]
bigCBaixo cubeMatrix = do
    a <- getMatrixCol 5 0 1 2 cubeMatrix
    b <- getMatrixCol 5 3 4 5 cubeMatrix
    c <- getMatrixCol 5 6 7 8 cubeMatrix
    d <- getMatrixCol 5 9 10 11 cubeMatrix
    matrix <- (swapC 5 9 11 c (swapC 5 6 8 b (swapC 5 3 5 a (swapC 5 0 2 d cubeMatrix)))) 

    giraFaceAntiHorario 3 6 5 8 matrix

bigCCima :: [[Int]] -> [[Int]]
bigCCima cubeMatrix = do
   a <- getMatrixCol 5 0 1 2 cubeMatrix
   b <- getMatrixCol 5 3 4 5 cubeMatrix
   c <- getMatrixCol 5 6 7 8 cubeMatrix
   d <- getMatrixCol 5 9 10 11 cubeMatrix
   matrix <- (swapC 5 9 11 a (swapC 5 6 8 d (swapC 5 3 5 c (swapC 5 0 2 b cubeMatrix))))

   giraFaceHorario 3 6 5 8 matrix


main :: IO()
main = do
  mapM_ (print) Base.cube_matrix
  print ""
  mapM_ (print) (swapL 0 1 3 [4,3,2] Base.cube_matrix)

  print "Works!"
