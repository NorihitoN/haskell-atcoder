module Main where

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

main :: IO ()
main = do
  (h, w) <- getIntPair
  putStrLn $ if fromIntegral h * fromIntegral h * 25.0 <= fromIntegral w * 10000.0 then "Yes" else "No"
