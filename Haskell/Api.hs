import Data.Maybe (fromMaybe)
import qualified Base as Base
import qualified Data.Map.Strict as Map

{-|
  Escreve texto a partir de uma determinada posição.
  Int :      Posição i na matriz.
  Int :      Posição j na matriz.
  String :   Texto a ser escrito.
  [String] : Estado atual da matriz.
-}
writeText :: Int -> Int -> String -> [String] -> [String]
writeText i j text matrix = Base.writeTextAux i 0 j text matrix

drawMatrix :: [String] -> IO()
drawMatrix strs = putStr (Base.matrixToString strs)

main :: IO()
main = do
  drawMatrix (fromMaybe [""] (Map.lookup "Default" Base.loadAnimations))
  --print (writeText 3 10 "Icaro" (fromMaybe [""] (Map.lookup "0Left_0" Base.loadAnimations)))
