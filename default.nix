{ version
, nixpkgs ? import <nixpkgs> {}
}:

with nixpkgs;

rec {
    ghc = (haskell.compiler.ghcHEAD.override (oldAttrs: {
        selfPkgs = packages;
    })).overrideAttrs (oldAttrs: {
        inherit version;
        src = ./ghc;
        makeFlags = [ "-j4" ];
    });

    packages = haskell.packages.ghcHEAD.override (oldAttrs: {
        inherit ghc;
    });
}
