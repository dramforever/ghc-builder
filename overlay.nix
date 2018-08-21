self: super: {
  ghc-custom-boot = self.haskell.packages.ghc843.override {
    overrides = selfHs: superHs: {
      alex = self.haskell.lib.dontCheck superHs.alex;
      happy = self.haskell.lib.dontCheck superHs.happy;
      hscolour = self.haskell.lib.dontCheck superHs.hscolour;
    };
  };

  ghc-custom = self.callPackage ./ghc.nix rec {
    bootPkgs = self.ghc-custom-boot;
    buildLlvmPackages = self.buildPackages.llvmPackages_6;
    inherit (bootPkgs) alex happy hscolour;
    llvmPackages = self.llvmPackages_6;
    enableShared = true;
  };

  haskellPackages-ghc-custom = self.callPackage <nixpkgs/pkgs/development/haskell-modules> {
    buildHaskellPackages = self.buildPackages.haskellPackages-ghc-custom;
    ghc = self.ghc-custom;
    compilerConfig = self.callPackage <nixpkgs/pkgs/development/haskell-modules/configuration-ghc-head.nix> {
      haskellLib = self.haskell.lib;
    };
    haskellLib = self.haskell.lib;
  };
}
