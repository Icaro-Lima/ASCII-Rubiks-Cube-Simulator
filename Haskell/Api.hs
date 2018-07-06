module Api where

import Data.Maybe (fromMaybe)
import qualified Base as Base
import qualified Data.Map.Strict as Map
import System.IO.Unsafe                                        
import System.Random
import Debug.Trace
import System.Sleep
import System.IO


-- |Retorna o primeiro caractere lido da lista de caracteres.
waitKey :: [Char] -> Char
waitKey valid = do
  let c = unsafePerformIO (getChar)
    
  if elem c valid
  then c
  else waitKey valid
  
hGetLines' :: IO Char
hGetLines' = unsafeInterleaveIO $ do
    readable <- hIsReadable stdin
    if readable
        then do
            x  <- hGetChar stdin
            xs <- hGetLines'
            return x
        else return ' '

{-|
  Escreve texto a partir de uma determinada posição.
  Int :      Posição i na matriz.
  Int :      Posição j na matriz.
  String :   Texto a ser escrito.
  [String] : Estado atual da matriz.
-}
writeText :: Int -> Int -> String -> [String] -> [String]
writeText i j text matrix = Base.writeTextAux i 0 j text matrix

writeInstructions :: Int -> Int -> Bool -> [String] -> [String]
writeInstructions i j inGame matrix= do
  writeText (i + 20) j "Pressione J para Jogar"
    (writeText (i + 19) j "Pressione M para voltar ao Menu"
    (writeText (i + 17) j "H - Rotaciona 3a face em sentido anti-horario"
    (writeText (i + 16) j "G - Rotaciona 2a face em sentido anti-horario"
    (writeText (i + 15) j "F - Rotaciona 1a face em sentido anti-horario"
    (writeText (i + 14) j "Y - Rotaciona 3a face em sentido horario"
    (writeText (i + 13) j "T - Rotaciona 2a face em sentido horario"
    (writeText (i + 12) j "R - Rotaciona 1a face em sentido horario"
    (writeText (i + 11) j "D - Rotaciona 3a coluna para baixo"
    (writeText (i + 10) j "S - Rotaciona 2a coluna para baixo"
    (writeText (i + 9) j "A - Rotaciona 1a coluna para baixo"
    (writeText (i + 8) j "E - Rotaciona 3a coluna para cima"
    (writeText (i + 7) j "W - Rotaciona 2a coluna para cima"
    (writeText (i + 6) j "Q - Rotaciona 1a coluna para cima"
    (writeText (i + 5) j "3 - Rotaciona 3a linha em sentido anti-horario"
    (writeText (i + 4) j "1 - Rotaciona 3a linha em sentido horario"
    (writeText (i + 3) j "6 - Rotaciona 2a linha em sentido anti-horario"
    (writeText (i + 2) j "4 - Rotaciona 2a linha em sentido horario"
    (writeText (i + 1) j "9 - Rotaciona 1a linha em sentido anti-horario"
    (writeText i j "7 - Rotaciona 1a linha em sentido horario" matrix)))))))))))))))))))

-- |Escreve um cubo colorido na matriz de entrada e retorna uma nova matriz.
writtenCube :: Int -> Int -> String -> Bool -> [[Int]] -> [String] -> [String]
writtenCube i j animation instructions matrixOfColors matrix = do
  let matrixWithInstructions = if instructions
                               then writeInstructions 1 0 True matrix
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
  --mapM_ (Base.enganaMain) (drawLogoAnimation 0)
  drawMatrix (writtenCube 0 (Base.cols `div` 2 - 44) "Default" True Base.cube_matrix filledMatrix)
  --print (writeText 3 10 "Icaro" (fromMaybe [""] (Map.lookup "0Left_0" Base.loadAnimations)))
