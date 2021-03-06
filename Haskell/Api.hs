module Api where

import Data.Maybe (fromMaybe)
import qualified Base as Base
import qualified Data.Map.Strict as Map
import System.IO.Unsafe                                        
import System.Random
import Debug.Trace
import System.Sleep
import System.IO
import Data.List


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
  writeText (i + 21) j "Pressione J para Jogar"
    (writeText (i + 20) j "Pressione M para voltar ao Menu"
    (writeText (i + 19) j "Pressione X para embaralhar o cubo"
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
    (writeText i j "7 - Rotaciona 1a linha em sentido horario" matrix))))))))))))))))))))

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

writeLogicalMatrix :: Int -> Int -> [[Int]] -> [String] -> [String]
writeLogicalMatrix i j logicalMatrix matrix = do
  let a = writeText (i) j (Base.colorizeLogicalLine (genericIndex logicalMatrix 0)) matrix
  let b = writeText (i + 1) j (Base.colorizeLogicalLine (genericIndex logicalMatrix 1)) a
  let c = writeText (i + 2) j (Base.colorizeLogicalLine (genericIndex logicalMatrix 2)) b
  let d = writeText (i + 3) j (Base.colorizeLogicalLine (genericIndex logicalMatrix 3)) c
  let e = writeText (i + 4) j (Base.colorizeLogicalLine (genericIndex logicalMatrix 4)) d
  let f = writeText (i + 5) j (Base.colorizeLogicalLine (genericIndex logicalMatrix 5)) e
  let g = writeText (i + 6) j (Base.colorizeLogicalLine (genericIndex logicalMatrix 6)) f
  let h = writeText (i + 7) j (Base.colorizeLogicalLine (genericIndex logicalMatrix 7)) g
  let ii = writeText (i + 8) j (Base.colorizeLogicalLine (genericIndex logicalMatrix 8)) h
  let jj = writeText (i + 9) j (Base.colorizeLogicalLine (genericIndex logicalMatrix 9)) ii
  let k = writeText (i + 10) j (Base.colorizeLogicalLine (genericIndex logicalMatrix 10)) jj
  writeText (i + 11) j (Base.colorizeLogicalLine (genericIndex logicalMatrix 11)) k

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
