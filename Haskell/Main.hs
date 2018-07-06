import qualified Base as Base
import qualified Api as Api
import qualified MovimentosLogicos as ML
import System.Sleep
import System.IO.Unsafe (unsafeDupablePerformIO)
import System.IO

gameLoop :: [[Int]] -> IO()
gameLoop logicalMatrix = do
  
  Api.drawMatrix (Api.writtenCube Base.cube_origin_row Base.cubo_mid_col "Default" True logicalMatrix Api.filledMatrix)

  command <- getChar
  
  if command == '7' || command == '7' then
    rotateCube "0Left_" logicalMatrix
  else if command == '9' || command == '9' then
    rotateCube "0Right_" logicalMatrix
  else if command == '4' || command == '4' then
    rotateCube "1Left_" logicalMatrix
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
  let opcao3 = "Pressione ESC para Sair"
  let teamName = "Icaro Dantas, Igor Farias, Javan Lacerda, Lucas Araújo, Sérgio Duarte"
  
  let x = Api.writeText 5 ((div Base.cols 2) - (div (length gName) 2)) gName Api.filledMatrix
  let y = Api.writeText 9 ((div Base.cols 2) - (div (length opcao1) 2)) opcao1 x
  let z = Api.writeText 10 ((div Base.cols 2) - (div (length opcao2) 2)) opcao2 y
  let w = Api.writeText 12 ((div Base.cols 2) - (div (length opcao3) 2)) opcao3 z
  
  Api.drawMatrix w

menuOptions :: IO()
menuOptions = do

  input <- getChar
  
  if input == 'i' || input == 'I' then Api.drawMatrix (Api.writeInstructions 5 (div Base.cols 2) False Api.filledMatrix)
  else if input == 'm' || input == 'M' then drawMenu
  else if input == 'j' || input == 'J' then startGame
  else menuOptions
  
  sleep 0.7
  
  menuOptions

main :: IO()
main = do
  --mapM_ (Base.enganaMain) (Api.drawLogoAnimation 0)
  drawMenu
  menuOptions
