import Data.Array

type Matriz = Array (Int, Int) Int
matrizInicial :: Matriz
matrizInicial = array ((1,1),(12,9)) [ ((x,y), 0) | x <- [1..12], y <- [1..9]]

matrizPovoada :: Matriz
matrizPovoada = matrizInicial

getMatrixLine :: Matriz -> Int -> Int -> Int -> Int -> [Int]
getMatrixLine matrix linha a b c = 
    (matrix ! (linha,a)) : (matrix ! (linha,b)) : (matrix ! (linha,c)) : []

getMatrixLine :: Matriz -> Int -> Int -> Int -> Int -> [Int]
getMatrixLine matrix col a b c = 
    (matrix ! (a, col)) : (matrix ! (b, col)) : (matrix ! (c, col)) : []
    



main = do
    print (getMatrixLine matrizInicial 1 1 2 3)