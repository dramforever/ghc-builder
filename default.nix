with import <nixpkgs> {};

let
    fromFile = path: builtins.replaceStrings ["\n"] [""] (builtins.readFile path);
    rev = fromFile ./revision.txt;
    version = fromFile ./version.txt;
in

rec {
    ghc = (haskell.compiler.ghcHEAD.override (oldAttrs: {
        inherit version;
    })).overrideAttrs (oldAttrs: {
        src = ./ghc;
        makeFlags = [ "-j4" ];
    });
}
