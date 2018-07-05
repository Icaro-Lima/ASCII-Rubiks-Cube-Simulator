import Data.Maybe (fromMaybe)
import qualified Base as Base
import qualified Data.Map.Strict as Map
import System.IO.Unsafe                                        
import System.Random



{-|
  Escreve texto a partir de uma determinada posição.
  Int :      Posição i na matriz.
  Int :      Posição j na matriz.
  String :   Texto a ser escrito.
  [String] : Estado atual da matriz.
-}
writeText :: Int -> Int -> String -> [String] -> [String]
writeText i j text matrix = Base.writeTextAux i 0 j text matrix

writeCube :: Int -> Int -> String -> Bool -> [String] -> [String]
writeCube i j animation instructions matrix = do
  let matrixWithInstructions = if instructions
                               then matrix --writeInstructions i j True matrix
                               else matrix
  
  let lines = Map.lookup animation Base.animations
                               
  matrixWithInstructions                 
  
-- |Retorna uma matriz de caracteres vazia, rows x line_limit, cada linha com
-- cols espaços e (line_limit - cols) nulls.
filledMatrix :: [String]
filledMatrix = Base.filledMatrixAux 0

-- |Desenha a matrix no console.
drawMatrix :: [String] -> IO()
drawMatrix strs = putStr (Base.matrixToString strs)

{- Comentado pra nao causar erros.

Movimentos numerados serão substituidos por 
chamadas da funcao rotatecube.

Lembrando que pra funcionar, precisa instalar o cabal e
com ele instalar o random

Comandos:
sudo apt-get install cabal-install
cabal update
cabal install random

Exemplo de chamada da funcão:
shuffle 20

moveSelect :: Int -> IO()
moveSelect x
  | x == 1 = movimento1
  | x == 2 = movimento2
  | x == 3 = movimento3
  | x == 4 = movimento4
  | x == 5 = movimento5
  | x == 6 = movimento6
  | x == 7 = movimento7
  | x == 8 = movimento8
  | x == 9 = movimento9
  | x == 10 = movimento10
  | x == 11 = movimento11
  | x == 12 = movimento12
  | x == 13 = movimento13
  | x == 14 = movimento14
  | x == 15 = movimento15
  | x == 16 = movimento16
  | x == 17 = movimento17
  | otherwise = movimento18 

shuffle 0 = return ()
shuffle n =
  do
    moveSelect (unsafePerformIO (getStdRandom (randomR (0, 18))))
    shuffle (n-1)
-}



main :: IO()
main = do
  putStr (Base.colorizeString "#######zzzzzzz        #000##AAAAAA####DDDD##ddd#nn##kkk##" Base.cube_matrix)
  drawMatrix (fromMaybe [""] (Map.lookup "Default" Base.loadAnimations))
  --print (writeText 3 10 "Icaro" (fromMaybe [""] (Map.lookup "0Left_0" Base.loadAnimations)))
