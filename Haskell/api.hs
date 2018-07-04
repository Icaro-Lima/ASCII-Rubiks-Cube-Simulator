
draw_menu = do
    putStrLn "-----------------------  RUBIK CUBE SIMULATOR -----------------------"
    putStrLn "Pressione I para Instruções"
    putStrLn "Pressione J para Jogar"
    putStrLn "Pressione ESC para Sair"
    putStrLn "Icaro Dantas, Igor Farias, Javan Lacerda, Lucas Araújo, Sérgio Duarte"

main :: IO()
main = do
    draw_menu