module Main where

import qualified Data.ByteString.Char8 as BS

main :: IO ()
main = do
  s <- BS.getLine
  let r = BS.elemIndex 'R' s
      m = BS.elemIndex 'M' s
  case (r, m) of
    (Just ri, Just mi) -> putStrLn $ if ri < mi then "Yes" else "No"
    _ -> pure ()
