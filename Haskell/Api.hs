import Data.Maybe (fromMaybe)
import qualified Base as Base
import qualified Data.Map.Strict as Map
import System.IO.Unsafe                                        
import System.Random
import Data.Char
import Data.List



{-|
  Escreve texto a partir de uma determinada posição.
  Int :      Posição i na matriz.
  Int :      Posição j na matriz.
  String :   Texto a ser escrito.
  [String] : Estado atual da matriz.
-}
writeText :: Int -> Int -> String -> [String] -> [String]
writeText i j text matrix = Base.writeTextAux i 0 j text matrix


colorizeStringAux :: String -> [[Int]] -> Bool -> String
colorizeStringAux [] matrixOfColors looked = []
colorizeStringAux (h:t) matrixOfColors looked
  | ord h >= 65 && ord h <= 76 && looked == False = "\x1b[" ++ (show (genericIndex (genericIndex matrixOfColors ((ord h) - 65)) 3)) ++ "m " ++ (colorizeStringAux t matrixOfColors True)
  | ord h >= 65 && ord h <= 76 && looked == True = " " ++ (colorizeStringAux t matrixOfColors True)
  | ord h >= 77 && ord h <= 88 && looked == False = "\x1b[" ++ (show (genericIndex (genericIndex matrixOfColors ((ord h) - 77)) 4)) ++ "m " ++ (colorizeStringAux t matrixOfColors True)
  | ord h >= 77 && ord h <= 88 && looked == True = " " ++ (colorizeStringAux t matrixOfColors True)
  | ord h >= 97 && ord h <= 108 && looked == False = "\x1b[" ++ (show (genericIndex (genericIndex matrixOfColors ((ord h) - 97)) 5)) ++ "m " ++ (colorizeStringAux t matrixOfColors True)
  | ord h >= 97 && ord h <= 108 && looked == True = " " ++ (colorizeStringAux t matrixOfColors True)
  | ord h >= 109 && ord h <= 120 && looked == False = do
    let cod = (ord h) - 109
    let row = cod `div` 3
    let col = cod `rem` 3
    "\x1b[" ++ (show (genericIndex (genericIndex matrixOfColors (row + 3)) (col + 6))) ++ "m " ++ (colorizeStringAux t matrixOfColors True)
  | ord h >= 109 && ord h <= 120 && looked == True = " " ++ (colorizeStringAux t matrixOfColors True)
  | ord h >= 48 && ord h <= 56 && looked == False = do
    let cod = (ord h) - 48
    let row = cod `div` 3
    let col = cod `rem` 3
    "\x1b[" ++ (show (genericIndex (genericIndex matrixOfColors (row + 3)) (col))) ++ "m " ++ (colorizeStringAux t matrixOfColors True)
  | ord h >= 48 && ord h <= 56 && looked == True = " " ++ (colorizeStringAux t matrixOfColors True)
  | not (ord h >= 65 && ord h <= 76) && not (ord h >= 77 && ord h <= 88) && not (ord h >= 97 && ord h <= 108) && not (ord h >= 109 && ord h <= 120) && not (ord h >= 48 && ord h <= 56) && looked == True = "\x1b[0m" ++ [h] ++ (colorizeStringAux t matrixOfColors False)
  | otherwise = [h] ++ colorizeStringAux t matrixOfColors looked

{-|
  Retorna uma nova String colorida.
  String :  A String a ser colorida.
  [[Int]] : A matriz de cores.
-}
colorizeString :: String -> [[Int]] -> String
colorizeString str matrixOfColors = colorizeStringAux str matrixOfColors False

writeCube :: Int -> Int -> String -> Bool -> [String] -> [String]
writeCube i j animation instructions matrix = do
  let matrixWithInstructions = if instructions
                               then matrix --writeInstructions i j True matrix
                               else matrix
  
  let lines = Map.lookup animation Base.animations
                               
  matrixWithInstructions                 

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
  putStr (colorizeString "#######zzzzzzz        #000##AAAAAA####DDDD##ddd#nn##kkk##" Base.cube_matrix)
  drawMatrix (fromMaybe [""] (Map.lookup "Default" Base.loadAnimations))
  --print (writeText 3 10 "Icaro" (fromMaybe [""] (Map.lookup "0Left_0" Base.loadAnimations)))
