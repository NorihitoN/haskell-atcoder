module Main where

import Control.Monad (forM_, replicateM)
import Data.Array.IO (Ix, MArray, readArray, writeArray)
import Data.ByteString.Char8 qualified as BS

-- | Read a single Int from stdin
getInt :: IO Int
getInt = do
  line <- BS.getLine
  case BS.readInt line of
    Just (n, _) -> pure n
    Nothing -> error "getInt: parse error"

-- | Read space-separated Ints from one line
getInts :: IO [Int]
getInts = do
  line <- BS.getLine
  pure $ map (fst . maybe (error "parse") id . BS.readInt) (BS.words line)

-- | Read two Ints from one line
getIntPair :: IO (Int, Int)
getIntPair = do
  xs <- getInts
  case xs of
    [a, b] -> pure (a, b)
    _ -> error "expected pair"

-- | Print answer with newline
putAns :: (Show a) => a -> IO ()
putAns = putStrLn . show

-- | Modify a mutable array element
modifyArray :: (MArray a e m, Ix i) => a i e -> i -> (e -> e) -> m ()
modifyArray arr i f = do
  v <- readArray arr i
  writeArray arr i (f v)

-- | Loop from 0 to n-1
rep :: Int -> (Int -> IO a) -> IO [a]
rep n f = mapM f [0 .. n - 1]

-- | Loop from 0 to n-1 (discard results)
rep_ :: Int -> (Int -> IO ()) -> IO ()
rep_ n f = forM_ [0 .. n - 1] f

main :: IO ()
main = do
  n <- getInt
  rows <- replicateM n $ do
    ws <- BS.words <$> BS.getLine
    let Just (l, _) = BS.readInt (ws !! 0)
        Just (r, _) = BS.readInt (ws !! 1)
        op = BS.unpack (ws !! 2)
    pure (l, r, op)

  let ans = sum [r - l | (l, r, op) <- rows, op == "keep"]
  putAns ans
