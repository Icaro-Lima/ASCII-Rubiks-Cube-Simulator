-- |Auxiliar!
getMatrixLine :: Int -> Int -> Int -> Int -> [[Int]] -> [Int]
getMatrixLine linha a b c cubeMatrix = do
  let line = genericIndex cubeMatrix linha
  
  [genericIndex line a] ++ 
    [genericIndex line b] ++ 
    [genericIndex line c]

-- |Auxiliar!
getMatrixCol :: Int -> Int -> Int -> Int -> [[Int]] -> [Int]
getMatrixCol coluna a b c cubeMatrix = 
  [genericIndex (genericIndex cubeMatrix a) coluna] ++ 
  [genericIndex (genericIndex cubeMatrix b) coluna] ++ 
  [genericIndex (genericIndex cubeMatrix c) coluna]


giraFaceAntiHorario :: Int -> Int -> Int -> Int -> [[Int]] -> [Int]
giraFaceAntiHorario lIni cIni lFim cFim cubeMatrix = 
    let a = getMatrixLine lIni cFim cFim-1 cIni cubeMatrix
        b = getMatrixCol cFim lIni lFim-1 lFim cubeMatrix
        c = getMatrixLine lFim cFim cFim-1 cIni cubeMatrix
        d = getMatrixCol cIni lIni lFim-1 lFim

    swapL lIni cIni cFim b cubeMatrix
    swapC cFim lIni lFim c cubeMatrix
    swapL lFim cIni cFim d cubeMatrix
    swapC cIni lIni cFim a cubeMatrix

giraFaceHorario :: Int -> Int -> Int -> Int -> [[Int]] -> [Int]
giraFaceHorario lIni cIni lFim cFim cubeMatrix =
    let a = getMatrixLine lIni cIni cFim-1 cFim cubeMatrix
        b = getMatrixCol cFim lFim lFim-1 lIni cubeMatrix
        c = getMatrixLine lFim cIni cFim-1 cFim cubeMatrix
        d = getMatrixCol cIni lFim lFim-1 lIni cubeMatrix

    swapL lIni cIni cFim d cubeMatrix
    swapC cIni lIni lFim c cubeMatrix
    swapL lFim cIni cFim b cubeMatrix
    swapC cFim lIni lFim a cubeMatrix

aAntiHorario :: [[Int]] -> [Int]
aAntiHorario cubeMatrix = 
    let a = getMatrixLine 2 5 4 3 cubeMatrix
        b = getMatrixCol 6 3 4 5 cubeMatrix
        c = getMatrixLine 6 5 4 3 cubeMatrix
        d = getMatrixCol 2 3 4 5 cubeMatrix


    swapL 2 3 5 b cubeMatrix
    swapC 6 3 5 c cubeMatrix
    swapL 6 3 5 d cubeMatrix
    swapC 2 3 5 a cubeMatrix

    giraFaceAntiHorario 3 3 5 5 cubeMatrix





