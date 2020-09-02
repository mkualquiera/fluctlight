{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_fluctlight (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
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
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/juan/projects/fluctlight/.stack-work/install/x86_64-linux-tinfo6/85b81bd88ded3f09e5bf0de47f4daa4b949efb6ac4a8dd720e8eb28ac1566b55/8.8.4/bin"
libdir     = "/home/juan/projects/fluctlight/.stack-work/install/x86_64-linux-tinfo6/85b81bd88ded3f09e5bf0de47f4daa4b949efb6ac4a8dd720e8eb28ac1566b55/8.8.4/lib/x86_64-linux-ghc-8.8.4/fluctlight-0.1.0.0-5xhnmGK2BBG4eWzduodBaj"
dynlibdir  = "/home/juan/projects/fluctlight/.stack-work/install/x86_64-linux-tinfo6/85b81bd88ded3f09e5bf0de47f4daa4b949efb6ac4a8dd720e8eb28ac1566b55/8.8.4/lib/x86_64-linux-ghc-8.8.4"
datadir    = "/home/juan/projects/fluctlight/.stack-work/install/x86_64-linux-tinfo6/85b81bd88ded3f09e5bf0de47f4daa4b949efb6ac4a8dd720e8eb28ac1566b55/8.8.4/share/x86_64-linux-ghc-8.8.4/fluctlight-0.1.0.0"
libexecdir = "/home/juan/projects/fluctlight/.stack-work/install/x86_64-linux-tinfo6/85b81bd88ded3f09e5bf0de47f4daa4b949efb6ac4a8dd720e8eb28ac1566b55/8.8.4/libexec/x86_64-linux-ghc-8.8.4/fluctlight-0.1.0.0"
sysconfdir = "/home/juan/projects/fluctlight/.stack-work/install/x86_64-linux-tinfo6/85b81bd88ded3f09e5bf0de47f4daa4b949efb6ac4a8dd720e8eb28ac1566b55/8.8.4/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "fluctlight_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "fluctlight_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "fluctlight_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "fluctlight_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "fluctlight_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "fluctlight_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
