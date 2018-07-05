module Base where

import Data.Typeable (typeOf)
import Data.Maybe (fromMaybe)
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import System.IO.Unsafe (unsafeDupablePerformIO)
import TermSize

cube_matrix =
  [[000, 000, 000, 101, 101, 101, 000, 000, 000],
   [000, 000, 000, 101, 101, 101, 000, 000, 000],
   [000, 000, 000, 101, 101, 101, 000, 000, 000],
   [102, 102, 102, 103, 103, 103, 044, 044, 044],
   [102, 102, 102, 103, 103, 103, 044, 044, 044],
   [102, 102, 102, 103, 103, 103, 044, 044, 044],
   [000, 000, 000, 045, 045, 045, 000, 000, 000],
   [000, 000, 000, 045, 045, 045, 000, 000, 000],
   [000, 000, 000, 045, 045, 045, 000, 000, 000],
   [000, 000, 000, 100, 100, 100, 000, 000, 000],
   [000, 000, 000, 100, 100, 100, 000, 000, 000],
   [000, 000, 000, 100, 100, 100, 000, 000, 000]] :: [[Int]]

-- |Caminho até a pasta Assets.
assets_path = "../Assets"

animations = loadAnimations

-- |Limite do tamanho de uma linha.
line_limit = 500

-- |Número de linhas existentes no console.
size = unsafeDupablePerformIO getTermSize
rows = fst size
cols = snd size

{-|
  Retorna uma lista de strings, onde cada string corresponde a uma linha
  do arquivo lido.
-}
getFileLines :: String -> [String]
getFileLines path = do
  let file = unsafeDupablePerformIO (readFile path)
  lines file

{-|
  Carrega todas as animações do cubo: 
  0Left_0,
  2Right_4,
  ...
-}
loadAnimations :: Map String [String]
loadAnimations = do
  let cube_path = assets_path ++ "/Cubo"
  
  Map.fromList ([(movement ++ "_" ++ idx, getFileLines (cube_path ++ "/" ++ movement ++ "/" ++ idx ++ ".txt")) 
    | movement <- [a ++ b | a <- ["0","1","2"], b <- ["Left","Right"]] ++ [a ++ b | a <- ["A","B","C"], b <- ["Up","Down"]] ++ [a ++ b | a <- ["a","b","c"],
    b <- ["Clockwise","Counterclockwise"]],
    idx <- ["0","1","2","3","4"]] ++ [("Default",getFileLines (cube_path ++ "/Default.txt"))] ++ 
    [("Logo_" ++ idx,getFileLines (assets_path ++ "/Logo/" ++ idx ++ ".txt")) | idx <- map (show) [0..43]])

-- |Função auxiliar de filledMatrix, não deve ser chamada diretamente.
filledMatrixAux :: Int -> [String]
filledMatrixAux i
  | i < rows = [(replicate cols ' ') ++ (replicate (line_limit - cols) '\0')] ++ filledMatrixAux (i + 1)
  | otherwise = []

-- |Retorna uma matriz de caracteres, rows x line_limit, cada linha com
-- cols espaços e (line_limit - cols) nulls.
filledMatrix :: [String]
filledMatrix = filledMatrixAux 0

{-|
  Insere uma String em outra, na posição determinada, substituindo
  imediatamente os caracteres sobrepostos.
  String :      String a ser inserida.
  Int :      Posição para inserir.
  String :   String original.
-}
insertWithoutShift :: String -> Int -> String -> String
insertWithoutShift str j original = do
  let strSize = length str
  let originalSize = length original
  (take j original) ++ str ++ (drop (j + strSize) original)

writeTextAux :: Int -> Int -> Int -> String -> [String] -> [String]
writeTextAux i ii j text (h:t)
  | ii == i = [insertWithoutShift text j h] ++ (writeTextAux i (ii + 1) j text t)
  | otherwise = [h] ++ (writeTextAux i (ii + 1) j text t)

matrixToString :: [String] -> String
matrixToString [] = ""
matrixToString (h:t) = h ++ "\n" ++ matrixToString t

main :: IO ()
main = do
  mapM_ (putStr) filledMatrix
  print rows
  mapM_ (putStrLn) (fromMaybe [""] (Map.lookup "Logo_0" (loadAnimations)))
  print "Let's go!"
