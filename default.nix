with import <nixpkgs> {};

let
    fromFile = path: builtins.replaceStrings ["\n"] [""] (builtins.readFile path);
    rev = fromFile ./revision.txt;
    version = fromFile ./version.txt;
in

rec {
    ghc = (haskell.compiler.ghcHEAD.override (oldAttrs: {
        inherit version;
        selfPkgs = packages;
    })).overrideAttrs (oldAttrs: {
        inherit rev;
        src = ./ghc;
        makeFlags = [ "-j4" ];
        preConfigure = ''
            echo ${version} >VERSION
            echo ${rev} >GIT_COMMIT_ID
            ./boot
            sed -i -e 's|-isysroot /Developer/SDKs/MacOSX10.5.sdk||' configure
        '';
    });

    packages = haskell.packages.ghcHEAD.override (oldAttrs: {
        inherit ghc;
    });
}
