{ version
, nixpkgs ? import <nixpkgs> {}
}:

with nixpkgs;

rec {
    ghc = (haskell.compiler.ghcHEAD.override (oldAttrs: {
        inherit version;
        selfPkgs = packages;
    })).overrideAttrs (oldAttrs: {
        src = ./ghc;
    });

    packages = haskell.packages.ghcHEAD.override (oldAttrs: {
        inherit ghc;
    });
}
