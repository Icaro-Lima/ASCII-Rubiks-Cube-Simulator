import Data.Typeable (typeOf)
import Data.Maybe (fromMaybe)
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import System.IO.Unsafe (unsafeDupablePerformIO)

assets_path = "../Assets"
line_limit = 500

getFileLines :: String -> [String]
getFileLines path = do
  let file = unsafeDupablePerformIO (readFile path)
  lines file
  
loadAnimations :: Map String [String]
loadAnimations = do
  let cube_path = assets_path ++ "/Cubo"
  
  Map.fromList ([(movement ++ "_" ++ idx, getFileLines (cube_path ++ "/" ++ movement ++ "/" ++ idx ++ ".txt")) 
    | movement <- [a ++ b | a <- ["0","1","2"], b <- ["Left","Right"]] ++ [a ++ b | a <- ["A","B","C"], b <- ["Up","Down"]] ++ [a ++ b | a <- ["a","b","c"],
    b <- ["Clockwise","Counterclockwise"]],
    idx <- ["0","1","2","3","4"]] ++ [("Default",getFileLines (cube_path ++ "/Default.txt"))])

main :: IO()
main = do
  mapM_ (putStrLn) (fromMaybe [""] (Map.lookup "Default" (loadAnimations)))
  print "Let's go!"
