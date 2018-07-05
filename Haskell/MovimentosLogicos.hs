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
giraFaceAntiHorario lIni cIni lFim cFim = 
    let a = getMatrixLine lIni cFim cFim-1 cIni cubeMatrix
        b = getMatrixCol cFim lIni lFim-1 lFim cubeMatrix
        c = getMatrixLine lFim cFim cFim-1 cIni cubeMatrix
        d = getMatrixCol cIni lIni lFim-1 lFim

    swapL lIni cIni cFim b cubeMatrix
    swapC cFim lIni lFim c cubeMatrix
    swapL lFim cIni cFim d cubeMatrix
    swapC cIni lIni cFim a cubeMatrix

