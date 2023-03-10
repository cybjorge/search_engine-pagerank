{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_hsc2hs (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,68,8] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "D:\\cabal\\store\\ghc-8.10.7\\hsc2hs-0.68.8-00df569235e101e00888c5999c3c99d2e6b17ace\\bin"
libdir     = "D:\\cabal\\store\\ghc-8.10.7\\hsc2hs-0.68.8-00df569235e101e00888c5999c3c99d2e6b17ace\\lib"
dynlibdir  = "D:\\cabal\\store\\ghc-8.10.7\\hsc2hs-0.68.8-00df569235e101e00888c5999c3c99d2e6b17ace\\lib"
datadir    = "D:\\cabal\\store\\ghc-8.10.7\\hsc2hs-0.68.8-00df569235e101e00888c5999c3c99d2e6b17ace\\share"
libexecdir = "D:\\cabal\\store\\ghc-8.10.7\\hsc2hs-0.68.8-00df569235e101e00888c5999c3c99d2e6b17ace\\libexec"
sysconfdir = "D:\\cabal\\store\\ghc-8.10.7\\hsc2hs-0.68.8-00df569235e101e00888c5999c3c99d2e6b17ace\\etc"

getBinDir     = catchIO (getEnv "hsc2hs_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "hsc2hs_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "hsc2hs_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "hsc2hs_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "hsc2hs_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "hsc2hs_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '\\'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/' || c == '\\'
