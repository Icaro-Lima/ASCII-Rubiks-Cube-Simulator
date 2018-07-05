
draw_menu = do
    putStrLn "-----------------------  RUBIK CUBE SIMULATOR -----------------------"
    putStrLn "Pressione I para Instruções"
    putStrLn "Pressione J para Jogar"
    putStrLn "Pressione ESC para Sair"
    putStrLn "Icaro Dantas, Igor Farias, Javan Lacerda, Lucas Araújo, Sérgio Duarte"


draw_instructions = do
    putStrLn "7 - Rotaciona 1a linha em sentido horario"
    putStrLn "9 - Rotaciona 1a linha em sentido anti-horario"
    putStrLn "4 - Rotaciona 2a linha em sentido horario"
    putStrLn "6 - Rotaciona 2a linha em sentido anti-horario"
    putStrLn "1 - Rotaciona 3a linha em sentido horario"
    putStrLn "3 - Rotaciona 3a linha em sentido anti-horario"
    putStrLn "Q - Rotaciona 1a coluna para cima"
    putStrLn "W - Rotaciona 2a coluna para cima"
    putStrLn "E - Rotaciona 3a coluna para cima"
    putStrLn "A - Rotaciona 1a coluna para baixo"
    putStrLn "S - Rotaciona 2a coluna para baixo"
    putStrLn "D - Rotaciona 3a coluna para baixo"
    putStrLn "R - Rotaciona 1a face em sentido horario"
    putStrLn "T - Rotaciona 2a face em sentido horario"
    putStrLn "Y - Rotaciona 3a face em sentido horario"
    putStrLn "F - Rotaciona 1a face em sentido anti-horario"
    putStrLn "G - Rotaciona 2a face em sentido anti-horario"
    putStrLn "H - Rotaciona 3a face em sentido anti-horario"
    putStrLn "X - Embaralha o cubo"
    putStrLn "ESC - Sair do jogo"
    putStrLn "Pressione M para voltar ao Menu"

main :: IO()
main = do
    draw_instructions