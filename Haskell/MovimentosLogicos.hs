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

main :: IO()
main = do
  mapM_ (print) Base.cube_matrix
  print ""
  mapM_ (print) (swapL 0 1 3 [4,3,2] Base.cube_matrix)

  print "Works!"
