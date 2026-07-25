module Main where

import qualified Data.ByteString.Char8 as BS

main :: IO ()
main = do
  line <- BS.getLine
  let Just (n, _) = BS.readInt line
  print n
