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


aHorario :: [[Int]] -> [Int]
aHorario cubeMatrix = 
    let a = getMatrixLine 2 3 4 5 cubeMatrix
        b = getMatrixCol 6 5 4 3 cubeMatrix
        c = getMatrixLine 6 3 4 5 cubeMatrix
        d = getMatrixCol 2 5 4 3 cubeMatrix

    swapL 2 3 5 d cubeMatrix
    swapC 2 3 5 c cubeMatrix
    swapL 6 3 5 b cubeMatrix
    swapC 6 3 5 a cubeMatrix

    giraFaceHorario 3 3 5 5 cubeMatrix


bAntiHorario :: [[Int]] -> [Int]
bAntiHorario cubeMatrix = 
    let a = getMatrixLine 1 5 4 3 cubeMatrix
        b = getMatrixCol 7 3 4 5 cubeMatrix
        c = getMatrixLine 7 5 4 3 cubeMatrix
        d = getMatrixCol 1 3 4 5 cubeMatrix
	
    swapL 1 3 5 b cubeMatrix
    swapC 7 3 5 c cubeMatrix
    swapL 7 3 5 d cubeMatrix
    swapC 1 3 5 a cubeMatrix
    
bHorario :: [[Int]] -> [Int]
bHorario cubeMatrix = 
    let a = getMatrixLine 1 3 4 5 cubeMatrix
        b = getMatrixCol 7 5 4 3 cubeMatrix
        c = getMatrixLine 7 3 4 5 cubeMatrix
        d = getMatrixCol 1 5 4 3 cubeMatrix
    
    swapL 1 3 5 d cubeMatrix
    swapC 1 3 5 c cubeMatrix
    swapL 7 3 5 b cubeMatrix
    swapC 7 3 5 a cubeMatrix

cAntiHorario :: [[Int]] -> [Int]
cAntiHorario cubeMatrix = 
    let a = getMatrixLine 0 5 4 3 cubeMatrix
        b = getMatrixCol 8 3 4 5 cubeMatrix
        c = getMatrixLine 8 5 4 3 cubeMatrix
        d = getMatrixCol 0 3 4 5 cubeMatrix
    
    swapL 0 3 5 b cubeMatrix
    swapC 8 3 5 c cubeMatrix
    swapL 8 3 5 d cubeMatrix
    swapC 0 3 5 a cubeMatrix

    giraFaceHorario 9 3 11 5 cubeMatrix

cHorario :: [[Int]] -> [Int]
cHorario cubeMatrix = 
    let a = getMatrixLine 0 3 4 5 cubeMatrix
        b = getMatrixCol 8 5 4 3 cubeMatrix
        c = getMatrixLine 8 3 4 5 cubeMatrix
        d = getMatrixCol 0 5 4 3 cubeMatrix
    
    swapL 0 3 5 d cubeMatrix
    swapC 0 3 5 c cubeMatrix
    swapL 8 3 5 b cubeMatrix
    swapC 8 3 5 a cubeMatrix

    giraFaceAntiHorario 9 3 11 5 cubeMatrix


zeroEsq :: [[Int]] -> [Int]
zeroEsq cubeMatrix = 
    let a = getMatrixLine 3 0 1 2 cubeMatrix
        b = getMatrixLine 3 3 4 5 cubeMatrix
        c = getMatrixLine 3 6 7 8 cubeMatrix
        d = getMatrixLine 11 3 4 5 cubeMatrix
    
    swapL 3 0 2 b cubeMatrix
    swapL 3 3 5 c cubeMatrix
    swapL 3 6 8 d cubeMatrix
    swapL 11 3 5 a cubeMatrix

    giraFaceHorario 0 3 2 5 cubeMatrix



