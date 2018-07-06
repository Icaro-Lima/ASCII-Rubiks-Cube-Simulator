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
    
    zeroEsq :: [[Int]] -> [[Int]]
    zeroEsq matrix = do
      let a = getMatrixLine 3 0 1 2 matrix
      let b = getMatrixLine 3 3 4 5 matrix
      let c = getMatrixLine 3 6 7 8 matrix
      let d = getMatrixLine 11 3 4 5 matrix
      
      let xx = swapL 3 0 2 b matrix
      let yy = swapL 3 3 5 c xx
      let zz = swapL 3 6 8 d yy
      let kk = swapL 11 3 5 a zz
      
      giraFaceHorario 0 3 2 5 kk  
    
    zeroDir :: [[Int]] -> [[Int]]
    zeroDir matrix = do
      let a = getMatrixLine 3 0 1 2 matrix
      let b = getMatrixLine 3 3 4 5 matrix
      let c = getMatrixLine 3 6 7 8 matrix
      let d = getMatrixLine 11 3 4 5 matrix
      
      let xx = swapL 3 0 2 d matrix
      let yy = swapL 3 3 5 a xx
      let zz = swapL 3 6 8 b yy
      let kk = swapL 11 3 5 c zz
      
      giraFaceAntiHorario 0 3 2 5 kk  
      
    umEsq :: [[Int]] -> [[Int]]
    umEsq matrix = do
      let a = getMatrixLine 4 0 1 2 matrix
      let b = getMatrixLine 4 3 4 5 matrix
      let c = getMatrixLine 4 6 7 8 matrix
      let d = getMatrixLine 10 3 4 5 matrix
      
      let xx = swapL 4 0 2 b matrix
      let yy = swapL 4 3 5 c xx
      let zz = swapL 4 6 8 d yy
      swapL 10 3 5 a zz
    
    umDir :: [[Int]] -> [[Int]]
    umDir matrix = do
      let a = getMatrixLine 4 0 1 2 matrix
      let b = getMatrixLine 4 3 4 5 matrix
      let c = getMatrixLine 4 6 7 8 matrix
      let d = getMatrixLine 10 3 4 5 matrix
      
      let xx = swapL 4 0 2 d matrix
      let yy = swapL 4 3 5 a xx
      let zz = swapL 4 6 8 b yy
      swapL 10 3 5 c zz
      
    doisEsq :: [[Int]] -> [[Int]]
    doisEsq matrix = do
      let a = getMatrixLine 5 0 1 2 matrix
      let b = getMatrixLine 5 3 4 5 matrix
      let c = getMatrixLine 5 6 7 8 matrix
      let d = getMatrixLine 9 3 4 5 matrix
      
      let xx = swapL 5 0 2 b matrix
      let yy = swapL 5 3 5 c xx
      let zz = swapL 5 6 8 d yy
      let kk = swapL 9 3 5 a zz
      
      giraFaceAntiHorario 6 3 8 5 kk  
    
    doisDir :: [[Int]] -> [[Int]]
    doisDir matrix = do
      let a = getMatrixLine 5 0 1 2 matrix
      let b = getMatrixLine 5 3 4 5 matrix
      let c = getMatrixLine 5 6 7 8 matrix
      let d = getMatrixLine 9 3 4 5 matrix
      
      let xx = swapL 5 0 2 d matrix
      let yy = swapL 5 3 5 a xx
      let zz = swapL 5 6 8 b yy
      let kk = swapL 9 3 5 c zz
      
      giraFaceHorario 6 3 8 5 kk  
      
    aCima :: [[Int]] -> [[Int]]
    aCima matrix = do
      let a = getMatrixCol 3 0 1 2 matrix
      let b = getMatrixCol 3 3 4 5 matrix
      let c = getMatrixCol 3 6 7 8 matrix
      let d = getMatrixCol 3 9 10 11 matrix
      
      let xx = swapC 3 0 2 b matrix
      let yy = swapC 3 3 5 c xx
      let zz = swapC 3 6 8 d yy
      let kk = swapC 3 9 11 a zz
      
      giraFaceAntiHorario 3 0 5 2 kk 
      
    bCima :: [[Int]] -> [[Int]]
    bCima matrix = do
      let a = getMatrixCol 4 0 1 2 matrix
      let b = getMatrixCol 4 3 4 5 matrix
      let c = getMatrixCol 4 6 7 8 matrix
      let d = getMatrixCol 4 9 10 11 matrix
      
      let xx = swapC 4 0 2 b matrix
      let yy = swapC 4 3 5 c xx
      let zz = swapC 4 6 8 d yy
      swapC 4 9 11 a zz 
      
    cCima :: [[Int]] -> [[Int]]
    cCima matrix = do
      let a = getMatrixCol 5 0 1 2 matrix
      let b = getMatrixCol 5 3 4 5 matrix
      let c = getMatrixCol 5 6 7 8 matrix
      let d = getMatrixCol 5 9 10 11 matrix
      
      let xx = swapC 5 0 2 b matrix
      let yy = swapC 5 3 5 c xx
      let zz = swapC 5 6 8 d yy
      let kk = swapC 5 9 11 a zz 
      
      giraFaceHorario 3 6 5 8 kk
 
 
{-
	vector<int> a = getMatrixCol(5, 0, 1, 2);
	vector<int> b = getMatrixCol(5, 3, 4, 5);
	vector<int> c = getMatrixCol(5, 6, 7, 8);
	vector<int> d = getMatrixCol(5, 9, 10, 11);
		
	swapC(5, 0, 2, b);
	swapC(5, 3, 5, c);
	swapC(5, 6, 8, d);
	swapC(5, 9, 11, a);
		
	giraFaceHorario(3, 6, 5, 8);
-}


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
