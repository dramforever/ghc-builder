let
  nixpkgsSrc = fetchTarball {
    url = "https://releases.nixos.org/nixpkgs/nixpkgs-18.09pre150352.7c826371c49/nixexprs.tar.xz";
    sha256 = "1kih50sp79bvzkbs672gdnw8iqlfxy9nmaipcphdjqad7331as1b";
  };

  pkgs = import nixpkgsSrc {
    overlays = [ (import ./overlay.nix) ];
  };

in

{ inherit (pkgs) ghc-custom; }
