module MovimentosLogicos where

    import Data.List
    import qualified Base as Base
    
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
    
    
    swapL :: Int -> Int -> Int -> [Int] -> [[Int]] -> [[Int]]
    swapL i comeco fim array logicalMatrix = do
      let linha = genericIndex logicalMatrix i
      
      take i logicalMatrix ++
        [(take comeco linha) ++ array ++ (drop (fim + 1) linha)] ++
        drop (i + 1) logicalMatrix
    
    swapC :: Int -> Int -> Int -> [Int] -> [[Int]] -> [[Int]]
    swapC j comeco fim array logicalMatrix = do
      let line0 = genericIndex logicalMatrix comeco
      let line1 = genericIndex logicalMatrix (comeco + 1)
      let line2 = genericIndex logicalMatrix fim
    
      (take comeco logicalMatrix) ++ 
        [(take j line0) ++ [((!!) array 0)] ++ (drop (j + 1) line0)] ++ 
        [(take j line1) ++ [((!!) array 1)] ++ (drop (j + 1) line1)] ++ 
        [(take j line2) ++ [((!!) array 2)] ++ (drop (j + 1) line2)] ++ 
        (drop (fim + 1) logicalMatrix)
    
    giraFaceAntiHorario :: Int -> Int -> Int -> Int -> [[Int]] -> [[Int]]
    giraFaceAntiHorario lIni cIni lFim cFim matrix = do
      let a = getMatrixLine lIni cFim (cFim - 1) cIni matrix
      let b = getMatrixCol cFim lIni (lFim - 1) lFim matrix
      let c = getMatrixLine lFim cFim (cFim - 1) cIni matrix
      let d = getMatrixCol cIni lIni (lFim - 1) lFim matrix
      
      swapL lIni cIni cFim b
        (swapC cFim lIni lFim c
        (swapL lFim cIni cFim d
        (swapC cIni lIni lFim a matrix)))

    giraFaceHorario :: Int -> Int -> Int -> Int -> [[Int]] -> [[Int]]
    giraFaceHorario lIni cIni lFim cFim matrix = do
      let a = getMatrixLine lIni cIni (cFim - 1) cFim matrix
      let b = getMatrixCol cFim lFim (lFim - 1) lIni matrix
      let c = getMatrixLine lFim cIni (cFim - 1) cFim matrix
      let d = getMatrixCol cIni lFim (lFim - 1) lIni matrix
      
      swapL lIni cIni cFim d
        (swapC cIni lIni lFim c
        (swapL lFim cIni cFim b
        (swapC cFim lIni lFim a matrix)))
        
    aAntiHorario :: [[Int]] -> [[Int]]
    aAntiHorario matrix = do
      let a = getMatrixLine 2 5 4 3 matrix
      let b = getMatrixCol 6 3 4 5 matrix
      let c = getMatrixLine 6 5 4 3 matrix
      let d = getMatrixCol 2 3 4 5 matrix
      
      let xx = swapL 2 3 5 b matrix
      let yy = swapC 6 3 5 c xx
      let zz =  swapL 6 3 5 d yy
      let kk = swapC 2 3 5 a zz
      
      giraFaceAntiHorario 3 3 5 5 kk

    aHorario :: [[Int]] -> [[Int]]
    aHorario matrix = do
      let a = getMatrixLine 2 3 4 5 matrix
      let b = getMatrixCol 6 5 4 3 matrix
      let c = getMatrixLine 6 3 4 5 matrix
      let d = getMatrixCol 2 5 4 3 matrix
      
      let xx = swapL 2 3 5 d matrix
      let yy = swapC 2 3 5 c xx
      let zz =  swapL 6 3 5 b yy
      let kk = swapC 6 3 5 a zz
      
      giraFaceHorario 3 3 5 5 kk

    bAntiHorario :: [[Int]] -> [[Int]]
    bAntiHorario matrix = do
      let a = getMatrixLine 1 5 4 3 matrix
      let b = getMatrixCol 7 3 4 5 matrix
      let c = getMatrixLine 7 5 4 3 matrix
      let d = getMatrixCol 1 3 4 5 matrix
      
      let xx = swapL 1 3 5 b matrix
      let yy = swapC 7 3 5 c xx
      let zz = swapL 7 3 5 d yy
      swapC 1 3 5 a zz

    bHorario :: [[Int]] -> [[Int]]
    bHorario matrix = do
      let a = getMatrixLine 1 5 4 3 matrix
      let b = getMatrixCol 7 3 4 5 matrix
      let c = getMatrixLine 7 5 4 3 matrix
      let d = getMatrixCol 1 3 4 5 matrix
      
      let xx = swapL 1 3 5 d matrix
      let yy = swapC 1 3 5 c xx
      let zz = swapL 7 3 5 b yy
      swapC 7 3 5 a zz  
    

    cAntiHorario :: [[Int]] -> [[Int]]
    cAntiHorario matrix = do
      let a = getMatrixLine 0 5 4 3 matrix
      let b = getMatrixCol 8 3 4 5 matrix
      let c = getMatrixLine 8 5 4 3 matrix
      let d = getMatrixCol 0 3 4 5 matrix
      
      let xx = swapL 0 3 5 b matrix
      let yy = swapC 8 3 5 c xx
      let zz = swapL 8 3 5 d yy
      let kk = swapC 0 3 5 a zz 
      
      giraFaceHorario 9 3 11 5 kk
      
    cHorario :: [[Int]] -> [[Int]]
    cHorario matrix = do
      let a = getMatrixLine 0 3 4 5 matrix
      let b = getMatrixCol 8 5 4 3 matrix
      let c = getMatrixLine 8 3 4 5 matrix
      let d = getMatrixCol 0 5 4 3 matrix
      
      let xx = swapL 0 3 5 d matrix
      let yy = swapC 0 3 5 c xx
      let zz = swapL 8 3 5 b yy
      let kk = swapC 8 3 5 a zz
      
      giraFaceHorario 9 3 11 5 kk


    main :: IO()
    main = do
      print "===== Base ====="
      mapM_ (print) Base.cube_matrix
      print "================"
      print "===== aAH ====="
      mapM_ (print) (aAntiHorario Base.cube_matrix)
      print "================"
      print "===== aH  ====="
      mapM_ (print) (aHorario Base.cube_matrix)
      print "================"
      print "===== bAH  ====="
      mapM_ (print) (bAntiHorario Base.cube_matrix)
      print "================"
      print "===== bH  ====="
      mapM_ (print) (bHorario Base.cube_matrix)
      print "================"
      print "===== cAH  ====="
      mapM_ (print) (cAntiHorario Base.cube_matrix)
      print "================"
      
    
    
      print "Works!"
