{ version
, nixpkgs ? import <nixpkgs> {}
}:

with nixpkgs;

{
    ghc = (haskell.compiler.ghcHEAD.override (oldAttrs: {
        bootPkgs = haskell.packages.ghc822;
    })).overrideAttrs (oldAttrs: {
        inherit version;
        src = ./ghc;
    });
}
