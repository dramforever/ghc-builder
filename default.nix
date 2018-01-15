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
        makeFlags = [ "-j2" ];
    });

    packages = haskell.packages.ghcHEAD.override (oldAttrs: {
        inherit ghc;
    });
}
