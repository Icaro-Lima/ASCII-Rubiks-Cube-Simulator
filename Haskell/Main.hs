import qualified Base as Base
import qualified Api as Api
import System.Sleep
import System.IO.Unsafe (unsafeDupablePerformIO)
import System.IO

startGame :: IO()
startGame = do
  let bemVindo = "Bem vindo ao Rubik Cube Simulator!"
  
  let logicalMatrix = Base.cube_matrix
  
  let a = Api.writeText 2 ((Base.cols `div` 2) - ((length bemVindo) `div` 2)) bemVindo Api.filledMatrix
  let b = Api.writtenCube 2 Base.cubo_mid_col "Default" True logicalMatrix a

  Api.drawMatrix b

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

menuOptions :: [IO()]
menuOptions = do

  let input = Api.waitKey ['i','I','j','J','m','M']
  
  [hWaitForInput stdin 1000] ++
    (if input == 'i' || input == 'I' then ([Api.drawMatrix (Api.writeInstructions 5 (div Base.cols 2) False Api.filledMatrix)] ++ [sleep 0.7] ++ menuOptions)
    else if input == 'm' || input == 'M' then ([drawMenu] ++ [sleep 0.7] ++ menuOptions)
    else if input == 'j' || input == 'J' then ([startGame] ++ [sleep 0.7] ++ menuOptions)
    else menuOptions)

main :: IO()
main = do
  --mapM_ (Base.enganaMain) (Api.drawLogoAnimation 0)
  drawMenu
  mapM_ (Base.enganaMain) menuOptions
