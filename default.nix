let
  pkgs = import <nixpkgs> {
    overlays = [ (import ./overlay.nix) ];
  };

in

{ inherit (pkgs) ghc-custom; }
