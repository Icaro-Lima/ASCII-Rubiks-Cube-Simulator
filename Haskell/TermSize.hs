{-# LINE 1 "TermSize.hsc" #-}
{-# LANGUAGE ForeignFunctionInterface #-}
{-# LINE 2 "TermSize.hsc" #-}

module TermSize (getTermSize) where

import Foreign
import Foreign.C.Error
import Foreign.C.Types


{-# LINE 10 "TermSize.hsc" #-}

{-# LINE 11 "TermSize.hsc" #-}

-- Trick for calculating alignment of a type, taken from
-- http://www.haskell.org/haskellwiki/FFICookBook#Working_with_structs

{-# LINE 15 "TermSize.hsc" #-}

-- The ws_xpixel and ws_ypixel fields are unused, so I've omitted them here.
data WinSize = WinSize { wsRow, wsCol :: CUShort }

instance Storable WinSize where
  sizeOf _ = ((8))
{-# LINE 21 "TermSize.hsc" #-}
  alignment _ = (2) 
{-# LINE 22 "TermSize.hsc" #-}
  peek ptr = do
    row <- ((\hsc_ptr -> peekByteOff hsc_ptr 0)) ptr
{-# LINE 24 "TermSize.hsc" #-}
    col <- ((\hsc_ptr -> peekByteOff hsc_ptr 2)) ptr
{-# LINE 25 "TermSize.hsc" #-}
    return $ WinSize row col
  poke ptr (WinSize row col) = do
    ((\hsc_ptr -> pokeByteOff hsc_ptr 0)) ptr row
{-# LINE 28 "TermSize.hsc" #-}
    ((\hsc_ptr -> pokeByteOff hsc_ptr 2)) ptr col
{-# LINE 29 "TermSize.hsc" #-}

foreign import ccall "sys/ioctl.h ioctl"
  ioctl :: CInt -> CInt -> Ptr WinSize -> IO CInt

-- | Return current number of (rows, columns) of the terminal.
getTermSize :: IO (Int, Int)
getTermSize = 
  with (WinSize 0 0) $ \ws -> do
    throwErrnoIfMinus1 "ioctl" $
      ioctl (1) (21523) ws
{-# LINE 39 "TermSize.hsc" #-}
    WinSize row col <- peek ws
    return (fromIntegral row, fromIntegral col)
