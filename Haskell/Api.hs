import Data.Maybe (fromMaybe)
import qualified Base as Base
import qualified Data.Map.Strict as Map
import System.IO.Unsafe                                        
import System.Random
import Debug.Trace
import System.Sleep

{-|
  Escreve texto a partir de uma determinada posição.
  Int :      Posição i na matriz.
  Int :      Posição j na matriz.
  String :   Texto a ser escrito.
  [String] : Estado atual da matriz.
-}
writeText :: Int -> Int -> String -> [String] -> [String]
writeText i j text matrix = Base.writeTextAux i 0 j text matrix

-- |Escreve um cubo colorido na matriz de entrada e retorna uma nova matriz.
writtenCube :: Int -> Int -> String -> Bool -> [[Int]] -> [String] -> [String]
writtenCube i j animation instructions matrixOfColors matrix = do
  let matrixWithInstructions = if instructions
                               then matrix --writeInstructions i j True matrix
                               else matrix
  
  let frame = fromMaybe ["Erow!"] (Map.lookup animation Base.animations)
                               
  Base.writtenCubeAux i 0 j frame matrixOfColors matrixWithInstructions
  
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

-- |Utilizar assim: mapM_ (Base.enganaMain) (drawLogoAnimation 0)
drawLogoAnimation :: Int -> [IO()]
drawLogoAnimation 44 = []
drawLogoAnimation i = do
  [drawMatrix (writtenCube (Base.rows `div` 2 - 6) (Base.cols `div` 2 - 44) ("Logo_" ++ show i) False Base.cube_matrix filledMatrix)] ++ 
    [sleep 0.07] ++
    drawLogoAnimation (i + 1)

main :: IO()
main = do
  mapM_ (Base.enganaMain) (drawLogoAnimation 0)
  --drawMatrix (writtenCube 0 (Base.cols `div` 2 - 44) "Logo_0" False Base.cube_matrix filledMatrix)
  --print (writeText 3 10 "Icaro" (fromMaybe [""] (Map.lookup "0Left_0" Base.loadAnimations)))
