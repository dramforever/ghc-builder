{ nixpkgs ? import <nixpkgs> {}
}:

with nixpkgs;

let
    getFile = path:
        builtins.replaceStrings ["\n"] [""] (builtins.readFile path);

    revision = getFile ./revision.txt;
    version = getFile ./version.txt;

in rec {
    ghc = (haskell.compiler.ghcHEAD.override (oldAttrs: {
        inherit version;
        selfPkgs = packages;
    })).overrideAttrs (oldAttrs: {
        src = fetchgit {
            url = "./ghc";
            rev = revision;
        };
        makeFlags = [ "-j2" ];
    });

    packages = haskell.packages.ghcHEAD.override (oldAttrs: {
        inherit ghc;
    });
}
