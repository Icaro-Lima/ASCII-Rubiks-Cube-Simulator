import qualified Base as Base
import qualified Api as Api
import qualified MovimentosLogicos as ML
import System.Sleep
import System.IO.Unsafe (unsafeDupablePerformIO)
import System.IO
import System.IO.Unsafe                                        
import System.Random

gameLoop :: [[Int]] -> IO()
gameLoop logicalMatrix = do
  
  Api.drawMatrix (Api.writtenCube Base.cube_origin_row Base.cubo_mid_col "Default" True logicalMatrix Api.filledMatrix)

  hSetBuffering stdin NoBuffering

  command <- getChar
  
  hSetBuffering stdin LineBuffering
  
  if command == '7' || command == '7' then
    rotateCube "0Left_" logicalMatrix
  else if command == '9' || command == '9' then
    rotateCube "0Right_" logicalMatrix
  else if command == '4' || command == '4' then
    rotateCube "1Left_" logicalMatrix
  else if command == '6' || command == '6' then
    rotateCube "1Right_" logicalMatrix
  else if command == '1' || command == '1' then
    rotateCube "2Left_" logicalMatrix
  else if command == '3' || command == '3' then
    rotateCube "2Right_" logicalMatrix
  else if command == 'Q' || command == 'q' then
    rotateCube "AUp_" logicalMatrix
  else if command == 'W' || command == 'w' then
    rotateCube "BUp_" logicalMatrix
  else if command == 'E' || command == 'e' then
    rotateCube "CUp_" logicalMatrix
  else if command == 'A' || command == 'a' then
    rotateCube "ADown_" logicalMatrix
  else if command == 'S' || command == 's' then
    rotateCube "BDown_" logicalMatrix
  else if command == 'D' || command == 'd' then
    rotateCube "CDown_" logicalMatrix
  else if command == 'R' || command == 'r' then
    rotateCube "aClockwise_" logicalMatrix
  else if command == 'T' || command == 't' then
    rotateCube "bClockwise_" logicalMatrix
  else if command == 'Y' || command == 'y' then
    rotateCube "cClockwise_" logicalMatrix
  else if command == 'F' || command  == 'f' then
    rotateCube "aCounterclockwise_" logicalMatrix
  else if command == 'G' || command  == 'g' then
    rotateCube "bCounterclockwise_" logicalMatrix
  else if command == 'H' || command  == 'h' then
    rotateCube "cCounterclockwise_" logicalMatrix
  else if command == 'M' || command == 'm' then
    menuOptions True
  else if command == 'X' || command == 'x' then
    shuffle 20 logicalMatrix  
  else
    rotateCube "" logicalMatrix
    

  gameLoop logicalMatrix
  
rotateCube :: String -> [[Int]] -> IO()
rotateCube movement logicalMatrix = do

  Api.drawMatrix (Api.writtenCube Base.cube_origin_row Base.cubo_mid_col (movement ++ "0") True logicalMatrix Api.filledMatrix)
  sleep 0.03
  Api.drawMatrix (Api.writtenCube Base.cube_origin_row Base.cubo_mid_col (movement ++ "1") True logicalMatrix Api.filledMatrix)
  sleep 0.03
  Api.drawMatrix (Api.writtenCube Base.cube_origin_row Base.cubo_mid_col (movement ++ "2") True logicalMatrix Api.filledMatrix)
  sleep 0.03
  Api.drawMatrix (Api.writtenCube Base.cube_origin_row Base.cubo_mid_col (movement ++ "3") True logicalMatrix Api.filledMatrix)
  sleep 0.03
  Api.drawMatrix (Api.writtenCube Base.cube_origin_row Base.cubo_mid_col (movement ++ "4") True logicalMatrix Api.filledMatrix)
  sleep 0.03
  
  if movement == "0Left_" then
    gameLoop (ML.zeroEsq logicalMatrix)
  else if movement == "0Right_" then
    gameLoop (ML.zeroDir logicalMatrix)
  else if movement == "1Left_" then
    gameLoop (ML.umEsq logicalMatrix)
  else if movement == "1Right_" then
    gameLoop (ML.umDir logicalMatrix)
  else if movement == "2Left_" then
    gameLoop (ML.doisEsq logicalMatrix) 
  else if movement == "2Right_" then
    gameLoop (ML.doisDir logicalMatrix)  
  else if movement == "AUp_" then
    gameLoop (ML.aCima logicalMatrix)  
  else if movement == "BUp_" then
    gameLoop (ML.bCima logicalMatrix)  
  else if movement == "CUp_" then
    gameLoop (ML.cCima logicalMatrix)  
  else if movement == "ADown_" then
    gameLoop (ML.aBaixo logicalMatrix)  
  else if movement == "BDown_" then
    gameLoop (ML.bBaixo logicalMatrix)  
  else if movement == "CDown_" then
    gameLoop (ML.cBaixo logicalMatrix)  
  else if movement == "aClockwise_" then
    gameLoop (ML.aHorario logicalMatrix)
  else if movement == "bClockwise_" then
    gameLoop (ML.bHorario logicalMatrix)
  else if movement == "cClockwise_" then
    gameLoop (ML.cHorario logicalMatrix)
  else if movement == "aCounterclockwise_" then
    gameLoop (ML.aAntiHorario logicalMatrix)
  else if movement == "bCounterclockwise_" then
    gameLoop (ML.bAntiHorario logicalMatrix)
  else if movement == "cCounterclockwise_" then
    gameLoop (ML.cAntiHorario logicalMatrix)
  else
    gameLoop logicalMatrix

startGame :: IO()
startGame = do
  let bemVindo = "Bem vindo ao Rubik Cube Simulator!"
  
  let logicalMatrix = Base.cube_matrix
  
  let a = Api.writeText 2 ((Base.cols `div` 2) - ((length bemVindo) `div` 2)) bemVindo Api.filledMatrix
  let b = Api.writtenCube Base.cube_origin_row Base.cubo_mid_col "Default" True logicalMatrix a

  Api.drawMatrix b
  
  gameLoop Base.cube_matrix

drawMenu :: IO()
drawMenu = do
  let gName = "-----------------------  RUBIK CUBE SIMULATOR -----------------------"
  let opcao1 = "Pressione I para Instruções"
  let opcao2 = "Pressione J para Jogar"
  let teamName = "Icaro Dantas, Igor Farias, Javan Lacerda, Lucas Araújo, Sérgio Duarte"
  
  let x = Api.writeText 5 ((div Base.cols 2) - (div (length gName) 2)) gName Api.filledMatrix
  let y = Api.writeText 8 ((div Base.cols 2) - (div (length opcao1) 2)) opcao1 x
  let z = Api.writeText 9 ((div Base.cols 2) - (div (length opcao2) 2)) opcao2 y
  let k = Api.writeText 11 ((div Base.cols 2) - (div (length teamName) 2)) teamName z

  
  Api.drawMatrix k

menuOptions :: Bool -> IO()
menuOptions menu = do

  if menu then
    drawMenu
  else
    putStr ""

  hSetBuffering stdin NoBuffering

  input <- getChar
  
  hSetBuffering stdin LineBuffering
  
  if input == 'i' || input == 'I' then Api.drawMatrix (Api.writeInstructions 5 (div Base.cols 2) False Api.filledMatrix)
  else if input == 'm' || input == 'M' then drawMenu
  else if input == 'j' || input == 'J' then startGame
  else menuOptions False
    
  menuOptions False

moveSelect :: Int -> [[Int]] ->IO()
moveSelect x logicalMatrix
  | x == 1 = rotateCube "0Left_" logicalMatrix
  | x == 2 = rotateCube "0Right_" logicalMatrix
  | x == 3 = rotateCube "1Left_" logicalMatrix
  | x == 4 = rotateCube "1Right_" logicalMatrix
  | x == 5 = rotateCube "2Left_" logicalMatrix
  | x == 6 = rotateCube "2Right_" logicalMatrix
  | x == 7 = rotateCube "AUp_" logicalMatrix
  | x == 8 = rotateCube "BUp_" logicalMatrix
  | x == 9 = rotateCube "CUp_" logicalMatrix
  | x == 10 = rotateCube "ADown_" logicalMatrix
  | x == 11 = rotateCube "BDown_" logicalMatrix
  | x == 12 = rotateCube "CDown_" logicalMatrix
  | x == 13 = rotateCube "aClockwise_" logicalMatrix
  | x == 14 = rotateCube "bClockwise_" logicalMatrix
  | x == 15 = rotateCube "cClockwise_" logicalMatrix
  | x == 16 = rotateCube "aCounterclockwise_" logicalMatrix
  | x == 17 = rotateCube "bCounterclockwise_" logicalMatrix
  | otherwise = rotateCube "cCounterclockwise_" logicalMatrix

shuffle 0 _ = return ()
shuffle n logicalMatrix =
  do
    moveSelect (unsafePerformIO (getStdRandom (randomR (0, 18)))) logicalMatrix
    shuffle (n-1) logicalMatrix


main :: IO()
main = do
  mapM_ (Base.enganaMain) (Api.drawLogoAnimation 0)
  menuOptions True
